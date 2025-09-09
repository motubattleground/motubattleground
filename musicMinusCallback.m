function musicMinusCallback(src, event)
    fig = ancestor(src, 'figure');
    playClickSound(fig);
    musicVolume = getappdata(fig, 'musicVolume');
    musicVolume = max(0, musicVolume - 0.1);
    setappdata(fig, 'musicVolume', musicVolume);
    volumeLevel = round(musicVolume * 100 / 10) * 10;
    imgMusicVolume = findobj(fig, 'Tag', 'imgMusicVolume');
    images = getappdata(fig, 'images');
    set(imgMusicVolume, 'CData', images.volumeLevels(volumeLevel));

    bgMusicPlayer = getappdata(fig, 'bgMusicPlayer');
    if ~isempty(bgMusicPlayer) && isplaying(bgMusicPlayer)
        stop(bgMusicPlayer);
    end
    audio = getappdata(fig, 'audio');
    if ~isempty(audio.bgMusic) && ~isempty(audio.bgFs)
        try
            bgMusicPlayer = audioplayer(audio.bgMusic * musicVolume, audio.bgFs);
            play(bgMusicPlayer);
            setappdata(fig, 'bgMusicPlayer', bgMusicPlayer);
        catch e
            disp('Error al reiniciar la música con nuevo volumen: ');
            disp(e.message);
        end
    end
end