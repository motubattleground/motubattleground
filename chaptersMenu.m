function chaptersMenu(fig, previousMenu)
    if ~isvalid(fig)
        disp('Error: La figura no es válida en chaptersMenu');
        return;
    end
    setappdata(fig, 'currentMenu', 'chapters');
    setappdata(fig, 'previousMenu', previousMenu); % Almacenar previousMenu en appdata
    set(fig, 'Name', 'Capítulos');

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
        'Position', [(screenWidth-titleWidth)/2, screenHeight-300, titleWidth, titleHeight], ...
        'CData', images.chaptersTitle, ...
        'Enable', 'inactive');

    % Botón del capítulo seleccionado
    currentChapter = getappdata(fig, 'currentChapter');
    if isempty(currentChapter)
        currentChapter = 1;
        setappdata(fig, 'currentChapter', currentChapter);
    end
    buttonWidth = 400;
    buttonHeight = 400;
    startX = (screenWidth - buttonWidth) / 2;
    startY = screenHeight/2 - buttonHeight/2;
    btnChapter = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [startX, startY, buttonWidth, buttonHeight], ...
        'CData', images.(['chapter' num2str(currentChapter)]), ...
        'Callback', @(~, ~) selectChapter(fig, currentChapter), ...
        'Tag', ['btnChapter' num2str(currentChapter)]);

    % Mapeo de currentChapter a nombres de imágenes de campos
    fieldsMap = containers.Map('KeyType', 'double', 'ValueType', 'char');
    fieldsMap(1) = 'fields1_6';
    fieldsMap(2) = 'fields7_13';
    fieldsMap(3) = 'fields14_19';
    fieldsMap(4) = 'fields20_25';
    fieldsMap(5) = 'fields26_29';
    fieldsMap(6) = 'fields30_31';
    fieldsMap(7) = 'fields32_35';
    fieldsMap(8) = 'fields36_37';

    % Botón de selección de campos
    fieldsButtonWidth = 400;
    fieldsButtonHeight = 80;
    fieldsImage = fieldsMap(currentChapter);
    btnFields = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [(screenWidth-fieldsButtonWidth)/2, startY-100, fieldsButtonWidth, fieldsButtonHeight], ...
        'CData', images.(fieldsImage), ...
        'Callback', @(~, ~) selectFields(fig), ...
        'Tag', 'btnFields');

    % Imagen de la página (oneOf.png, twoOf.png, etc.)
    pageImageWidth = 400;
    pageImageHeight = 80;
    pageImageY = startY-200;
    pageImageControl = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [(screenWidth-pageImageWidth)/2, pageImageY, pageImageWidth, pageImageHeight], ...
        'CData', images.([mapNumberToWord(currentChapter) 'Of']), ...
        'Enable', 'inactive', ...
        'Tag', 'pageImage');

    % Botones de paginación (alineados con la imagen de la página)
    pageButtonWidth = 400;
    pageButtonHeight = 80;
    spacingX = 40;
    if currentChapter > 1
        btnPrevious = uicontrol(fig, 'Style', 'pushbutton', ...
            'Position', [(screenWidth-pageImageWidth)/2 - pageButtonWidth - spacingX, pageImageY, pageButtonWidth, pageButtonHeight], ...
            'CData', images.previous, ...
            'Callback', @(~, ~) previousPage(fig), ...
            'Tag', 'btnPrevious');
    end

    if currentChapter < 8
        btnNext = uicontrol(fig, 'Style', 'pushbutton', ...
            'Position', [(screenWidth+pageImageWidth)/2 + spacingX, pageImageY, pageButtonWidth, pageButtonHeight], ...
            'CData', images.next, ...
            'Callback', @(~, ~) nextPage(fig), ...
            'Tag', 'btnNext');
    end

    % Botón de volver
    btnReturn = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [screenWidth-340, 20, 320, 64], ...
        'CData', images.return, ...
        'Callback', @(~, ~) callbackWithSound(fig, previousMenu, false), ...
        'Tag', 'btnReturn');
    uistack(btnReturn, 'top');

    % Actualizar visibilidad de botones según el capítulo
    updateChapterButtons(fig);
    drawnow;
end