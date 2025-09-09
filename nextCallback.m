function nextCallback(src, event)
    fig = ancestor(src, 'figure');
    playClickSound(fig);
    currentChapter = getappdata(fig, 'currentChapter');
    currentChapter = min(currentChapter + 1, 8);
    setappdata(fig, 'currentChapter', currentChapter);
    chaptersMenu(fig);
end