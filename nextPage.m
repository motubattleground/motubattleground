function nextPage(fig)
    if ~isvalid(fig)
        disp('Error: La figura no es válida en nextPage');
        return;
    end

    % Reproducir sonido (para punto 3)
    playClickSound(fig);

    % Actualizar currentChapter
    currentChapter = getappdata(fig, 'currentChapter');
    if currentChapter < 8  % Asumiendo 8 capítulos
        setappdata(fig, 'currentChapter', currentChapter + 1);
    end

    % Recuperar previousMenu y llamar a chaptersMenu preservándolo
    previousMenu = getappdata(fig, 'previousMenu');
    chaptersMenu(fig, previousMenu);
end