function selectFields(fig, chapter)
    % Verificar que la figura es válida
    if nargin < 2 || ~isvalid(fig)
        disp('Error: La figura no es válida o no se proporcionó chapter en selectFields');
        return;
    end

    % Reproducir sonido de clic
    playClickSound(fig);

    % Establecer el menú actual
    setappdata(fig, 'currentMenu', 'fields');
    set(fig, 'Name', ['Selección de Campos - Capítulo ' num2str(chapter)]);

    % Obtener datos de appdata
    screenWidth = getappdata(fig, 'screenWidth');
    screenHeight = getappdata(fig, 'screenHeight');
    images = getappdata(fig, 'images');
    numPlayers = getappdata(fig, 'numPlayers'); % 1, 2 o 4
    gameMode = getappdata(fig, 'gameMode'); % 'classic' o 'campaign'
    previousMenu = getappdata(fig, 'previousMenu'); % Obtener previousMenu
    setappdata(fig, 'currentChapter', chapter);

    % Inferir gameMode si no está definido
    if ~ischar(gameMode) || ~ismember(gameMode, {'classic', 'campaign'})
        if isequal(previousMenu, @campaignMenu) || isequal(previousMenu, @newGameMenu)
            gameMode = 'campaign';
            disp('gameMode no definido. Inferido como campaign desde previousMenu.');
        else
            gameMode = 'classic';
            disp(['gameMode no definido. Inferido como classic desde previousMenu=' func2str(previousMenu) '.']);
        end
    end
    disp(['Modo de juego detectado: ' gameMode ', numPlayers: ' num2str(numPlayers)]);

    % Limpiar figura
    delete(gca(fig));
    delete(findall(fig, 'Style', 'pushbutton'));

    % Fondo
    ax = axes('Parent', fig, 'Position', [0, 0, 1, 1], ...
        'XTick', [], 'YTick', [], 'Box', 'off', 'XColor', 'none', 'YColor', 'none');
    try
        image(images.background, 'Parent', ax);
        ax.XLim = [0 size(images.background, 2)];
        ax.YLim = [0 size(images.background, 1)];
        disp('Fondo cargado en selectFields.');
    catch e
        disp(['Error al cargar fondo: ' e.message]);
        set(ax, 'Color', [1 1 1]);
    end

    % Título
    titleWidth = 700; % Según loadResources: 140x700
    titleHeight = 140;
    titleY = screenHeight - 310; % Ajustado 10 píxeles hacia abajo
    try
        titleField = ['fields' num2str(getFieldStart(chapter)) '_' num2str(getFieldEnd(chapter))];
        if isfield(images, titleField) && ismember(chapter, 1:8)
            scaledTitle = imresize(images.(titleField), [140, 700]);
            uicontrol(fig, 'Style', 'pushbutton', ...
                'Position', [(screenWidth-titleWidth)/2, titleY, titleWidth, titleHeight], ...
                'CData', scaledTitle, ...
                'Enable', 'inactive', ...
                'Tag', 'titleFields');
            disp(['Título ' titleField ' cargado (escalado a 140x700).']);
        else
            disp(['Error: ' titleField ' no encontrada o capítulo inválido. Campos disponibles:']);
            disp(fieldnames(images));
            uicontrol(fig, 'Style', 'pushbutton', ...
                'Position', [(screenWidth-titleWidth)/2, titleY, titleWidth, titleHeight], ...
                'BackgroundColor', [0.5 0.5 0.5], ...
                'Enable', 'inactive', ...
                'Tag', 'titleFields');
        end
    catch e
        disp(['Error al crear título: ' e.message]);
    end

    % Botones de campos
    buttonWidth = 400; % Según loadResources: 80x400
    buttonHeight = 80;
    spacingY = 10;
    spacingX = 20;
    numFields = getNumFields(chapter); % Número de campos por capítulo
    totalHeight = numFields * buttonHeight + (numFields - 1) * spacingY;
    startX = (screenWidth - buttonWidth) / 2; % Centro
    startY = (screenHeight - totalHeight - 300) / 2 + 144 - 44 - 44 - 80 + 10 + 30 - 10; % y=581 (arriba, ajustado -10)
    leftX = startX - buttonWidth - spacingX; % Columna izquierda
    rightX = startX + buttonWidth + spacingX; % Columna derecha
    headerY = startY + (numFields-1) * (buttonHeight + spacingY) + buttonHeight + 10 + 80 - 10 - 30 - 50 + 10 - 10; % y=551

    if ismember(chapter, 1:8)
        fieldNames = getFieldNames(chapter); % Campos por capítulo
        if strcmp(gameMode, 'campaign')
            % Columna central: imágenes (no botones)
            for i = 1:numFields
                fieldName = fieldNames{i};
                yPos = startY + (numFields-i) * (buttonHeight + spacingY); % Orden inverso
                try
                    if isfield(images, fieldName)
                        uicontrol(fig, 'Style', 'pushbutton', ...
                            'Position', [startX, yPos, buttonWidth, buttonHeight], ...
                            'CData', images.(fieldName), ...
                            'Enable', 'inactive', ...
                            'Tag', ['imgField' num2str(i)]);
                        disp(['Imagen campo ' num2str(i) ' (' fieldName ') cargada en y=' num2str(yPos)]);
                    else
                        disp(['Error: Imagen ' fieldName ' no encontrada. Campos disponibles:']);
                        disp(fieldnames(images));
                        uicontrol(fig, 'Style', 'pushbutton', ...
                            'Position', [startX, yPos, buttonWidth, buttonHeight], ...
                            'BackgroundColor', [0.5 0.5 0.5], ...
                            'Enable', 'inactive', ...
                            'Tag', ['imgField' num2str(i)]);
                    end
                catch e
                    disp(['Error al crear imagen ' fieldName ': ' e.message]);
                end
            end

            % Columna izquierda: botones campoX_1j_a.png o campoX_2j_a.png
            if numPlayers == 1
                fieldNamesA = cellfun(@(x) [x '_1j_a'], fieldNames, 'UniformOutput', false);
            elseif numPlayers == 2
                fieldNamesA = cellfun(@(x) [x '_2j_a'], fieldNames, 'UniformOutput', false);
            else
                fieldNamesA = {};
            end
            for i = 1:numFields
                fieldName = fieldNamesA{i};
                yPos = startY + (numFields-i) * (buttonHeight + spacingY); % Alineado con central
                try
                    if isfield(images, fieldName)
                        uicontrol(fig, 'Style', 'pushbutton', ...
                            'Position', [leftX, yPos, buttonWidth, buttonHeight], ...
                            'CData', images.(fieldName), ...
                            'Callback', @(~, ~) callbackWithSound(fig, @(f) startGame(f, i, 'good', 'evil'), true), ...
                            'Tag', ['btnFieldA' num2str(i)]);
                        disp(['Botón campo ' num2str(i) ' (' fieldName ') cargado en x=' num2str(leftX) ', y=' num2str(yPos)]);
                    else
                        disp(['Error: Imagen ' fieldName ' no encontrada. Campos disponibles:']);
                        disp(fieldnames(images));
                        uicontrol(fig, 'Style', 'pushbutton', ...
                            'Position', [leftX, yPos, buttonWidth, buttonHeight], ...
                            'BackgroundColor', [0.5 0.5 0.5], ...
                            'Callback', @(~, ~) callbackWithSound(fig, @(f) startGame(f, i, 'good', 'evil'), true), ...
                            'Tag', ['btnFieldA' num2str(i)]);
                    end
                catch e
                    disp(['Error al crear botón ' fieldName ': ' e.message]);
                end
            end

            % Columna derecha: botones campoX_1j_b.png o campoX_2j_b.png
            if numPlayers == 1
                fieldNamesB = cellfun(@(x) [x '_1j_b'], fieldNames, 'UniformOutput', false);
            elseif numPlayers == 2
                fieldNamesB = cellfun(@(x) [x '_2j_b'], fieldNames, 'UniformOutput', false);
            else
                fieldNamesB = {};
            end
            for i = 1:numFields
                fieldName = fieldNamesB{i};
                yPos = startY + (numFields-i) * (buttonHeight + spacingY); % Alineado con central
                try
                    if isfield(images, fieldName)
                        uicontrol(fig, 'Style', 'pushbutton', ...
                            'Position', [rightX, yPos, buttonWidth, buttonHeight], ...
                            'CData', images.(fieldName), ...
                            'Callback', @(~, ~) callbackWithSound(fig, @(f) startGame(f, i, 'evil', 'good'), true), ...
                            'Tag', ['btnFieldB' num2str(i)]);
                        disp(['Botón campo ' num2str(i) ' (' fieldName ') cargado en x=' num2str(rightX) ', y=' num2str(yPos)]);
                    else
                        disp(['Error: Imagen ' fieldName ' no encontrada. Campos disponibles:']);
                        disp(fieldnames(images));
                        uicontrol(fig, 'Style', 'pushbutton', ...
                            'Position', [rightX, yPos, buttonWidth, buttonHeight], ...
                            'BackgroundColor', [0.5 0.5 0.5], ...
                            'Callback', @(~, ~) callbackWithSound(fig, @(f) startGame(f, i, 'evil', 'good'), true), ...
                            'Tag', ['btnFieldB' num2str(i)]);
                    end
                catch e
                    disp(['Error al crear botón ' fieldName ': ' e.message]);
                end
            end

            % Encabezados de columnas
            headerWidth = 400;
            headerHeight = 80;
            try
                if isfield(images, 'goodSide')
                    uicontrol(fig, 'Style', 'pushbutton', ...
                        'Position', [leftX, headerY, headerWidth, headerHeight], ...
                        'CData', images.goodSide, ...
                        'Enable', 'inactive', ...
                        'Tag', 'headerGood');
                    disp(['Encabezado bandodelbien cargado en x=' num2str(leftX) ', y=' num2str(headerY)]);
                else
                    disp('Error: Imagen goodSide no encontrada.');
                    uicontrol(fig, 'Style', 'pushbutton', ...
                        'Position', [leftX, headerY, headerWidth, headerHeight], ...
                        'BackgroundColor', [0.5 0.5 0.5], ...
                        'Enable', 'inactive', ...
                        'Tag', 'headerGood');
                end
                if isfield(images, 'evilSide')
                    uicontrol(fig, 'Style', 'pushbutton', ...
                        'Position', [rightX, headerY, headerWidth, headerHeight], ...
                        'CData', images.evilSide, ...
                        'Enable', 'inactive', ...
                        'Tag', 'headerEvil');
                    disp(['Encabezado bandodelmal cargado en x=' num2str(rightX) ', y=' num2str(headerY)]);
                else
                    disp('Error: Imagen evilSide no encontrada.');
                    uicontrol(fig, 'Style', 'pushbutton', ...
                        'Position', [rightX, headerY, headerWidth, headerHeight], ...
                        'BackgroundColor', [0.5 0.5 0.5], ...
                        'Enable', 'inactive', ...
                        'Tag', 'headerEvil');
                end
            catch e
                disp(['Error al crear encabezados: ' e.message]);
            end
        elseif strcmp(gameMode, 'classic') % Modo clásico (2 o 4 jugadores)
            for i = 1:numFields
                fieldName = fieldNames{i};
                yPos = startY + (numFields-i) * (buttonHeight + spacingY); % Orden inverso
                try
                    if isfield(images, fieldName)
                        uicontrol(fig, 'Style', 'pushbutton', ...
                            'Position', [startX, yPos, buttonWidth, buttonHeight], ...
                            'CData', images.(fieldName), ...
                            'Callback', @(~, ~) callbackWithSound(fig, @(f) startGame(f, i), true), ...
                            'Tag', ['btnField' num2str(i)]);
                        disp(['Botón campo ' num2str(i) ' (' fieldName ') cargado en y=' num2str(yPos)]);
                    else
                        disp(['Error: Imagen ' fieldName ' no encontrada. Campos disponibles:']);
                        disp(fieldnames(images));
                        uicontrol(fig, 'Style', 'pushbutton', ...
                            'Position', [startX, yPos, buttonWidth, buttonHeight], ...
                            'BackgroundColor', [0.5 0.5 0.5], ...
                            'Callback', @(~, ~) callbackWithSound(fig, @(f) startGame(f, i), true), ...
                            'Tag', ['btnField' num2str(i)]);
                    end
                catch e
                    disp(['Error al crear botón ' fieldName ': ' e.message]);
                end
            end
        end
    else
        disp(['Capítulo ' num2str(chapter) ' no implementado aún.']);
    end

    % Botón de volver (con sonido sfx_back.mp3)
    try
        returnWidth = 320; % Según loadResources: 64x320
        returnHeight = 64;
        uicontrol(fig, 'Style', 'pushbutton', ...
            'Position', [screenWidth-returnWidth-20, 20, returnWidth, returnHeight], ...
            'CData', images.return, ...
            'Callback', @(~, ~) callbackWithSound(fig, @(f) chaptersMenu(f, previousMenu), false), ...
            'Tag', 'btnReturn');
        disp(['Botón volver cargado en selectFields con sonido sfx_back.mp3, regresa a ' func2str(previousMenu)]);
    catch e
        disp(['Error al crear botón de volver: ' e.message]);
    end

    drawnow;
