function callbackWithSound(fig, callback, playClick)
    audio = getappdata(fig, 'audio');
    if playClick
        if ~isempty(audio.click) && ~isempty(audio.clickFs)
            disp('Reproduciendo sfx_click.mp3');
            sound(audio.click, audio.clickFs);
        else
            disp('Error: No se pudo reproducir sfx_click.mp3, audio.click o audio.clickFs está vacío');
        end
    else
        if ~isempty(audio.back) && ~isempty(audio.backFs)
            disp('Reproduciendo sfx_back.mp3');
            sound(audio.back, audio.backFs);
        else
            disp('Error: No se pudo reproducir sfx_back.mp3, audio.back o audio.backFs está vacío');
        end
    end
    callback(fig);
end