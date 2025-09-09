function versionCallback(src, event)
    fig = ancestor(src, 'figure');
    playClickSound(fig);
    versionMenu(fig);
end