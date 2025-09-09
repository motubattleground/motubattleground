function twoPlayersCallback(src, event)
    fig = ancestor(src, 'figure');
    playClickSound(fig);
    setappdata(fig, 'currentChapter', 1);
    chaptersMenu(fig);
end