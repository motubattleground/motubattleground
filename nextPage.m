function nextPage(fig)
    currentChapter = getappdata(fig, 'currentChapter');
    if isempty(currentChapter)
        currentChapter = 1;
    end
    setappdata(fig, 'currentChapter', min(currentChapter + 1, 8));
    chaptersMenu(fig, @classicMenu); % Corregido para pasar @classicMenu
end