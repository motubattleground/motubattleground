function exitCallback(fig)
    % Reproduce el sonido de retroceso
    playBackSound(fig);
    
    % Cierra la figura
    close(fig);
end