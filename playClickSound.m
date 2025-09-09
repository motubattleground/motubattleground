function playClickSound(fig)
    audio = getappdata(fig, 'audio');
    sfxVolume = getappdata(fig, 'sfxVolume');

    if ~isempty(audio.click) && ~isempty(audio.clickFs)
        try
            scaledAudio = audio.click * sfxVolume;
            clickPlayer = audioplayer(scaledAudio, audio.clickFs);
            playblocking(clickPlayer);
        catch e
            disp('Error al reproducir el sonido de clic: ');
            disp(e.message);
        end
    end
end