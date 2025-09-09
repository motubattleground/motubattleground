function motubattleground()
    fig = figure('Name', 'Masters of the Universe: Battleground', ...
        'MenuBar', 'none', 'NumberTitle', 'off', 'WindowState', 'maximized', ...
        'CloseRequestFcn', @closeFigure);

    screenSize = get(0, 'ScreenSize');
    screenWidth = screenSize(3);
    screenHeight = screenSize(4);

    currentMenu = 'video';
    currentChapter = 1;

    [images, audio] = loadResources();

    setappdata(fig, 'images', images);
    setappdata(fig, 'audio', audio);
    setappdata(fig, 'screenWidth', screenWidth);
    setappdata(fig, 'screenHeight', screenHeight);
    setappdata(fig, 'currentMenu', currentMenu);
    setappdata(fig, 'currentChapter', currentChapter);
    setappdata(fig, 'musicVolume', 1);
    setappdata(fig, 'sfxVolume', 1);
    setappdata(fig, 'skipFlag', false);

    set(fig, 'WindowButtonMotionFcn', @checkHover);

    playIntroVideo(fig);
end