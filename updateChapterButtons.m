function updateChapterButtons(fig)
    if ~isvalid(fig)
        disp('Error: La figura no es válida en updateChapterButtons');
        return;
    end

    % Recuperar currentChapter de appdata (esto evita el error si no se pasaba como arg)
    currentChapter = getappdata(fig, 'currentChapter');
    if isempty(currentChapter)
        currentChapter = 1;  % Valor por defecto si no está seteado
    end

    % Definir chapterGroups como cell array (ajusta según tus necesidades, basado en fieldsMap)
    chapterGroups = {'fields1_6', 'fields7_13', 'fields14_19', 'fields20_25', ...
                     'fields26_29', 'fields30_31', 'fields32_35', 'fields36_37'};

    % Acceder al grupo (esto es la línea 28 corregida)
    if currentChapter >= 1 && currentChapter <= numel(chapterGroups)
        group = chapterGroups{currentChapter};
    else
        group = '';  % Manejo de error si capítulo fuera de rango
        disp('Advertencia: currentChapter fuera de rango en updateChapterButtons');
    end

    % Actualizar visibilidad de botones anterior/siguiente (asumiendo esto es el propósito)
    btnPrevious = findall(fig, 'Tag', 'btnPrevious');
    btnNext = findall(fig, 'Tag', 'btnNext');

    if ~isempty(btnPrevious)
        if currentChapter > 1
            set(btnPrevious, 'Visible', 'on');
        else
            set(btnPrevious, 'Visible', 'off');
        end
    end

    if ~isempty(btnNext)
        if currentChapter < 8  % Asumiendo 8 capítulos totales
            set(btnNext, 'Visible', 'on');
        else
            set(btnNext, 'Visible', 'off');
        end
    end

    % Si usas 'group' para actualizar otro botón (ej. btnFields), hazlo aquí
    % Ejemplo: btnFields = findall(fig, 'Tag', 'btnFields');
    % images = getappdata(fig, 'images');
    % set(btnFields, 'CData', images.(group));

    drawnow;  % Forzar actualización visual
end