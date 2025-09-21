function hexagonal_board()
    % Parámetros del tablero
    rows = 'A':'Y'; % 25 filas (A a Y, A abajo en y=0)
    num_rows = length(rows);
    num_cols_odd = 29; % Columnas en filas impares
    num_cols_even = 30; % Columnas en filas pares

    % Tamaño del hexágono (radio del círculo circunscrito)
    hex_size = 1;

    % Inicializar listas para almacenar coordenadas y etiquetas
    centers_x = [];
    centers_y = [];
    labels = {};

    % Calcular posiciones de los centros de los hexágonos
    for row_idx = 1:num_rows
        % Determinar si la fila es par o impar (1-based index)
        is_odd = mod(row_idx, 2) == 1;
        num_cols = is_odd * num_cols_odd + (1 - is_odd) * num_cols_even;

        % Coordenada y: distancia vertical = 3/2 * hex_size
        y = (row_idx - 1) * (3/2) * hex_size;

        % Desplazamiento horizontal para filas pares (negativo para coincidir con el ejemplo)
        x_offset = (1 - is_odd) * (-sqrt(3)/2) * hex_size;

        for col_idx = 1:num_cols
            % Coordenada x: sqrt(3) * hex_size por columna + offset
            x = (col_idx - 1) * sqrt(3) * hex_size + x_offset;

            % Almacenar coordenadas y etiqueta
            centers_x = [centers_x, x];
            centers_y = [centers_y, y];
            labels{end+1} = sprintf('%c%d', rows(row_idx), col_idx);
        end
    end

    % Crear figura
    figure;
    hold on;
    axis equal;
    grid off;

    % Dibujar hexágonos
    for i = 1:length(centers_x)
        % Coordenadas de los vértices del hexágono (pointy top)
        theta = (30:60:330) * pi / 180; % Ángulos para pointy top (vértice arriba)
        hex_x = centers_x(i) + hex_size * cos(theta);
        hex_y = centers_y(i) + hex_size * sin(theta);
        
        % Dibujar hexágono
        patch(hex_x, hex_y, 'w', 'EdgeColor', 'k');
        
        % Añadir etiqueta en el centro
        text(centers_x(i), centers_y(i), labels{i}, ...
             'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 8);
    end

    % Ajustar límites del gráfico
    xlim([min(centers_x) - 2*hex_size, max(centers_x) + 2*hex_size]);
    ylim([min(centers_y) - 2*hex_size, max(centers_y) + 2*hex_size]);
    
    % Etiquetas de los ejes
    xlabel('X');
    ylabel('Y');
    title('Tablero Hexagonal (Pointy Top, Filas A a Y, Malla Contigua)');

    hold off;
end