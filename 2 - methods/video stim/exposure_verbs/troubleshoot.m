function troubleshoot
% Clear the workspace and the screen
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
% For help see: Screen Screens?
screens = Screen('Screens');

% Draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen. When only one screen is attached to the monitor we will draw to
% this.
% For help see: help max
screenNumber = max(screens);

% Define black (white will be 1 and black 0). This is because
% luminace values are (in general) defined between 0 and 1.
% For help see: help BlackIndex
black = BlackIndex(screenNumber);

% Open an on screen window and color it black
% For help see: Screen OpenWindow?
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% Get the size of the on screen window in pixels
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(windowRect);

iteration=0;
    abortit=0;

% Make a base Rect of 200 by 200 pixels. This is the rect which defines the
% size of our square in pixels. Rects are rectangles, so the
% sides do not have to be the same length. The coordinates define the top
% left and bottom right coordinates of our rect [top-left-x top-left-y
% bottom-right-x bottom-right-y]. The easiest thing to do is set the first
% two coordinates to 0, then the last two numbers define the length of the
% rect in X and Y. The next line of code then centers the rect on a
% particular location of the screen.
%baseRect = [0 0 200 200];

% Center the rectangle on the centre of the screen using fractional pixel
% values.
% For help see: CenterRectOnPointd
%centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter)

topHalf = [1, 1, screenXpixels, yCenter]
[topHalfXCenter, topHalfYCenter] = RectCenter(topHalf)
%bottomHalf1 = [1, yCenter, screenXpixels/2, screenYpixels]
%[bottomHalfXCenter, bottomHalfYCenter] = RectCenter(bottomHalf1)

bottomHalf = [1, yCenter, screenXpixels, screenYpixels]
[bottomHalfXCenter, bottomHalfYCenter] = RectCenter(bottomHalf)

squareXpos = [screenXpixels * 0.25 screenXpixels * 0.75]
numSquares = length(squareXpos)

%centeredRectTop = CenterRectOnPointd(baseRect, topHalfXCenter, topHalfYCenter)

%centeredRectTop = CenterRectOnPointd(baseRect, bottomHalfXCenter, bottomHalfYCenter)

moviename = 'Users/eyelink/Desktop/Lee/2 - methods/video stim/edited/novel_final/a1_blick.mp4'
moviename2 = 'Users/eyelink/Desktop/Lee/2 - methods/video stim/edited/novel_final/a2_blick.mp4'

[movie movieduration fps imgw imgh] = Screen('OpenMovie', window, moviename);
fprintf('Movie1: %s  : %f seconds duration, %f fps...\n', moviename, movieduration, fps);

[movie2 movieduration fps imgw imgh] = Screen('OpenMovie', window, moviename2);
fprintf('Movie2: %s  : %f seconds duration, %f fps...\n', moviename2, movieduration, fps);

baseRect = [0 0 imgw/3 imgh/3]

allRects = nan(4,2);
for i = 1:numSquares
    allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), bottomHalfYCenter)
end

% Seek to start of movies (timeindex 0):
Screen('SetMovieTimeIndex', movie, 0);
Screen('SetMovieTimeIndex', movie2, 0);

rate=1;

Screen('PlayMovie', movie, rate);
Screen('PlayMovie', movie2, rate);

t1 = GetSecs;

  
 while ~KbCheck            
        % Return next frame in movie, in sync with current playback
        % time and sound.
        % tex either the texture handle or zero if no new frame is
        % ready yet.
        tex = Screen('GetMovieImage', window, movie);
        tex2 = Screen('GetMovieImage', window, movie2);

        % Valid texture returned? A negative value means end of movie reached:
        if tex<=0
            % We're done, break out of loop:
            break;
        elseif tex2 <= 0
            break;
        end

        % Valid texture returned?
        if tex > 0
            % Draw the new texture immediately to screen:
            Screen('DrawTexture', window, tex, [], allRects(:,1));
            % Release texture:
            Screen('Close', tex);
        end

        % Valid 2nd texture returned?
        if tex2 > 0
            % Draw the new texture immediately to screen:
            Screen('DrawTexture', window, tex2, [], allRects(:,2));
            % Release texture:
            Screen('Close', tex2);
        end

        % Update display if there is anything to update:
        if (tex > 0 || tex2 > 0)
            % We use clearmode=1, aka don't clear on flip. This is
            % needed to avoid flicker...
            Screen('Flip', window, 0, 1);
        else
            % Sleep a bit before next poll...
            WaitSecs('YieldSecs', 0.001);
        end

 end
    
 % Done. Stop playback:
Screen('PlayMovie', movie, 0);
Screen('PlayMovie', movie2, 0);

% Close movie objects:
Screen('CloseMovie', movie);
Screen('CloseMovie', movie2);
end
    




% 
% 
% rectColor = [1 0 0]
% 
% % Draw the square to the screen. For information on the command used in
% % this line see Screen FillRect?
% 
% allRects = nan(4,2);
% for i = 1:numSquares
%     allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), topHalfYCenter)
% end
% Screen('FillRect', window, rectColor, allRects);
% 
% % Flip to the screen. This command basically draws all of our previous
% % commands onto the screen. See later demos in the animation section on more
% % timing details. And how to demos in this section on how to draw multiple
% % rects at once.
% % For help see: Screen Flip?
% Screen('Flip', window);
% 
% % Now we have drawn to the screen we wait for a keyboard button press (any
% % key) to terminate the demo.
% % For help see: help KbStrokeWait
% KbStrokeWait;

% Clear the screen. "sca" is short hand for "Screen CloseAll". This clears
% all features related to PTB. Note: we leave the variables in the
% workspace so you can have a look at them if you want.
% For help see: help sca


    
    
    
    