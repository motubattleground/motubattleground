function returnCallback(src, event)
    fig = ancestor(src, 'figure');
    playBackSound(fig);
    currentMenu = getappdata(fig, 'currentMenu');

    if strcmp(currentMenu, 'version') || strcmp(currentMenu, 'campaign') || strcmp(currentMenu, 'classic') || strcmp(currentMenu, 'chapters')
        showMainMenu(fig);
    elseif strcmp(currentMenu, 'savedGames')
        campaignMenu(fig);
    end
end