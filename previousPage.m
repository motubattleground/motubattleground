function previousPage(fig)
    currentChapter = getappdata(fig, 'currentChapter');
    if isempty(currentChapter)
        currentChapter = 1;
    end
    setappdata(fig, 'currentChapter', max(currentChapter - 1, 1));
    chaptersMenu(fig, @classicMenu); % Corregido para pasar @classicMenu
end