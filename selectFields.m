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
    numPlayers = getappdata(fig, 'numPlayers'); % 2 o 4, desde classicMenu
    setappdata(fig, 'currentChapter', chapter);

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

    % Título (campos1-6.png para capítulo 1, tamaño como chaptersTitle)
    titleWidth = 700; % Según loadResources: 140x700
    titleHeight = 140;
    titleY = screenHeight - 300; % Como en chaptersMenu
    try
        if isfield(images, 'fields1_6') && chapter == 1
            % Escalar fields1_6 a [140, 700]
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

    % Botones de campos (campo1.png a campo6.png para capítulo 1)
    buttonWidth = 400; % Según loadResources: 80x400
    buttonHeight = 80;
    spacingY = 10;
    startX = (screenWidth - buttonWidth) / 2;
    numFields = 6; % 6 campos para capítulo 1
    totalHeight = numFields * buttonHeight + (numFields - 1) * spacingY;
    startY = (screenHeight - totalHeight - 300) / 2 + 144 - 44; % Subido 144px, bajado 44px

    if chapter == 1
        fieldNames = {'field1', 'field2', 'field3', 'field4', 'field5', 'field6'};
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
            'Callback', @(~, ~) callbackWithSound(fig, @(f) chaptersMenu(f, @classicMenu), false), ...
            'Tag', 'btnReturn');
        disp('Botón volver cargado en selectFields con sonido sfx_back.mp3.');
    catch e
        disp(['Error al crear botón de volver: ' e.message]);
    end

    drawnow;
end

function startGame(fig, field)
    % Placeholder: Iniciar el juego con el campo seleccionado
    disp(['Iniciando juego con campo ' num2str(field) ' y ' num2str(getappdata(fig, 'numPlayers')) ' jugadores']);
    % Aquí iría la lógica para cargar el mapa del campo y comenzar el juego
end