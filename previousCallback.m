function previousCallback(src, event)
    fig = ancestor(src, 'figure');
    playClickSound(fig);
    currentChapter = getappdata(fig, 'currentChapter');
    currentChapter = max(currentChapter - 1, 1);
    setappdata(fig, 'currentChapter', currentChapter);
    chaptersMenu(fig);
end