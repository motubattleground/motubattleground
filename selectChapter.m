function selectChapter(fig, chapter)
    % Reproduce el sonido de clic
    playClickSound(fig);

    % Actualizar currentChapter
    setappdata(fig, 'currentChapter', chapter);

    % Actualizar el menú de capítulos, pasando previousMenu
    previousMenu = getappdata(fig, 'previousMenu');
    chaptersMenu(fig, previousMenu);
end