function word = mapNumberToWord(number)
    % Mapea un número (1-8) a su representación en texto (one, two, ..., eight)
    numberMap = containers.Map('KeyType', 'double', 'ValueType', 'char');
    numberMap(1) = 'one';
    numberMap(2) = 'two';
    numberMap(3) = 'three';
    numberMap(4) = 'four';
    numberMap(5) = 'five';
    numberMap(6) = 'six';
    numberMap(7) = 'seven';
    numberMap(8) = 'eight';
    
    if numberMap.isKey(number)
        word = numberMap(number);
    else
        error('Número de capítulo inválido: %d', number);
    end
end