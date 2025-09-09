function sfxPlusCallback(src, event)
    fig = ancestor(src, 'figure');
    playClickSound(fig);
    sfxVolume = getappdata(fig, 'sfxVolume');
    sfxVolume = min(1, sfxVolume + 0.1);
    setappdata(fig, 'sfxVolume', sfxVolume);
    volumeLevel = round(sfxVolume * 100 / 10) * 10;
    imgSfxVolume = findobj(fig, 'Tag', 'imgSfxVolume');
    images = getappdata(fig, 'images');
    set(imgSfxVolume, 'CData', images.volumeLevels(volumeLevel));
end