function verbGaze
ListenChar(0);
KbName('UnifyKeyNames');  
quitKey = KbName('ESCAPE');
continueKey = KbName('c');
[keyIsDown,secs,keyCode]=KbCheck;
addpath('helper_functions')

try 
    %% STEP 1: Create EDF File
    % Added a dialog box to set your own EDF file name before opening 
    % experiment graphics. Make sure the entered EDF file name is 1 to 8 
    % characters in length and only numbers or letters are allowed.
    prompt = {'Enter tracker EDF file name (1 to 8 letters or numbers)'};
    dlg_title = 'Create EDF file';
    num_lines= 1;
    def     = {'DEMO'};
    answer  = inputdlg(prompt,dlg_title,num_lines,def);
    %edfFile= 'DEMO.EDF'
    edfFile = answer{1};
    dummymode = 0;
    fprintf('EDFFile: %s\n', edfFile );
    
    
    %% STEP 2: Psychtoolbox Setup
    Screen('Preference', 'SkipSyncTests', 1);

    % Get the screen numbers
    screens = Screen('Screens');
    
    % Select the external screen if it is present, else revert to the native
    % screen
    screenNumber = max(screens);
    
    % Define black, white and grey
    black = BlackIndex(screenNumber);
    white = WhiteIndex(screenNumber);
    grey = 149;

    % Open on external monitor
    [window, wRect] = PsychImaging('OpenWindow', screenNumber, grey);
    
    % Set the blend funciton for the screen
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    
    % Get the size of the on screen window in pixels
    [screenXpixels, screenYpixels] = Screen('WindowSize', window);
    
    % Query the frame duration
    ifi = Screen('GetFlipInterval', window);
    
    % Get the centre coordinate of the window in pixels
    [xCenter, yCenter] = RectCenter(wRect);
    
    % Set the text size
    Screen('TextFont', window, 'Ariel');
    Screen('TextSize', window, 20);
    
    %% Play Setup Movie
    %moviename = {'/Users/babylab/Documents/MATLAB/Mira/IDSLearn/Rio_cropped.mp4'}; %access video (muppets, to play during set-up)
    moviename = {'Users/babylab/Desktop/ToPICK/2 - methods/video stim/MuppetShow_MahnaMahna.mp4'}; %access video (muppets, to play during set-up)
    %moviename = {'/Users/babylab/Documents/MATLAB/Mira/IDSLearn/Sesame_Street_Walk_55db.mp4'};
    
    play_video(moviename,window,0)
    
    %% STEP 3: Eyelink Setup
    % Provide Eyelink with details about the graphics environment and perform some initializations.
    el=EyelinkInitDefaults(window);
    
    el.feedbackbeep=0;  % sound a beep after calibration/drift correction

    % Deciding what calibration will look like (right now it is black background with white targets)
    el.backgroundcolour = BlackIndex(el.window);
    el.foregroundcolour = BlackIndex(el.window); %this is deleted in AntiSaccade.m
    el.msgfontcolour  = WhiteIndex(el.window);
    el.imgtitlecolour = WhiteIndex(el.window);
    el.targetbeep = 0;
    el.calibrationtargetcolour= WhiteIndex(el.window);
    el.calibrationtargetsize= 1;
    el.calibrationtargetwidth=0.5;
    %use below script if you are calibrating with babies and want to show them video instead of white circles
    el.calanimationtargetfilename =  '/Users/babylab/Documents/MATLAB/Mira/IDSLearn/baby_small.mp4';

    % need to do this anytime you update the defaults
    EyelinkUpdateDefaults(el);

    %% STEP 4: Initialization of the connection with the Eyelink Gazetracker.
    % exit program if this fails.
    if ~EyelinkInit(dummymode)
        fprintf('Eyelink Init aborted.\n');
        cleanup;  % cleanup function
        return;
    end
    
    [v vs]=Eyelink('GetTrackerVersion');  % not necessary, we only use EL1000
    fprintf('Running experiment on a ''%s'' tracker.\n', vs );

    % open file to record data to
    i = Eyelink('Openfile', edfFile);
    if i~=0
        fprintf('Cannot create EDF file ''%s'' ', edffilename);
        cleanup;
