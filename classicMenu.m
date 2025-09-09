function classicMenu(fig)
    setappdata(fig, 'currentMenu', 'classic');
    set(fig, 'Name', 'Modo Clásico');

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

    titleWidth = 700;
    titleHeight = 140;
    titleControl = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [(screenWidth-titleWidth)/2, screenHeight-400, titleWidth, titleHeight], ...
        'CData', images.classic, ...
        'Enable', 'inactive');

    buttonWidth = 400;
    buttonHeight = 80;
    totalButtonWidth = buttonWidth * 2 + 100;
    btn2Players = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [(screenWidth-totalButtonWidth)/2, screenHeight/2-40, buttonWidth, buttonHeight], ...
        'CData', images.twoPlayers, ...
        'Callback', @(~, ~) callbackWithSound(fig, @(f) selectPlayersAndOpenChapters(f, 2), true), ...
        'Tag', 'btn2Players');

    btn4Players = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [(screenWidth-totalButtonWidth)/2 + buttonWidth + 100, screenHeight/2-40, buttonWidth, buttonHeight], ...
        'CData', images.fourPlayers, ...
        'Callback', @(~, ~) callbackWithSound(fig, @(f) selectPlayersAndOpenChapters(f, 4), true), ...
        'Tag', 'btn4Players');

    btnReturn = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [screenWidth-340, 20, 320, 64], ...
        'CData', images.return, ...
        'Callback', @(~, ~) callbackWithSound(fig, @returnToMainMenu, false), ...
        'Tag', 'btnReturn');
    uistack(btnReturn, 'top');
    drawnow;
end

function selectPlayersAndOpenChapters(fig, numPlayers)
    setappdata(fig, 'numPlayers', numPlayers);
    chaptersMenu(fig, @classicMenu);
end