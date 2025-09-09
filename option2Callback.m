function option2Callback(src, event)
    fig = ancestor(src, 'figure');
    playClickSound(fig);
    classicMenu(fig);
end