function closeFigure(src, event)
    fig = src;
    bgMusicPlayer = getappdata(fig, 'bgMusicPlayer');
    musicTimer = getappdata(fig, 'musicTimer');

    if ~isempty(bgMusicPlayer) && isplaying(bgMusicPlayer)
        stop(bgMusicPlayer);
    end

    if ~isempty(musicTimer) && isvalid(musicTimer)
        stop(musicTimer);
        delete(musicTimer);
    end

    delete(fig);
end