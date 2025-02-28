function play_video(videoList,window,trials_passed)
    for i=1:length(videoList)
        % Now within the scope of each trial;
        videofile= char(videoList(i));
        videofile
        % REMOVE STEPS 7.1 TO 7.3 IF SKIPPING EYETRACKER
%         % STEP 7.1 
%         % Sending a 'TRIALID' message to mark the start of a trial in Data Viewer. 
%         Eyelink('Message', 'TRIALID %d', (i+trials_passed));
%         % Must be offline to draw to EyeLink screen
%         Eyelink('Command', 'set_idle_mode');
%         % clear tracker display and draw box at center
%         Eyelink('Command', 'clear_screen 0')
%         
%         % transfer the image to show it on the eye tracker computers so you
%         % can watch the eye gaze relative to what they are actually looking
%         % at.  but this is not necessary to present the stimuli on the
%         % display PC
%         
%         Eyelink('command', 'draw_box %d %d %d %d 15', width/2-50, height/2-50, width/2+50, height/2+50);
%         
%         % STEP 7.2
%         % Do a drift correction at the beginning of each trial
%         % Performing drift correction (checking) is optional for 
%         % EyeLink 1000 eye trackers.
%         EyelinkDoDriftCorrection(el);  %just comment this out to get rid
%         % of drift 
%         
%         % STEP 7.3
%         % start recording eye position (preceded by a short pause so that 
%         % the tracker can finish the mode transition)
%         % The paramerters for the 'StartRecording' call controls the
%         % file_samples, file_events, link_samples, link_events availability
%         Eyelink('Command', 'set_idle_mode');  % definitely want to do before recording**
%         WaitSecs(0.05); % more than enough time
%         % Eyelink('StartRecording', 1, 1, 1, 1);    
%         Eyelink('StartRecording');    
%         % record a few samples before we actually start displaying
%         % otherwise you may lose a few msec of data 
%         WaitSecs(0.1);  % build up a buffer of eye information over the link but would not be necessary if you are not doing gaze contingent stuff. 
    
    	% STEP 7.4
        % Prepare and show the screen. 
        % REMOVE NEXT LINE IF SKIPPING EYETRACKER
     	%Screen('FillRect', window, el.backgroundcolour);   
        
        %imageTexture=Screen('MakeTexture',window, imdata);
        %Screen('DrawTexture', window, imageTexture);
        moviePtr = Screen('OpenMovie', window,videofile);
        Screen('PlayMovie', moviePtr,1, [], 0.5)
         % Playback loop: Runs until end of movie or keypress:
        while ~KbCheck
            % Wait for next movie frame, retrieve texture handle to it
            tex = Screen('GetMovieImage', window, moviePtr);

            % Valid texture returned? A negative value means end of movie reached:
            if tex<=0
                % We're done, break out of loop:
                break;
            end

            % Draw the new texture immediately to screen:
            Screen('DrawTexture', window, tex);
    
            % mark zero-plot time in data file
            % REMOVE NEXT LINE IF SKIPPING EYETRACKER
            %Eyelink('Message', 'SYNCTIME');
            
            % Update display:
            Screen('Flip', window);

            % Release texture:
            Screen('Close', tex);
        end

        % Stop playback:
        Screen('PlayMovie', moviePtr, 0);

        % Close movie:
        Screen('CloseMovie', moviePtr);                  
        WaitSecs(1);    
        
        % STEP 7.6
        % Clear the display
        % REMOVE NEXT LINE IF SKIPPING EYETRACKER
        %Screen('FillRect', window, el.backgroundcolour);
     	%Screen('Flip', window);
        % REMOVE NEXT LINE IF SKIPPING EYETRACKER
        %Eyelink('Message', 'BLANK_SCREEN');
        % adds 100 msec of data to catch final events
        WaitSecs(0.1);
        % stop the recording of eye-movements for the current trial
        % REMOVE NEXT LINE IF SKIPPING EYETRACKER
        %Eyelink('StopRecording');        
      
        % REMOVE EVERYTHING FROM STEPS 7.7 - 7.8 IF SKIPPING EYETRACKER
        
%         % STEP 7.7
%         % Send out necessary integration messages for data analysis
%         % Send out interest area information for the trial
%         % See "Protocol for EyeLink Data to Viewer Integration-> Interest 
%         % Area Commands" section of the EyeLink Data Viewer User Manual
%         % IMPORTANT! Don't send too many messages in a very short period of
%         % time or the EyeLink tracker may not be able to write them all 
%         % to the EDF file.
%         % Consider adding a short delay every few messages.
%         WaitSecs(0.001);
%         Eyelink('Message', '!V IAREA ELLIPSE %d %d %d %d %d %s', 1, width/2-50, height/2-50, width/2+50, height/2+50,'center');
%         Eyelink('Message', '!V IAREA RECTANGLE %d %d %d %d %d %s', 2, width/4-50, height/2-50, width/4+50, height/2+50,'left');
%         Eyelink('Message', '!V IAREA RECTANGLE %d %d %d %d %d %s', 3, 3*width/4-50, height/2-50, 3*width/4+50, height/2+50,'right');
%         Eyelink('Message', '!V IAREA RECTANGLE %d %d %d %d %d %s', 4, width/2-50, height/4-50, width/2+50, height/4+50,'up');
%         Eyelink('Message', '!V IAREA RECTANGLE %d %d %d %d %d %s', 5, width/2-50, 3*height/4-50, width/2+50, 3*height/4+50,'down');
%         
%         % Send messages to report trial condition information
%         % Each message may be a pair of trial condition variable and its
%         % corresponding value follwing the '!V TRIAL_VAR' token message
%         % See "Protocol for EyeLink Data to Viewer Integration-> Trial
%         % Message Commands" section of the EyeLink Data Viewer User Manual
%         WaitSecs(0.001); %%% in between every 5-10 messages wait at least 1ms because we could flood the channel and start to miss some messages
%         Eyelink('Message', '!V TRIAL_VAR index %d', i)        
%         Eyelink('Message', '!V TRIAL_VAR imgfile %s', imgfile)               
%         % can send any number of variables here for groups for data analysis later (e.g, conditions etc)
%         
%         % STEP 7.8
%         % Sending a 'TRIAL_RESULT' message to mark the end of a trial in 
%         % Data Viewer. This is different than the end of recording message 
%         % END that is logged when the trial recording ends. The viewer will
%         % not parse any messages, events, or samples that exist in the data 
%         % file after this message.
%         Eyelink('Message', 'TRIAL_RESULT 0')
    end  