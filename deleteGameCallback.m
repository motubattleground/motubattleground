function deleteGameCallback(src, event, fig, slot)
    playClickSound(fig);
    msgbox(['Juego en ranura ', num2str(slot), ' eliminado.'], 'Información');
end