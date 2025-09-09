function savedGamesMenu(fig)
    if ~isvalid(fig)
        disp('Error: La figura no es válida en savedGamesMenu');
        return;
    end
    setappdata(fig, 'currentMenu', 'savedGames');
    set(fig, 'Name', 'Partidas Guardadas');

    % Obtener dimensiones de la pantalla desde appdata
    screenWidth = getappdata(fig, 'screenWidth');
    screenHeight = getappdata(fig, 'screenHeight');

    delete(gca(fig));
    delete(findall(fig, 'Style', 'pushbutton'));

    ax = axes('Parent', fig, 'Position', [0, 0, 1, 1], ...
        'XTick', [], 'YTick', [], 'Box', 'off', 'XColor', 'none', 'YColor', 'none');
    images = getappdata(fig, 'images');
    try
        img = images.background;
        image(img, 'Parent', ax);
        ax.XLim = [0 size(img, 2)];
        ax.YLim = [0 size(img, 1)];
    catch e
        disp('Error al cargar la imagen de fondo bkg_intro.jpg: ');
        disp(e.message);
        set(ax, 'Color', [1 1 1]);
    end

    % Título del menú
    titleWidth = 700;
    titleHeight = 140;
    titleControl = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [(screenWidth-titleWidth)/2, screenHeight-400, titleWidth, titleHeight], ...
        'CData', images.savedGamesTitle, ...
        'Enable', 'inactive');

    % Configuración de la matriz de 4 filas x 5 columnas
    buttonWidth = 300;
    buttonHeight = 64;
    spacingX = 10;
    spacingY = 20;
    vacio1Width = 100;
    vacio2Width = 100;
    vacio3Width = 100;
    totalWidth = vacio1Width + vacio2Width + vacio3Width + spacingX + buttonWidth + spacingX + buttonWidth; % 100 + 100 + 100 + 10 + 300 + 10 + 300 = 920
    startX = (screenWidth - totalWidth) / 2;
    startY = 490;

    % Matriz de imágenes
    for row = 1:4
        yPos = startY - (row-1) * (buttonHeight + spacingY);

        % Primera columna: vacio1.png
        uicontrol(fig, 'Style', 'pushbutton', ...
            'Position', [startX, yPos, vacio1Width, buttonHeight], ...
            'CData', images.vacio1, ...
            'Enable', 'inactive', ...
            'Tag', ['vacio1_row' num2str(row)]);

        % Segunda columna: vacio2.png
        uicontrol(fig, 'Style', 'pushbutton', ...
            'Position', [startX + vacio1Width, yPos, vacio2Width, buttonHeight], ...
            'CData', images.vacio2, ...
            'Enable', 'inactive', ...
            'Tag', ['vacio2_row' num2str(row)]);

        % Tercera columna: vacio3.png
        uicontrol(fig, 'Style', 'pushbutton', ...
            'Position', [startX + vacio1Width + vacio2Width, yPos, vacio3Width, buttonHeight], ...
            'CData', images.vacio3, ...
            'Enable', 'inactive', ...
            'Tag', ['vacio3_row' num2str(row)]);

        % Cuarta columna: jugar0.png
        uicontrol(fig, 'Style', 'pushbutton', ...
            'Position', [startX + vacio1Width + vacio2Width + vacio3Width + spacingX, yPos, buttonWidth, buttonHeight], ...
            'CData', images.play, ...
            'Enable', 'inactive', ...
            'Tag', ['play' num2str(row)]);

        % Quinta columna: borrar0.png
        uicontrol(fig, 'Style', 'pushbutton', ...
            'Position', [startX + vacio1Width + vacio2Width + vacio3Width + spacingX + buttonWidth + spacingX, yPos, buttonWidth, buttonHeight], ...
            'CData', images.delete, ...
            'Enable', 'inactive', ...
            'Tag', ['delete' num2str(row)]);
    end

    % Botón de volver
    btnReturn = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [screenWidth-340, 20, 320, 64], ...
        'CData', images.return, ...
        'Callback', @(~, ~) callbackWithSound(fig, @returnToMainMenu, false), ...
        'Tag', 'btnReturn');
    uistack(btnReturn, 'top');

    drawnow;
end