end

function startGame(fig, field, side1, side2)
    % Placeholder: Iniciar el juego con el campo y bandos seleccionados
    if nargin < 4
        side2 = 'none'; % Para modo clásico o 1 jugador
        if nargin < 3
            side1 = 'none'; % Para modo clásico
        end
    end
    disp(['Iniciando juego con campo ' num2str(field) ', bando Jugador 1: ' side1 ', bando Jugador 2: ' side2 ', y ' num2str(getappdata(fig, 'numPlayers')) ' jugadores']);
    % Aquí iría la lógica para cargar el mapa del campo y configurar los bandos
end

function numFields = getNumFields(chapter)
    % Devuelve el número de campos por capítulo
    switch chapter
        case 1
            numFields = 6; % Campos 1-6
        case 2
            numFields = 7; % Campos 7-13
        case 3
            numFields = 6; % Campos 14-19
        case 4
            numFields = 6; % Campos 20-25
        case 5
            numFields = 4; % Campos 26-29
        case 6
            numFields = 2; % Campos 30-31
        case 7
            numFields = 4; % Campos 32-35
        case 8
            numFields = 2; % Campos 36-37
        otherwise
            numFields = 0;
    end
end

function fieldNames = getFieldNames(chapter)
    % Devuelve los nombres de los campos por capítulo
    switch chapter
        case 1
            fieldNames = {'field1', 'field2', 'field3', 'field4', 'field5', 'field6'};
        case 2
            fieldNames = {'field7', 'field8', 'field9', 'field10', 'field11', 'field12', 'field13'};
        case 3
            fieldNames = {'field14', 'field15', 'field16', 'field17', 'field18', 'field19'};
        case 4
            fieldNames = {'field20', 'field21', 'field22', 'field23', 'field24', 'field25'};
        case 5
            fieldNames = {'field26', 'field27', 'field28', 'field29'};
        case 6
            fieldNames = {'field30', 'field31'};
        case 7
            fieldNames = {'field32', 'field33', 'field34', 'field35'};
        case 8
            fieldNames = {'field36', 'field37'};
        otherwise
            fieldNames = {};
    end
end

function fieldStart = getFieldStart(chapter)
    % Devuelve el primer campo del capítulo
    switch chapter
        case 1
            fieldStart = 1;
        case 2
            fieldStart = 7;
        case 3
            fieldStart = 14;
        case 4
            fieldStart = 20;
        case 5
            fieldStart = 26;
        case 6
            fieldStart = 30;
        case 7
            fieldStart = 32;
        case 8
            fieldStart = 36;
        otherwise
            fieldStart = 0;
    end
end

function fieldEnd = getFieldEnd(chapter)
    % Devuelve el último campo del capítulo
    switch chapter
        case 1
            fieldEnd = 6;
        case 2
            fieldEnd = 13;
        case 3
            fieldEnd = 19;
        case 4
            fieldEnd = 25;
        case 5
            fieldEnd = 29;
        case 6
            fieldEnd = 31;
        case 7
            fieldEnd = 35;
        case 8
            fieldEnd = 37;
        otherwise
            fieldEnd = 0;
    end
end