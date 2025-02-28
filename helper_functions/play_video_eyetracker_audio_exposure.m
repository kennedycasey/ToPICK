function output = play_video_eyetracker_audio_exposure(leftVideo, rightVideo, informantVideo,window,el,width, height,trial, wRect, audioOrder, leftAudio, rightAudio)
quitKey = KbName('ESCAPE');    
[keyIsDown,secs,keyCode]=KbCheck;
    for i=1:length(leftVideo)
        % Now within the scope of each trial;
        moviename= char(leftVideo);
        moviename2 = char(rightVideo);
        informantFile = char(informantVideo);
        audioOrder = char(audioOrder);
        leftAudio = char(leftAudio);
        rightAudio = char(rightAudio);
        
        %audio = char(audio);
        
        windowRect = wRect;
        
        % REMOVE STEPS 7.1 TO 7.3 IF SKIPPING EYETRACKER
        % STEP 7.1
        % Sending a 'TRIALID' message to mark the start of a trial in Data Viewer.
        Eyelink('Message', 'TRIALID %d', (trial));
        % Must be offline to draw to EyeLink screen
        Eyelink('Command', 'set_idle_mode');
        % clear tracker display and draw box at center
        Eyelink('Command', 'clear_screen 0')
        
        % transfer the image to show it on the eye tracker computers so you
        % can watch the eye gaze relative to what they are actually looking
        % at.  but this is not necessary to present the stimuli on the
        % display PC
        
        Eyelink('command', 'draw_box %d %d %d %d 15', width/2-50, height/2-50, width/2+50, height/2+50);
        
        % STEP 7.2
        % Do a drift correction at the beginning of each trial
        % Performing drift correction (checking) is optional for
        % EyeLink 1000 eye trackers.
        %EyelinkDoDriftCorrection(el);  %just comment this out to get rid
        % of drift
        
        % STEP 7.3
        % start recording eye position (preceded by a short pause so that
        % the tracker can finish the mode transition)
        % The paramerters for the 'StartRecording' call controls the
        % file_samples, file_events, link_samples, link_events availability
        Eyelink('Command', 'set_idle_mode');  % definitely want to do before recording**
        WaitSecs(0.05); % more than enough time
        % Eyelink('StartRecording', 1, 1, 1, 1);
        Eyelink('StartRecording');
        % record a few samples before we actually start displaying
        % otherwise you may lose a few msec of data
        WaitSecs(0.1);  % build up a buffer of eye information over the link but would not be necessary if you are not doing gaze contingent stuff.
        
        % STEP 7.4
        % Prepare and show the screen.
        % REMOVE NEXT LINE IF SKIPPING EYETRACKER
        Screen('FillRect', window, el.backgroundcolour);
        
        Eyelink('Message', 'SYNCTIME');
        
        [screenXpixels, screenYpixels] = Screen('WindowSize', window);
        % Get x, y center coordinates
        [xCenter, yCenter] = RectCenter(windowRect);
        
        % Create pixels for bottom half presentation
        bottomHalf = [1, yCenter, screenXpixels, screenYpixels];
        [bottomHalfXCenter, bottomHalfYCenter] = RectCenter(bottomHalf);
        
        % Create pixels for top half presentation
        topHalf = [1, 1, screenXpixels, yCenter];
        [topHalfXCenter, topHalfYCenter] = RectCenter(topHalf);
        
        
        squareXpos = [screenXpixels * 0.25 screenXpixels * 0.75];
        numSquares = length(squareXpos);
        
        [movie movieduration fps imgw imgh] = Screen('OpenMovie', window, moviename);
        
        [movie2 movieduration fps imgw imgh] = Screen('OpenMovie', window, moviename2);
        
        [informantVideo movieduration fps imgw imgh] = Screen('OpenMovie', window, informantFile);
        
        baseRect = [0 0 imgw/3 imgh/3];
        
        topRect = [0 0 imgw/2.5 imgh/2.5];
        
        allRects = nan(4,2);
        for i = 1:numSquares
            allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), bottomHalfYCenter);
        end
        
        rectLeft = allRects(:,1);
        rectRight = allRects(:,2);
        
        centeredTop = CenterRectOnPointd(topRect, topHalfXCenter, topHalfYCenter);
        
        %[y, freq] = psychwavread(audio);
        %wavedata = y';
        %nrchannels = size(wavedata,1); % Number of rows == number of channels.
        
        Screen('SetMovieTimeIndex', movie, 0);
        Screen('SetMovieTimeIndex', movie2, 0);
        Screen('SetMovieTimeIndex', informantVideo, 0);
        
        rate=1;
        
        % Play verb videos
        Screen('PlayMovie', movie, rate);
        Screen('PlayMovie', movie2, rate);
        Screen('PlayMovie', informantVideo, rate, 0, 1.0);

        % Playback loop: Runs until end of movie or keypress:
        t1 = GetSecs;
        GetEye = 0;
        while ~KbCheck
            % Wait for next movie frame, retrieve texture handle to it
            tex = Screen('GetMovieImage', window, movie);
            tex2 = Screen('GetMovieImage', window, movie2);
            tex3 = Screen('GetMovieImage', window, informantVideo);
            
            % Valid texture returned? A negative value means end of movie reached:
            if tex<=0
                % We're done, break out of loop:
                break;
            elseif tex2 <= 0
                break;
            elseif tex3 <= 0
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
            
            % Valid texture returned?
            if tex3 > 0
                % Draw the new texture immediately to screen:
                Screen('DrawTexture', window, tex3, [], centeredTop);
                % Release texture:
                Screen('Close', tex3);
            end
            
            % mark zero-plot time in data file
            % REMOVE NEXT LINE IF SKIPPING EYETRACKER
            Eyelink('Message', 'SYNCTIME');
            
            % Update display if there is anything to update:
            if (tex > 0 || tex2 > 0 || tex3 > 0)
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
        Screen('PlayMovie', informantVideo, 0);
        
        WaitSecs(1);
        
        % Close movie objects:
        Screen('CloseMovie', movie);
        Screen('CloseMovie', movie2);
        Screen('CloseMovie', informantVideo);
        
        %WaitSecs(3);
        
        % STEP 7.6
        % Clear the display
        % REMOVE NEXT LINE IF SKIPPING EYETRACKER
        Screen('FillRect', window, el.backgroundcolour);
        Screen('Flip', window);
        % REMOVE NEXT LINE IF SKIPPING EYETRACKER
        Eyelink('Message', 'BLANK_SCREEN');
        % adds 100 msec of data to catch final events
        WaitSecs(0.1);
        % stop the recording of eye-movements for the current trial
        % REMOVE NEXT LINE IF SKIPPING EYETRACKER
        Eyelink('StopRecording');
        
        % REMOVE EVERYTHING FROM STEPS 7.7 - 7.8 IF SKIPPING EYETRACKER
        
        % STEP 7.7
        % Send out necessary integration messages for data analysis
        % Send out interest area information for the trial
        % See "Protocol for EyeLink Data to Viewer Integration-> Interest
        % Area Commands" section of the EyeLink Data Viewer User Manual
        % IMPORTANT! Don't send too many messages in a very short period of
        % time or the EyeLink tracker may not be able to write them all
        % to the EDF file.
        % Consider adding a short delay every few messages.
        WaitSecs(0.001);
        Eyelink('Message', '!V IAREA RECTANGLE %d %d %d %d %d %s', 2, centeredTop(1), centeredTop(2), centeredTop(3), centeredTop(4),'top');
        Eyelink('Message', '!V IAREA RECTANGLE %d %d %d %d %d %s', 3, rectLeft(1), rectLeft(2), rectLeft(3), rectLeft(4),'left');
        Eyelink('Message', '!V IAREA RECTANGLE %d %d %d %d %d %s', 4, rectRight(1), rectRight(2), rectRight(3), rectRight(4),'right');
        
        % Send messages to report trial condition information
        % Each message may be a pair of trial condition variable and its
        % corresponding value follwing the '!V TRIAL_VAR' token message
        % See "Protocol for EyeLink Data to Viewer Integration-> Trial
        % Message Commands" section of the EyeLink Data Viewer User Manual
        WaitSecs(0.001); %%% in between every 5-10 messages wait at least 1ms because we could flood the channel and start to miss some messages
        Eyelink('Message', '!V TRIAL_VAR index %d', trial)
        Eyelink('Message', '!V TRIAL_VAR trial %s', 'Exposure')
        Eyelink('Message', '!V TRIAL_VAR leftVideo %s', moviename)
        Eyelink('Message', '!V TRIAL_VAR rightVideo %s', moviename2)
        Eyelink('Message', '!V TRIAL_VAR informantVideo %s', informantFile)
        Eyelink('Message', '!V TRIAL_VAR audioOrder %s', audioOrder)
        Eyelink('Message', '!V TRIAL_VAR leftAudio %s', leftAudio)
        Eyelink('Message', '!V TRIAL_VAR rightAudio %s', rightAudio)
        
        % can send any number of variables here for groups for data analysis later (e.g, conditions etc)
        
        % STEP 7.8
        % Sending a 'TRIAL_RESULT' message to mark the end of a trial in
        % Data Viewer. This is different than the end of recording message
        % END that is logged when the trial recording ends. The viewer will
        % not parse any messages, events, or samples that exist in the data
        % file after this message.
        Eyelink('Message', 'TRIAL_RESULT 0')
        
        if (keyIsDown==1 && keyCode(quitKey)==1)
            break
        end
        
        if KbCheck
            
            % adds 100 msec of data to catch final events
            WaitSecs(0.1);
            % stop the recording of eye-movements for the current trial
            % IF NOT USING EYETRACKER REMOVE NEXT LINE
            Eyelink('StopRecording');
            output = 0;
            return
        else
            output = 1;
            
        end
       
    end
end