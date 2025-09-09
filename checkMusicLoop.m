function checkMusicLoop(~, ~)
    fig = gcf;
    bgMusicPlayer = getappdata(fig, 'bgMusicPlayer');
    audio = getappdata(fig, 'audio');
    musicVolume = getappdata(fig, 'musicVolume');

    if ~isempty(bgMusicPlayer) && ~isplaying(bgMusicPlayer)
        bgMusicPlayer = audioplayer(audio.bgMusic * musicVolume, audio.bgFs);
        play(bgMusicPlayer);
        setappdata(fig, 'bgMusicPlayer', bgMusicPlayer);
    end
end