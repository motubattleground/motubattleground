function playGameCallback(src, event, fig, slot)
    playClickSound(fig);
    msgbox(['Juego en ranura ', num2str(slot), ' seleccionado.'], 'Información');
end