function versionMenu(fig)
    setappdata(fig, 'currentMenu', 'version');
    set(fig, 'Name', 'Versión');

    % Obtener dimensiones de la pantalla desde appdata
    screenWidth = getappdata(fig, 'screenWidth');
    screenHeight = getappdata(fig, 'screenHeight');

    delete(gca(fig));
    delete(findall(fig, 'Style', 'pushbutton'));

    ax = axes('Parent', fig, 'Position', [0, 0, 1, 1], ...
        'XTick', [], 'YTick', [], 'Box', 'off', 'XColor', 'none', 'YColor', 'none');
    images = getappdata(fig, 'images');
    try
        img = images.versionBackground;
        image(img, 'Parent', ax);
        ax.XLim = [0 size(img, 2)];
        ax.YLim = [0 size(img, 1)];
    catch e
        disp('Error al cargar la imagen version1.0.png: ');
        disp(e.message);
        set(ax, 'Color', [1 1 1]);
    end

    btnReturn = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [screenWidth-340, 20, 320, 64], ...
        'CData', images.return, ...
        'Callback', @(~, ~)returnCallback(fig), ...
        'Tag', 'btnReturn');
    uistack(btnReturn, 'top');
    drawnow;
end