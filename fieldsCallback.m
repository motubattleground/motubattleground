function fieldsCallback(src, event, fig, chapter)
    playClickSound(fig);
    msgbox(['Has seleccionado Campos para el capítulo ', num2str(chapter)], 'Información');
end