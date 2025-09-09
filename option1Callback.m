function option1Callback(src, event)
    fig = ancestor(src, 'figure');
    playClickSound(fig);
    campaignMenu(fig);
end