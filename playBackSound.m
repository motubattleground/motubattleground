function playBackSound(fig)
    audio = getappdata(fig, 'audio');
    sfxVolume = getappdata(fig, 'sfxVolume');

    if ~isempty(audio.back) && ~isempty(audio.backFs)
        try
            scaledAudio = audio.back * sfxVolume;
            backPlayer = audioplayer(scaledAudio, audio.backFs);
            playblocking(backPlayer);
        catch e
            disp('Error al reproducir el sonido de retroceso: ');
            disp(e.message);
        end
    end
end