function startGame(fig, numPlayers)
    % Reproduce el sonido de clic
    playClickSound(fig);

    % Configura el número de jugadores para el modo clásico
    setappdata(fig, 'numPlayers', numPlayers);
    setappdata(fig, 'gameMode', 'classic');

    % Llama al menú de capítulos
    chaptersMenu(fig);
end