%         Eyelink( 'Shutdown');
        return;
    end

    % creates a custom message at the top of the EDF file, that last
    % section of text, 245 character limit
    Eyelink('command', 'add_file_preamble_text ''Recorded by EyelinkToolbox demo-experiment''');    
    
    [width, height]=Screen('WindowSize', screenNumber);
    
    %% STEP 5: SET UP TRACKER CONFIGURATION    
    % Help for Data Viewer: Protocol
    Eyelink('command','screen_pixel_coords = %ld %ld %ld %ld', 0, 0, width-1, height-1); % tells to do something
    Eyelink('message', 'DISPLAY_COORDS %ld %ld %ld %ld', 0, 0, width-1, height-1); %logs it               
    % set calibration type.
    
    % you must send this command with value NO for custom calibration
    % you must also reset it to YES for subsequent experiments
    Eyelink('command', 'generate_default_targets = NO');
    
    % unique calibration
    Eyelink('command', 'calibration_type = HV3');  % set to HV5 or 3 for the smaller calibration for babies
    Eyelink('command','calibration_samples = 3');
    Eyelink('command','calibration_sequence = 0,1,2');
    Eyelink('command','calibration_targets = %d,%d %d,%d %d,%d',...
    round(width*.5),round(height*.25),round(width*.25),round(height*.75),...
    round(width*.75),round(height*.75));

    % unique validation
    Eyelink('command','validation_samples = 4');
    Eyelink('command','validation_sequence = 0,1,2');
    Eyelink('command','validation_targets = %d,%d %d,%d %d,%d',...
    round(width*.5),round(height*.25),round(width*.25),round(height*.75),...
    round(width*.75),round(height*.75));

    % set sampling rate
    Eyelink('command', 'sample_rate = 500');
    
    % set parser (conservative saccade thresholds)
    Eyelink('command', 'saccade_velocity_threshold = 35');
    Eyelink('command', 'saccade_acceleration_threshold = 9500');
    % set EDF file contents
    Eyelink('command', 'file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON');
    Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,AREA,GAZERES,STATUS,HTARGET'); % added HTARGET for eyelink 1000
    % set link data (used for gaze cursor)
    Eyelink('command', 'link_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON'); % link things available over the link for gaze contingent stuff
    Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS,HTARGET');% added HTARGET for eyelink 1000
    % allow to use the big button on the eyelink gamepad to accept the 
    % calibration/drift correction target
    Eyelink('command', 'button_function 5 "accept_target_fixation"');
        
    %% STEP 6: Calibrate the eye tracker  
    % setup the proper calibration foreground and background colors  
    % Hide the mouse cursor;
    Screen('HideCursorHelper', window);
    EyelinkDoTrackerSetup(el);  % the whole schzam (camera setup, calibration, validation) and no code will pass until you leave this section (press 'o')
	
    %% STEP 7: SETTING UP YOUR EXPERIMENT (loading stimuli and trial sequence) 
    % Each trial should have a pair of "StartRecording" and "StopRecording" 
    % calls as well integration messages to the data file (message to mark 
    % the time of critical events and the image/interest area/condition 
    % information for the trial)
        
    % Create randomized trial order for each participant
    array = create_all_pseudorandom_orders();
    
    % Create randomized exposure video presentation within each trial
    n_allowable_repetitions = 3;
    pos_number = 12;
    rand_array = create_pos_presentation(array, n_allowable_repetitions, pos_number);
    
    % Make video codes more readable (not numbers)
    for i = 1:4
        if i == 1
            rand_array = strrep(rand_array, '1', 'blick');
        elseif i == 2
            rand_array = strrep(rand_array, '2', 'moff');
        elseif i == 3
            rand_array = strrep(rand_array, '3', 'wug');
        elseif i == 4
            rand_array = strrep(rand_array, '4', 'zad');
        end
    end
    
    rand_array_video = rand_array;
    
    for i = 1:length(rand_array)
        x = randi([0,1],1,1);
        
        if x == 1
            rand_array_video(i,1) = strcat(rand_array(i,1), '.mp4');
            rand_array_video(i,1) = strcat('a1_', rand_array_video(i,1));
            
            rand_array_video(i,2) = strcat(rand_array(i,2), '.mp4');
            rand_array_video(i,2) = strcat('a2_', rand_array_video(i,2));
        else
            rand_array_video(i,2) = strcat(rand_array(i,2), '.mp4');
            rand_array_video(i,2) = strcat('a1_', rand_array_video(i,2));
            
            rand_array_video(i,1) = strcat(rand_array(i,1), '.mp4');
            rand_array_video(i,1) = strcat('a2_', rand_array_video(i,1));
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% Creating Test orders %%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    test_array = create_ext_order();
    
    test_array_randomized = create_pos_presentation(test_array, 2, 8);      
    
    for i = 1:4
        if i == 1
            test_array_randomized = strrep(test_array_randomized, '1', 'blick');
        elseif i == 2
            test_array_randomized = strrep(test_array_randomized, '2', 'moff');
        elseif i == 3
            test_array_randomized = strrep(test_array_randomized, '3', 'wug');
        elseif i == 4
            test_array_randomized = strrep(test_array_randomized, '4', 'zad');
        end
    end
    
    n_allowable_repetitions = 2;
    rand_array_test = create_test_order(test_array_randomized, n_allowable_repetitions);
    
    for i = 1:length(test_array_randomized)
        x = randi([0,1],1,1);
        
        if x == 1
            test_array_randomized(i,1) = strcat(test_array_randomized(i,1), '.mp4');
            test_array_randomized(i,1) = strcat('a1_', test_array_randomized(i,1));
            
            test_array_randomized(i,2) = strcat(test_array_randomized(i,2), '.mp4');
            test_array_randomized(i,2) = strcat('a2_', test_array_randomized(i,2));
        else
            test_array_randomized(i,2) = strcat(test_array_randomized(i,2), '.mp4');
            test_array_randomized(i,2) = strcat('a1_', test_array_randomized(i,2));
            
            test_array_randomized(i,1) = strcat(test_array_randomized(i,1), '.mp4');
            test_array_randomized(i,1) = strcat('a2_', test_array_randomized(i,1));
        end
    end
    
    test_array_pos = test_array_randomized(:, 1:2);
    
    % Create randomized audio labelling
    rand_array_audio = rand_array;
    %rand_audio_labelling = randi(2,1,24)';
    rand_audio_labelling = randi(2,1,12)';
    rand_audio_labelling = cellfun(@num2str, num2cell(rand_audio_labelling), 'UniformOutput',false);
    
    % Combine all the trial info
    exposure_rand_array_combos = horzcat(rand_array_video, rand_array_audio, rand_audio_labelling);
    test_rand_array_combos = horzcat(rand_array_test, test_array_pos);
    
    % Create data table for trial info
    exposure_rand_table = cell2table(exposure_rand_array_combos, 'VariableNames', {'leftVideo' 'rightVideo' 'leftAudio' 'rightAudio' 'audioOrder'});
    test_rand_table = cell2table(test_rand_array_combos, 'VariableNames', {'testQuestion' 'leftTestVideo' 'rightTestVideo'});
    
    % Path to Exposure and Test videos
    videoList_masterL = [];
    videoList_masterR = [];
    videoTestList_masterL = [];
    videoTestList_masterR = [];
    video_exposure_base_path = 'Users/babylab/Desktop/ToPICK/2 - methods/video stim/exposure_verbs/';
    video_test_base_path = 'Users/babylab/Desktop/ToPICK/2 - methods/video stim/test_verbs/';
    
    
    % For Exposure videos
    nvideos = 12;
    
    for i = 1:nvideos
        
        videoL = string(exposure_rand_table.leftVideo(i))';
        videoListL = {char(strcat(video_exposure_base_path,videoL))};
        videoList_masterL = [videoList_masterL ; videoListL];
        
        videoR = string(exposure_rand_table.rightVideo(i))';
        videoListR = {char(strcat(video_exposure_base_path,videoR))};
        videoList_masterR = [videoList_masterR ; videoListR];
   
    end
    
    % For Test videos
    nvideos = 8;
    for i = 1:nvideos
        
        videoTestL = string(test_rand_table.leftTestVideo(i))';
        videoTestListL = {char(strcat(video_test_base_path,videoTestL))};
        videoTestList_masterL = [videoTestList_masterL ; videoTestListL];
        
        videoTestR = string(test_rand_table.rightTestVideo(i))';
        videoTestListR = {char(strcat(video_test_base_path,videoTestR))};
        videoTestList_masterR = [videoTestList_masterR ; videoTestListR];
        
    end
    
    % Path to audio files
    audioList_master1 = [];
    audioList_master2 = [];
    
    audio_exposure_base_path = '/Users/babylab/Desktop/ToPICK/2 - methods/audio stim/exposure/';
    
    %naudio = 24;
    naudio = 12;
    
    % for Exposure audio
    for i = 1:naudio
        
        audio1 = string(exposure_rand_table.leftAudio(i))';
        audioList1 = {char(strcat(audio_exposure_base_path,audio1))};
        audioList1 = strcat(audioList1, '.wav');
        audioList_master1 = [audioList_master1 ; audioList1];
        
        audio2 = string(exposure_rand_table.rightAudio(i))';
        audioList2 = {char(strcat(audio_exposure_base_path,audio2))};
        audioList2 = strcat(audioList2, '.wav');
        audioList_master2 = [audioList_master2 ; audioList2];
        
    end
    
    % for Test audio
    audioTestList_master = [];
    audio_test_base_path = '/Users/babylab/Desktop/ToPICK/2 - methods/audio stim/test/';
    
    naudio = 8;
    for i = 1:naudio
        
        audio = string(test_rand_table.testQuestion(i))';
        audio1 = {char(strcat('find',audio))};
        audio1 = {char(strcat(audio1, '.wav'))};
        audioList1 = {char(strcat(audio_test_base_path,audio1))};
        audioTestList_master = [audioTestList_master ; audioList1];
        
    end
    
    varinputcondition = input('Which condition? G or N ', 's');
    
    if contains(varinputcondition, 'G')
        
        % Path to informant files
        informantList_master = [];
        informant_base_path = 'Users/babylab/Desktop/ToPICK/2 - methods/video stim/informant/gaze/';
        
        % Get audio order
        audioOrderList = exposure_rand_table.audioOrder(:);
        %audioList_master = [];
        
        for i = 1:length(audioOrderList)
            
            if contains(audioOrderList(i), '1')
                %informant = 'diagonal_left-right.mp4';
                
                informant1 = string(exposure_rand_table.leftAudio(i))';
                informant2 = string(exposure_rand_table.rightAudio(i))';
                informantList1 = {char(strcat(informant1,informant2))};
                informantListDir = {char(strcat('1',informantList1))};
                informantList1Path = {char(strcat(informant_base_path,informantListDir))};
                informantList1Wav = {char(strcat(informantList1Path,'.mp4'))};
                informantList_master = [informantList_master ; informantList1Wav];
                
            else
                %informant = 'diagonal_right-left.mp4';
                
                informant2 = string(exposure_rand_table.leftAudio(i))';
                informant1 = string(exposure_rand_table.rightAudio(i))';
                informantList1 = {char(strcat(informant1, informant2))};
                informantListDir = {char(strcat('2',informantList1))};
                informantList1Path = {char(strcat(informant_base_path,informantListDir))};
                informantList1Wav = {char(strcat(informantList1Path,'.mp4'))};
                informantList_master = [informantList_master ; informantList1Wav];
                informantList_master = cellstr(informantList_master);
                
            end
            
        end
        
    elseif contains(varinputcondition, 'N')
        
        % Path to informant no-gaze files
        informantList_master = [];
        informant_base_path = 'Users/babylab/Desktop/ToPICK/2 - methods/video stim/informant/no-gaze/';
        
        % Get audio order
        audioOrderList = exposure_rand_table.audioOrder(:);
        %audioList_master = [];
        
        for i = 1:length(audioOrderList)
            
            if contains(audioOrderList(i), '1')
                %informant = 'diagonal_left-right.mp4';
                
                informant1 = string(exposure_rand_table.leftAudio(i))';
                informant2 = string(exposure_rand_table.rightAudio(i))';
                informantList1 = {char(strcat(informant1,informant2))};
                informantListDir = {char(strcat('1',informantList1))};
                informantList1Path = {char(strcat(informant_base_path,informantListDir))};
                informantList1Wav = {char(strcat(informantList1Path,'.mp4'))};
                informantList_master = [informantList_master ; informantList1Wav];
                
            else
                %informant = 'diagonal_right-left.mp4';
                
                informant2 = string(exposure_rand_table.leftAudio(i))';
                informant1 = string(exposure_rand_table.rightAudio(i))';
                informantList1 = {char(strcat(informant1, informant2))};
                informantListDir = {char(strcat('2',informantList1))};
                informantList1Path = {char(strcat(informant_base_path,informantListDir))};
                informantList1Wav = {char(strcat(informantList1Path,'.mp4'))};
                informantList_master = [informantList_master ; informantList1Wav];
                informantList_master = cellstr(informantList_master);
                
            end
            
        end
        
    end
    
    %%%%%%%% Making extension test
    master_array_ext_vids = create_ext_order();
    
    ext_array = create_pos_presentation(master_array_ext_vids, 2, 8);
    
    ext_array_video = ext_array;
    
    for i = 1:4
        if i == 1
            ext_array = strrep(ext_array, '1', 'blick');
        elseif i == 2
            ext_array = strrep(ext_array, '2', 'moff');
        elseif i == 3
            ext_array = strrep(ext_array, '3', 'wug');
        elseif i == 4
            ext_array = strrep(ext_array, '4', 'zad');
        end
    end
    
    for i = 1:length(ext_array)
        x = randi([0,1],1,1);
        
        if x == 1
            ext_array_video(i,1) = strcat(ext_array(i,1), '.mp4');
            ext_array_video(i,1) = strcat('a1_', ext_array_video(i,1));
            
            ext_array_video(i,2) = strcat(ext_array(i,2), '.mp4');
            ext_array_video(i,2) = strcat('a2_', ext_array_video(i,2));
        else
            ext_array_video(i,2) = strcat(ext_array(i,2), '.mp4');
            ext_array_video(i,2) = strcat('a1_', ext_array_video(i,2));
            
            ext_array_video(i,1) = strcat(ext_array(i,1), '.mp4');
            ext_array_video(i,1) = strcat('a2_', ext_array_video(i,1));
        end
    end
    
    ExtListL_master = [];
    ExtListR_master = [];
    
    for i = 1:length(ext_array_video)
        
        videoL = string(ext_array_video(i,1))';
        videoListL = {char(strcat(video_test_base_path,videoL))};
        ExtListL_master = [ExtListL_master ; videoListL];
        
        videoR = string(ext_array_video(i,2))';
        videoListR = {char(strcat(video_exposure_base_path,videoR))};
        ExtListR_master = [ExtListR_master ; videoListR];
    end
    
    n_allowable_repetitions = 2;
    ext_test_order = create_test_order(ext_array_video, n_allowable_repetitions);
    
    audioExtList_master = [];
    
    for i = 1:length(ext_test_order)
        
        audio = string(ext_test_order(i))';
        audio1 = {char(strcat('find',audio))};
        audio1 = {char(strcat(audio1, '.wav'))};
        audioList1 = {char(strcat(audio_test_base_path,audio1))};
        audioExtList_master = [audioExtList_master ; audioList1];
        
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% Warm-up trials %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    imgList = cellstr(['/Users/babylab/Desktop/ToPICK/2 - methods/img stim/a1.png'; ...
        '/Users/babylab/Desktop/ToPICK/2 - methods/img stim/a2.png']);
    
    audio = '/Users/babylab/Desktop/ToPICK/2 - methods/audio stim/toy.wav';
    
    show_images_with_audio(imgList, window, audio);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% Exposure %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    trial = 0;
    
    for i = 1:length(rand_array)
        
        varinput = input('Type c to continue or q to quit', 's');
        
        if contains(varinput, 'c')
            
            % Now within the scope of each trial
            trial = trial +1

            % Get the videos to be played during Exposure
            leftVideo = videoList_masterL(i);
            rightVideo = videoList_masterR(i);
           
            % Audio
            leftAudio = string(exposure_rand_table.leftAudio(i))';
            rightAudio = string(exposure_rand_table.rightAudio(i))';
                        
            % Get the informant video
            informantVideo = informantList_master(i);

            % Get ordering of audio
            audioOrder = audioOrderList(i);
   
            % Prepare and show Exposure screen. 
            play_video_eyetracker_audio_exposure(leftVideo, rightVideo, informantVideo,window,el,width, height,trial, wRect, audioOrder, leftAudio, rightAudio);

            WaitSecs(0.5); 
            
            % Attention-getter
            if trial == 4
                video = {'Users/babylab/Desktop/ToPICK/2 - methods/video stim/bubbles.blue.mp4'};
                audio = '/Users/babylab/Desktop/ToPICK/2 - methods/audio stim/attention-getters/seeThat.wav';
                play_video_with_audio(video, window, trial, audio, width, height);
                
            elseif trial == 8
                video = {'Users/babylab/Desktop/ToPICK/2 - methods/video stim/bubbles.orange.mp4'};
                audio = '/Users/babylab/Desktop/ToPICK/2 - methods/audio stim/attention-getters/wowLookAtThis.wav';
                play_video_with_audio(video, window, trial, audio, width, height);
                
            elseif trial == 12
                video = {'Users/babylab/Desktop/ToPICK/2 - methods/video stim/bubbles.multi.mp4'};
                audio = '/Users/babylab/Desktop/ToPICK/2 - methods/audio stim/attention-getters/youDidIt.wav';
                play_video_with_audio(video, window, trial, audio, width, height);
            end
            
        elseif contains(varinput, 'q')
            break 
        end
        
        WaitSecs(0.001); %%% in between every 5-10 messages wait at least 1ms because we could flood the channel and start to miss some messages
        
    end
    
    %%%%%%%% Test trials %%%%%%%%
    
    for i = 1:length(rand_array_test)
        
        varinput = input('Type c to continue or q to quit', 's');
        
        if contains(varinput, 'c')
            % Now within the scope of each trial
            trial = trial +1

            % Get the videos to be played during Test
            leftTestVideo = videoTestList_masterL(i);
            rightTestVideo = videoTestList_masterR(i);
            
            % Audio
            testAudio = audioTestList_master(i);
            
            % Prepare and show Test screen.
            play_video_eyetracker_audio_test(leftTestVideo, rightTestVideo,window,el,width, height,trial, wRect, testAudio);
            
            WaitSecs(0.5);
            
        elseif contains(varinput, 'q')
            break
        end
        
        WaitSecs(0.001); %%% in between every 5-10 messages wait at least 1ms because we could flood the channel and start to miss some messages
        
    end
    
    %%%%%%%% Play intermission movie %%%%%%%%
    WaitSecs(1);
    
    moviename = {'C:\Users\babylab\Desktop\ToPICK\2 - methods\video stim\daniel.mp4'};
    play_video(moviename,window,0)
        
    %%%%%% Extensions %%%%%%%%
    
    for i = 1:length(ext_array)
        
        varinput = input('Type c to continue or q to quit', 's');
        
        if contains(varinput, 'c')
            trial = trial +1
            
            leftVideo = ExtListL_master(i);
            rightVideo = ExtListR_master(i);
            
            testAudio = audioExtList_master(i);
            
            play_video_eyetracker_audio_exttest(leftVideo, rightVideo,window,el,width, height,trial, wRect, testAudio);
            
        elseif contains(varinput, 'q')
            break
        end
        
        WaitSecs(0.001); %%% in between every 5-10 messages wait at least 1ms because we could flood the channel and start to miss some messages
        
    end
    
    %%%%% Make note of condition %%%%%
    %Eyelink('Message', '!V TRIAL_VAR Condition %s', varinputcondition)
    
    % STEP 8
    % End of Experiment; close the file first   
    % close graphics window, close data file and shut down tracker
        
    Eyelink('Command', 'set_idle_mode');
    WaitSecs(0.5);
    Eyelink('CloseFile');

    % download data file  % try to make sure that we get the entire file
    try
        fprintf('Receiving data file ''%s''\n', edfFile );
        status=Eyelink('ReceiveFile');
        if status > 0
            fprintf('ReceiveFile status %d\n', status);
        end
        if 2==exist(edfFile, 'file')
            fprintf('Data file ''%s'' can be found in ''%s''\n', edfFile, pwd );
        end
    catch
        fprintf('Problem receiving data file ''%s''\n', edfFile );
    end
    
    save('data')
    
    % STEP 9
    % run cleanup function (close the eye tracker and window).
    cleanup;
%     Eyelink('ShutDown');
%     Screen('CloseAll');

catch
     %this "catch" section executes in case of an error in the "try" section
     %above.  Importantly, it closes  the onscreen window if its open.
     cleanup;
    Eyelink('ShutDown');
    Screen('CloseAll');
    psychrethrow(psychlasterror);
end %try..catch.

% Cleanup routine:
function cleanup
% Shutdown Eyelink:
Eyelink('Shutdown');
ListenChar(1);
% Close window:
sca;
commandwindow;
