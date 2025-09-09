function skipVideo(fig)
    playClickSound(fig);
    setappdata(fig, 'skipFlag', true);
    showMainMenu(fig);
end