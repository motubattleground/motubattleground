function previousPage(fig)
    if ~isvalid(fig)
        disp('Error: La figura no es válida en previousPage');
        return;
    end

    % Reproducir sonido (para punto 3)
    playClickSound(fig);

    % Actualizar currentChapter
    currentChapter = getappdata(fig, 'currentChapter');
    if currentChapter > 1
        setappdata(fig, 'currentChapter', currentChapter - 1);
    end

    % Recuperar previousMenu y llamar a chaptersMenu preservándolo
    previousMenu = getappdata(fig, 'previousMenu');
    chaptersMenu(fig, previousMenu);
end