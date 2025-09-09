function updateChapterButtons(fig, chapterGroups)
    if ~isvalid(fig)
        disp('Error: La figura no es válida en updateChapterButtons');
        return;
    end

    % Obtener datos
    images = getappdata(fig, 'images');
    currentChapter = getappdata(fig, 'currentChapter');
    if isempty(currentChapter)
        currentChapter = 1;
        setappdata(fig, 'currentChapter', currentChapter);
    end

    % Eliminar botones de capítulos existentes
    delete(findall(fig, 'Tag', 'chapterButton'));

    % Obtener dimensiones de la pantalla
    screenWidth = getappdata(fig, 'screenWidth');
    screenHeight = getappdata(fig, 'screenHeight');

    % Configurar botones de capítulos
    buttonWidth = 400;
    buttonHeight = 80;
    totalButtonWidth = buttonWidth * 2 + 100;

    % Mostrar el grupo de capítulos correspondiente
    group = chapterGroups{currentChapter};
    uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [(screenWidth-totalButtonWidth)/2, screenHeight/2-40, buttonWidth, buttonHeight], ...
        'CData', group.image, ...
        'Callback', @(~, ~) callbackWithSound(fig, @(f) selectChapter(f, group.fields), true), ... % Añadido callbackWithSound
        'Tag', 'chapterButton');

    % Actualizar imagen "X de 8"
    ofImages = {images.oneOf, images.twoOf, images.threeOf, images.fourOf, ...
                images.fiveOf, images.sixOf, images.sevenOf, images.eightOf};
    uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [(screenWidth-totalButtonWidth)/2 + buttonWidth + 100, screenHeight/2-40, buttonWidth, buttonHeight], ...
        'CData', ofImages{currentChapter}, ...
        'Enable', 'inactive', ...
        'Tag', 'chapterButton');
end

function selectChapter(fig, fields)
    setappdata(fig, 'selectedFields', fields);
    startGame(fig);
end