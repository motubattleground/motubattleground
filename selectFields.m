function selectFields(fig)
    % Reproduce el sonido de clic
    playClickSound(fig);

    % Obtener el capítulo actual, número de jugadores y menú anterior
    currentChapter = getappdata(fig, 'currentChapter');
    numPlayers = getappdata(fig, 'numPlayers');
    previousMenu = getappdata(fig, 'previousMenu');

    % Iniciar el juego
    startGame(fig, numPlayers, currentChapter);
end