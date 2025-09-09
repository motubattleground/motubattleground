function checkHover(src, event)
    fig = src;
    if ~ishandle(fig)
        return;
    end
    cursorPos = get(fig, 'CurrentPoint');
    cursorX = cursorPos(1);
    cursorY = cursorPos(2);

    currentMenu = getappdata(fig, 'currentMenu');
    images = getappdata(fig, 'images');
    screenWidth = getappdata(fig, 'screenWidth');
    screenHeight = getappdata(fig, 'screenHeight');

    btnSkip = findobj(fig, 'Tag', 'btnSkip');
    btnOption1 = findobj(fig, 'Tag', 'btnOption1');
    btnOption2 = findobj(fig, 'Tag', 'btnOption2');
    btnExit = findobj(fig, 'Tag', 'btnExit');
    btnVersion = findobj(fig, 'Tag', 'btnVersion');
    btnMusicMinus = findobj(fig, 'Tag', 'btnMusicMinus');
    btnMusicPlus = findobj(fig, 'Tag', 'btnMusicPlus');
    btnSfxMinus = findobj(fig, 'Tag', 'btnSfxMinus');
    btnSfxPlus = findobj(fig, 'Tag', 'btnSfxPlus');
    btnReturn = findobj(fig, 'Tag', 'btnReturn');
    btnNew = findobj(fig, 'Tag', 'btnNew');
    btnSaved = findobj(fig, 'Tag', 'btnSaved');
    btn2Players = findobj(fig, 'Tag', 'btn2Players');
    btn4Players = findobj(fig, 'Tag', 'btn4Players');
    btnFields = findobj(fig, 'Tag', 'btnFields');
    btnNext = findobj(fig, 'Tag', 'btnNext');
    btnPrevious = findobj(fig, 'Tag', 'btnPrevious');

    % Mapeo de currentChapter a nombres de imágenes de campos
    fieldsMap = containers.Map('KeyType', 'double', 'ValueType', 'char');
    fieldsMap(1) = 'fields1_6';
    fieldsMap(2) = 'fields7_13';
    fieldsMap(3) = 'fields14_19';
    fieldsMap(4) = 'fields20_25';
    fieldsMap(5) = 'fields26_29';
    fieldsMap(6) = 'fields30_31';
    fieldsMap(7) = 'fields32_35';
    fieldsMap(8) = 'fields36_37';

    % Video menu
    if strcmp(currentMenu, 'video') && ~isempty(btnSkip) && ishandle(btnSkip)
        skipPos = get(btnSkip, 'Position');
        if cursorX >= skipPos(1) && cursorX <= skipPos(1) + skipPos(3) && ...
           cursorY >= skipPos(2) && cursorY <= skipPos(2) + skipPos(4)
            set(btnSkip, 'CData', images.skipHighlight);
        else
            set(btnSkip, 'CData', images.skip);
        end
    end

    % Main menu
    if strcmp(currentMenu, 'main')
        if ~isempty(btnOption1) && ishandle(btnOption1)
            pos = get(btnOption1, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btnOption1, 'CData', images.button1Highlight);
            else
                set(btnOption1, 'CData', images.button1);
            end
        end
        if ~isempty(btnOption2) && ishandle(btnOption2)
            pos = get(btnOption2, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btnOption2, 'CData', images.button2Highlight);
            else
                set(btnOption2, 'CData', images.button2);
            end
        end
        if ~isempty(btnExit) && ishandle(btnExit)
            pos = get(btnExit, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btnExit, 'CData', images.exitHighlight);
            else
                set(btnExit, 'CData', images.exit);
            end
        end
        if ~isempty(btnVersion) && ishandle(btnVersion)
            pos = get(btnVersion, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btnVersion, 'CData', images.versionHighlight);
            else
                set(btnVersion, 'CData', images.version);
            end
        end
        if ~isempty(btnMusicMinus) && ishandle(btnMusicMinus)
            pos = get(btnMusicMinus, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btnMusicMinus, 'CData', images.minusHighlight);
            else
                set(btnMusicMinus, 'CData', images.minus);
            end
        end
        if ~isempty(btnMusicPlus) && ishandle(btnMusicPlus)
            pos = get(btnMusicPlus, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btnMusicPlus, 'CData', images.plusHighlight);
            else
                set(btnMusicPlus, 'CData', images.plus);
            end
        end
        if ~isempty(btnSfxMinus) && ishandle(btnSfxMinus)
            pos = get(btnSfxMinus, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btnSfxMinus, 'CData', images.minusHighlight);
            else
                set(btnSfxMinus, 'CData', images.minus);
            end
        end
        if ~isempty(btnSfxPlus) && ishandle(btnSfxPlus)
            pos = get(btnSfxPlus, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btnSfxPlus, 'CData', images.plusHighlight);
            else
                set(btnSfxPlus, 'CData', images.plus);
            end
        end
    end

    % Campaign menu
    if strcmp(currentMenu, 'campaign')
        if ~isempty(btnNew) && ishandle(btnNew)
            pos = get(btnNew, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btnNew, 'CData', images.newHighlight);
            else
                set(btnNew, 'CData', images.new);
            end
        end
        if ~isempty(btnSaved) && ishandle(btnSaved)
            pos = get(btnSaved, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btnSaved, 'CData', images.savedHighlight);
            else
                set(btnSaved, 'CData', images.saved);
            end
        end
    end

    % Classic menu
    if strcmp(currentMenu, 'classic')
        if ~isempty(btn2Players) && ishandle(btn2Players)
            pos = get(btn2Players, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btn2Players, 'CData', images.twoPlayersHighlight);
            else
                set(btn2Players, 'CData', images.twoPlayers);
            end
        end
        if ~isempty(btn4Players) && ishandle(btn4Players)
            pos = get(btn4Players, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btn4Players, 'CData', images.fourPlayersHighlight);
            else
                set(btn4Players, 'CData', images.fourPlayers);
            end
        end
    end

    % Chapters menu
    if strcmp(currentMenu, 'chapters')
        if ~isempty(btnFields) && ishandle(btnFields)
            pos = get(btnFields, 'Position');
            currentChapter = getappdata(fig, 'currentChapter');
            fieldsImage = fieldsMap(currentChapter);
            fieldsImageHighlight = [fieldsImage 'Highlight'];
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btnFields, 'CData', images.(fieldsImageHighlight));
            else
                set(btnFields, 'CData', images.(fieldsImage));
            end
        end
        if ~isempty(btnNext) && ishandle(btnNext)
            pos = get(btnNext, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btnNext, 'CData', images.nextHighlight);
            else
                set(btnNext, 'CData', images.next);
            end
        end
        if ~isempty(btnPrevious) && ishandle(btnPrevious)
            pos = get(btnPrevious, 'Position');
            if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
               cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
                set(btnPrevious, 'CData', images.previousHighlight);
            else
                set(btnPrevious, 'CData', images.previous);
            end
        end
    end

    % Return button (common across menus)
    if ~isempty(btnReturn) && ishandle(btnReturn)
        pos = get(btnReturn, 'Position');
        if cursorX >= pos(1) && cursorX <= pos(1) + pos(3) && ...
           cursorY >= pos(2) && cursorY <= pos(2) + pos(4)
            set(btnReturn, 'CData', images.returnHighlight);
        else
            set(btnReturn, 'CData', images.return);
        end
    end
end