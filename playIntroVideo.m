function playIntroVideo(fig)
    mainintro = 'videos\intro.mp4';
    setappdata(fig, 'skipFlag', false);

    % Crear un axes explícitamente para el video
    ax = axes('Parent', fig, 'Position', [0, 0, 1, 1], ...
        'XTick', [], 'YTick', [], 'Box', 'off', 'XColor', 'none', 'YColor', 'none', ...
        'DataAspectRatio', [1 1 1]);
    
    images = getappdata(fig, 'images');
    screenWidth = getappdata(fig, 'screenWidth');
    btnSkip = uicontrol(fig, 'Style', 'pushbutton', ...
        'Position', [screenWidth-340, 20, 320, 64], ...
        'CData', images.skip, ...
        'Callback', @(~, ~)skipVideo(fig), ...
        'Tag', 'btnSkip');

    try
        v = VideoReader(mainintro);
        [audio, fs] = audioread(mainintro);
        audioPlayer = audioplayer(audio, fs);
        play(audioPlayer);
        startTime = tic;

        while hasFrame(v) && ~getappdata(fig, 'skipFlag')
            frame = readFrame(v);
            image(frame, 'Parent', ax);
            ax.XLim = [0 size(frame, 2)];
            ax.YLim = [0 size(frame, 1)];
            drawnow;
            elapsedTime = toc(startTime);
            expectedTime = v.CurrentTime;
            if elapsedTime < expectedTime
                pause(expectedTime - elapsedTime);
            end
        end

        stop(audioPlayer);
        if ~getappdata(fig, 'skipFlag')
            showMainMenu(fig);
        end
    catch e
        disp('Error al reproducir el video o audio: ');
        disp(e.message);
        showMainMenu(fig);
    end
end