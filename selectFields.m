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

    % Título (campos1-6.png para capítulo 1)
    titleWidth = 700; % Según loadResources: 140x700
    titleHeight = 140;
    titleY = screenHeight - 300; % Como en chaptersMenu
    try
        if isfield(images, 'fields1_6') && chapter == 1
            scaledTitle = imresize(images.fields1_6, [140, 700]);
            uicontrol(fig, 'Style', 'pushbutton', ...
                'Position', [(screenWidth-titleWidth)/2, titleY, titleWidth, titleHeight], ...
                'CData', scaledTitle, ...
                'Enable', 'inactive', ...
                'Tag', 'titleFields');
            disp('Título fields1_6 cargado (escalado a 140x700).');
        else
            disp('Error: fields1_6 no encontrada o capítulo inválido. Campos disponibles:');
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

    % Botones de campos (capítulo 1)
    buttonWidth = 400; % Según loadResources: 80x400
    buttonHeight = 80;
    spacingY = 10;
    spacingX = 20;
    numFields = 6; % 6 campos para capítulo 1
    totalHeight = numFields * buttonHeight + (numFields - 1) * spacingY;
    startX = (screenWidth - buttonWidth) / 2; % Centro
    startY = (screenHeight - totalHeight - 300) / 2 + 144 - 44 - 44 - 80 + 10 + 30; % y=591 (arriba), y=141 (abajo)
    leftX = startX - buttonWidth - spacingX; % Columna izquierda
    rightX = startX + buttonWidth + spacingX; % Columna derecha
    headerY = startY + (numFields-1) * (buttonHeight + spacingY) + buttonHeight + 10 + 80 - 10 - 30 - 50 + 10; % y=561

    if chapter == 1
        fieldNames = {'field1', 'field2', 'field3', 'field4', 'field5', 'field6'};
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

            % Columna izquierda: botones campo1_1j_a.png para 1 jugador o campo1_2j_a.png para 2 jugadores
            if numPlayers == 1
                fieldNamesA = {'field1_1j_a', 'field2_1j_a', 'field3_1j_a', 'field4_1j_a', 'field5_1j_a', 'field6_1j_a'};
            elseif numPlayers == 2
                fieldNamesA = {'field1_2j_a', 'field2_2j_a', 'field3_2j_a', 'field4_2j_a', 'field5_2j_a', 'field6_2j_a'};
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

            % Columna derecha: botones campo1_1j_b.png para 1 jugador o campo1_2j_b.png para 2 jugadores
            if numPlayers == 1
                fieldNamesB = {'field1_1j_b', 'field2_1j_b', 'field3_1j_b', 'field4_1j_b', 'field5_1j_b', 'field6_1j_b'};
            elseif numPlayers == 2
                fieldNamesB = {'field1_2j_b', 'field2_2j_b', 'field3_2j_b', 'field4_2j_b', 'field5_2j_b', 'field6_2j_b'};
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