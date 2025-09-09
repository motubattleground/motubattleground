function [images, audio] = loadResources()
    % Define paths
    background = 'images\bkg_intro.jpg';
    button1 = 'images\buttons\modocamp.png';
    button2 = 'images\buttons\modoclasico.png';
    skipbutton = 'images\buttons\saltar.png';
    exitbutton = 'images\buttons\salir.png';
    versionbutton = 'images\buttons\version.png';
    titleImage = 'images\buttons\modosdejuego.png';
    minusButton = 'images\buttons\menos.png';
    plusButton = 'images\buttons\mas.png';
    musicLabel = 'images\buttons\musica.png';
    sfxLabel = 'images\buttons\efectos.png';
    versionBackground = 'images\buttons\version1.0.png';
    returnButton = 'images\buttons\volver.png';
    newButton = 'images\buttons\nuevo.png';
    savedButton = 'images\buttons\guardado.png';
    onePlayerButton = 'images\buttons\1jugador.png';
    twoPlayersButton = 'images\buttons\2jugadores.png';
    fourPlayersButton = 'images\buttons\4jugadores.png';
    chaptersTitle = 'images\buttons\capitulos.png';
    chapter1Image = 'images\icons\capitulo1.png';
    chapter2Image = 'images\icons\capitulo2.png';
    chapter3Image = 'images\icons\capitulo3.png';
    chapter4Image = 'images\icons\capitulo4.png';
    chapter5Image = 'images\icons\capitulo5.png';
    chapter6Image = 'images\icons\capitulo6.png';
    chapter7Image = 'images\icons\capitulo7.png';
    chapter8Image = 'images\icons\capitulo8.png';
    fields1_6Button = 'images\buttons\campos1-6.png';
    fields7_13Button = 'images\buttons\campos7-13.png';
    fields14_19Button = 'images\buttons\campos14-19.png';
    fields20_25Button = 'images\buttons\campos20-25.png';
    fields26_29Button = 'images\buttons\campos26-29.png';
    fields30_31Button = 'images\buttons\campos30-31.png';
    fields32_35Button = 'images\buttons\campos32-35.png';
    fields36_37Button = 'images\buttons\campos36-37.png';
    nextButton = 'images\buttons\siguiente.png';
    previousButton = 'images\buttons\anterior.png';
    oneOfImage = 'images\buttons\1de.png';
    twoOfImage = 'images\buttons\2de.png';
    threeOfImage = 'images\buttons\3de.png';
    fourOfImage = 'images\buttons\4de.png';
    fiveOfImage = 'images\buttons\5de.png';
    sixOfImage = 'images\buttons\6de.png';
    sevenOfImage = 'images\buttons\7de.png';
    eightOfImage = 'images\buttons\8de.png';
    vacio1Image = 'images\icons\vacio1.png';
    vacio2Image = 'images\icons\vacio2.png';
    vacio3Image = 'images\icons\vacio3.png';
    playButton = 'images\buttons\jugar0.png';
    deleteButton = 'images\buttons\borrar0.png';
    clickSoundFile = 'audios\sfx_click.mp3';
    backSoundFile = 'audios\sfx_back.mp3';
    bgMusicFile = 'audios\background_music.mp3';

    % Initialize structs
    images = struct();
    audio = struct();

    % Load images
    try
        images.background = imread(background);
    catch e
        disp(['Error al cargar la imagen ', background, ': ', e.message]);
        images.background = ones(1080, 1920, 3);
    end
    images.button1 = imresize(imread(button1), [80, 400]);
    images.button1Highlight = min(images.button1 * 1.2, 255);
    images.campaignTitle = imresize(imread(button1), [140, 700]);
    images.button2 = imresize(imread(button2), [80, 400]);
    images.button2Highlight = min(images.button2 * 1.2, 255);
    images.classic = imresize(imread(button2), [140, 700]);
    images.savedGamesTitle = imresize(imread(savedButton), [140, 700]);
    images.skip = imresize(imread(skipbutton), [64, 320]);
    images.skipHighlight = min(images.skip * 1.2, 255);
    images.exit = imresize(imread(exitbutton), [64, 320]);
    images.exitHighlight = min(images.exit * 1.2, 255);
    images.version = imresize(imread(versionbutton), [64, 320]);
    images.versionHighlight = min(images.version * 1.2, 255);
    images.title = imresize(imread(titleImage), [140, 700]);
    images.minus = imresize(imread(minusButton), [64, 98]);
    images.minusHighlight = min(images.minus * 1.2, 255);
    images.plus = imresize(imread(plusButton), [64, 98]);
    images.plusHighlight = min(images.plus * 1.2, 255);
    images.musicLabel = imresize(imread(musicLabel), [64, 320]);
    images.sfxLabel = imresize(imread(sfxLabel), [64, 320]);
    images.versionBackground = imread(versionBackground);
    images.return = imresize(imread(returnButton), [64, 320]);
    images.returnHighlight = min(images.return * 1.2, 255);
    images.new = imresize(imread(newButton), [80, 400]);
    images.newHighlight = min(images.new * 1.2, 255);
    images.saved = imresize(imread(savedButton), [80, 400]);
    images.savedHighlight = min(images.saved * 1.2, 255);
    images.onePlayer = imresize(imread(onePlayerButton), [80, 400]);
    images.onePlayerHighlight = min(images.onePlayer * 1.2, 255);
    images.twoPlayers = imresize(imread(twoPlayersButton), [80, 400]);
    images.twoPlayersHighlight = min(images.twoPlayers * 1.2, 255);
    images.fourPlayers = imresize(imread(fourPlayersButton), [80, 400]);
    images.fourPlayersHighlight = min(images.fourPlayers * 1.2, 255);
    images.chaptersTitle = imresize(imread(chaptersTitle), [140, 700]);
    images.chapter1 = imresize(imread(chapter1Image), [400, 400]);
    images.chapter2 = imresize(imread(chapter2Image), [400, 400]);
    images.chapter3 = imresize(imread(chapter3Image), [400, 400]);
    images.chapter4 = imresize(imread(chapter4Image), [400, 400]);
    images.chapter5 = imresize(imread(chapter5Image), [400, 400]);
    images.chapter6 = imresize(imread(chapter6Image), [400, 400]);
    images.chapter7 = imresize(imread(chapter7Image), [400, 400]);
    images.chapter8 = imresize(imread(chapter8Image), [400, 400]);
    images.fields1_6 = imresize(imread(fields1_6Button), [80, 400]);
    images.fields1_6Highlight = min(images.fields1_6 * 1.2, 255);
    images.fields7_13 = imresize(imread(fields7_13Button), [80, 400]);
    images.fields7_13Highlight = min(images.fields7_13 * 1.2, 255);
    images.fields14_19 = imresize(imread(fields14_19Button), [80, 400]);
    images.fields14_19Highlight = min(images.fields14_19 * 1.2, 255);
    images.fields20_25 = imresize(imread(fields20_25Button), [80, 400]);
    images.fields20_25Highlight = min(images.fields20_25 * 1.2, 255);
    images.fields26_29 = imresize(imread(fields26_29Button), [80, 400]);
    images.fields26_29Highlight = min(images.fields26_29 * 1.2, 255);
    images.fields30_31 = imresize(imread(fields30_31Button), [80, 400]);
    images.fields30_31Highlight = min(images.fields30_31 * 1.2, 255);
    images.fields32_35 = imresize(imread(fields32_35Button), [80, 400]);
    images.fields32_35Highlight = min(images.fields32_35 * 1.2, 255);
    images.fields36_37 = imresize(imread(fields36_37Button), [80, 400]);
    images.fields36_37Highlight = min(images.fields36_37 * 1.2, 255);
    images.next = imresize(imread(nextButton), [80, 400]);
    images.nextHighlight = min(images.next * 1.2, 255);
    images.previous = imresize(imread(previousButton), [80, 400]);
    images.previousHighlight = min(images.previous * 1.2, 255);
    images.oneOf = imresize(imread(oneOfImage), [80, 400]);
    images.twoOf = imresize(imread(twoOfImage), [80, 400]);
    images.threeOf = imresize(imread(threeOfImage), [80, 400]);
    images.fourOf = imresize(imread(fourOfImage), [80, 400]);
    images.fiveOf = imresize(imread(fiveOfImage), [80, 400]);
    images.sixOf = imresize(imread(sixOfImage), [80, 400]);
    images.sevenOf = imresize(imread(sevenOfImage), [80, 400]);
    images.eightOf = imresize(imread(eightOfImage), [80, 400]);
    images.vacio1 = imresize(imread(vacio1Image), [64, 100]);
    images.vacio2 = imresize(imread(vacio2Image), [64, 100]);
    images.vacio3 = imresize(imread(vacio3Image), [64, 100]);
    images.play = imresize(imread(playButton), [64, 300]);
    images.playHighlight = min(images.play * 1.2, 255); % Corregido error tipográfico
    images.delete = imresize(imread(deleteButton), [64, 300]);
    images.deleteHighlight = min(images.delete * 1.2, 255);

    % Load volume levels
    images.volumeLevels = containers.Map('KeyType', 'double', 'ValueType', 'any');
    for vol = 0:10:100
        try
            imgVolume = imread(sprintf('images\\buttons\\%d.png', vol));
            images.volumeLevels(vol) = imresize(imgVolume, [64, 124]);
        catch e
            disp(['Error al cargar la imagen ', sprintf('%d.png', vol), ': ', e.message]);
            images.volumeLevels(vol) = ones(64, 124, 3);
        end
    end

    % Load audio
    try
        [audio.click, audio.clickFs] = audioread(clickSoundFile);
        disp(['Audio sfx_click.mp3 cargado correctamente. Frecuencia de muestreo: ', num2str(audio.clickFs), ' Hz']);
    catch e
        disp(['Error al cargar el archivo de audio sfx_click.mp3: ', e.message]);
        audio.click = [];
        audio.clickFs = [];
    end

    try
        [audio.back, audio.backFs] = audioread(backSoundFile);
        disp(['Audio sfx_back.mp3 cargado correctamente. Frecuencia de muestreo: ', num2str(audio.backFs), ' Hz']);
    catch e
        disp(['Error al cargar el archivo de audio sfx_back.mp3: ', e.message]);
        audio.back = [];
        audio.backFs = [];
    end

    try
        [audio.bgMusic, audio.bgFs] = audioread(bgMusicFile);
        disp(['Música de fondo background_music.mp3 cargada correctamente. Frecuencia de muestreo: ', num2str(audio.bgFs), ' Hz']);
    catch e
        disp(['Error al cargar la música de fondo: ', e.message]);
        audio.bgMusic = [];
        audio.bgFs = [];
    end
end