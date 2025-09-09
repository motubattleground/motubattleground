function newGameMenu(fig)
    if ~isvalid(fig)
        disp('Error: La figura no es válida en newGameMenu');
        return;
    end
    setappdata(fig, 'currentMenu', 'newGame');
    set(fig, 'Name', 'Nueva Partida');

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
        'CData', imresize(images.new, [140, 700]), ...
        'Enable', 'inactive');

    % Configuración de los botones
    buttonWidth = 400;
    buttonHeight = 80;
    spacingX = 100;
    totalWidth = 2 * buttonWidth + spacingX;
    startX = (screenWidth - totalWidth) / 2;
    startY = screenHeight/2 - 40;

    % Botón 1jugador.png
    btnOnePlayer = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [startX, startY, buttonWidth, buttonHeight], ...
        'CData', images.onePlayer, ...
        'Callback', @(~, ~) callbackWithSound(fig, @(f) selectPlayersAndOpenChapters(f, 1), true), ...
        'Tag', 'btnOnePlayer');

    % Botón 2jugadores.png
    btnTwoPlayers = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [startX + buttonWidth + spacingX, startY, buttonWidth, buttonHeight], ...
        'CData', images.twoPlayers, ...
        'Callback', @(~, ~) callbackWithSound(fig, @(f) selectPlayersAndOpenChapters(f, 2), true), ...
        'Tag', 'btnTwoPlayers');

    % Botón de volver
    btnReturn = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [screenWidth-340, 20, 320, 64], ...
        'CData', images.return, ...
        'Callback', @(~, ~) callbackWithSound(fig, @campaignMenu, false), ...
        'Tag', 'btnReturn');
    uistack(btnReturn, 'top');

    drawnow;
end

function selectPlayersAndOpenChapters(fig, numPlayers)
    setappdata(fig, 'numPlayers', numPlayers);
    chaptersMenu(fig, @newGameMenu);
end