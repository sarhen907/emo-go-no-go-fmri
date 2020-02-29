function emo(record_id,isscan)
%=======================================================================
%   Altered Emotional Go/No-Go Task

%   Sarah Hennessy 2018

%   This program displays photos of happy, scared, or neutral
%   faces for participants to respond to. Participants will
%   press a button if the correct expression appears on
%   the screen (i.e. happy; press only for happy face)
%   Each run consists of only two emotions and one go stimuli.
%   Certain blocks will have a differing background color to signify
%   reward, negative event, or nothing at all.
%

% Each pair first presents an introductory screen that informs subjects of
% the 'go' emotion and the 'no go' emotion. A colored screen will then pop
% up indicating the event type.
%
% ---- Pairs ----
%       3 combinations of happy, neutral, and scared faces. Each pair of emotions will
%       have a turn at being go and nogo. (go *2 v nogo)
%       happy v fearful & neutral      fearful v happy & neutral
%       neutral v happy & fearful
% ---- Blocks ----
%       3 color blocks within each run
%       PURPLE = neutral
%       GREEN = exciting (win a reward of up to $100)
%       RED = fear inducing (hear an unpleasant white noise)
%           Before each block, a screen will remind the participant of
%           event/color combinations.
%---- Trials ----
%       Number of Trials = the number of images within each block.
%       For time/length purposes, number of trials should be 18 per pair
%       for a total of 108 images in each block. The experiment will take
%       about 8.5 minutes in total.
%
%       Each image will appear for 500 ms.
%       There will be a 1-5 s pause between images


%  For a more detail task design, please contact Sarah /Priscilla or go to
%  the Server > Longitudinal > Task Designs

clear all;
%=======================================================================
%%
%-----------------------------------------------------------------------
%Log in Prompts
%-----------------------------------------------------------------------
record_id = input('Enter subject name: ', 's');
isscan = input('block = 1:2 : ');
%%
%-----------------------------------------------------------------------
%Screen Set Up
%-----------------------------------------------------------------------

%setup
sca;
close all;
Screen('Preference', 'SkipSyncTests',1);
screens = Screen('Screens');

%NEWER VERSIONS OF MATLAB USE:
%screenNumber = max(1);

%FOR OLDER VERSIONS OF MATLAB USE:
screenNumber = max(screens);

%set colors
white = WhiteIndex(screenNumber); black = BlackIndex(screenNumber);
block_color=black; textcolor=white;
% USE THESE LINES FOR SET SCREEN

%WHEN TROUBLESHOOTING, USE
%screenRect = [0 0 1024 768];
%[w, ~] = Screen('OpenWindow', screenNumber, 0, [0 0 1024 768]);%, screenRect);


%WHEN SCANNING, USE
 [w, ~]=PsychImaging('OpenWindow', screenNumber, block_color);

%Always use,
[screenXpixels, screenYpixels] = Screen('WindowSize', w);




%%
%-----------------------------------------------------------------------
%Load and Randomize ITI orders
%-----------------------------------------------------------------------

%Load ITI orders
itifile = load('emo_iti_shorter.mat');

%Shuffle ITIs
itiorder = Shuffle(itifile.x);

% if isscan == 0
%     itiorder = itiorder(1:10);
% end

%%
%-----------------------------------------------------------------------
%Set up log files and check to avoid existing file
%-----------------------------------------------------------------------

%Create logfile names
logfilename = sprintf('%s_emo_gonogo_run%d.txt', record_id, isscan); %create name for logfile


%Check if logfiles exist
if exist([pwd '/data/',logfilename], 'file') == 2
    file_error = input('That file already exists! Press ENTER and try again. ');
    KbWait(-1);
    emo();
    if isempty(file_error)
        return;
    end
end

% Open logfiles
fprintf('Opening logfile: %s\n', logfilename);
logfile = fopen([pwd '/data/', logfilename], 'a'); %open logfile



% Set up logfile data
fprintf(logfile, 'record_id\ttrial\ttrialonset\ttriallength\tstimonset\tstimlength\tcondition\temotion\tcolor\taccuracy\trt\n');
%%
%________________________________________________________________________
% Images, textures, and Colors
%________________________________________________________________________

%Get images

%GET ALL IMAGES - must be in the correct folder
HappyImages = dir(fullfile('NIMSTIM','*_HA_*.BMP'));
FearImages = dir(fullfile('NIMSTIM','*_FE_*.BMP'));
NeutralImages = dir(fullfile('NIMSTIM','*_NE_C.BMP'));


%Get number of images to randomize image
xhappy = size(HappyImages,1);
xneutral = size(NeutralImages, 1);
xfear = size(FearImages,1);

HAPPY = imread(fullfile('NIMSTIM',HappyImages(randi([1,xhappy])).name));
NEUTRAL = imread(fullfile('NIMSTIM',NeutralImages(randi([1,xneutral])).name));
FEARFUL = imread(fullfile('NIMSTIM',FearImages(randi([1, xfear])).name));

pair1p = imread(fullfile('instruct', 'pair1p.png'));
pair1g = imread(fullfile('instruct', 'pair1g.png'));
pair1r = imread(fullfile('instruct', 'pair1r.png'));
pair2p = imread(fullfile('instruct', 'pair2p.png'));
pair2g = imread(fullfile('instruct', 'pair2g.png'));
pair2r = imread(fullfile('instruct', 'pair2r.png'));
pair3p = imread(fullfile('instruct', 'pair3p.png'));
pair3g = imread(fullfile('instruct', 'pair3g.png'));
pair3r = imread(fullfile('instruct', 'pair3r.png'));


makepair1_p = Screen('MakeTexture', w, pair1p);
makepair1_g = Screen('MakeTexture', w, pair1g);
makepair1_r = Screen('MakeTexture', w, pair1r);
makepair2_p = Screen('MakeTexture', w, pair2p);
makepair2_g = Screen('MakeTexture', w, pair2g);
makepair2_r = Screen('MakeTexture', w, pair2r);
makepair3_p = Screen('MakeTexture', w, pair3p);
makepair3_g = Screen('MakeTexture', w, pair3g);
makepair3_r = Screen('MakeTexture', w, pair3r);

%Set the Background colors
green = [0 170 0];
purple = [100 0 150];
red = [170 0 0];

%% _____________
% Set Variables
%___________________

accuracy = [];
rt = [];
emotion ='';

%RANDOMIZE ORDER OF THINGS
PairOrder = randperm(3,3);
sound_event = 'incomplete';
cash_event = 'incomplete';



%TIMING

imgwait = 0.5;
keypressed = 0;
rt = 0;


%%  do the actual experiment
%

    Screen('TextSize',w,35);
    Screen('TextFont',w,'Comic Sans MS');
    
    %INSTRUCTIONS
    DrawFormattedText(w, ['We are now going to play that game that we practiced before!\n'...
        '\nRemember: the screen will tell you\n which type of face to press for -- \nfearful, happy, or neutral.\n'...
        '\nThen, your job is to go AS FAST AS YOU CAN!\n\n'...
        '\n\nAnd don''t forget! When the background is GREEN, \nyou could win money!\n'...
        '\nWhen the background is RED,\n you could hear a loud noise!\n'...
        '\nAnd when the background is PURPLE,\n no event will happen.'], 'center', 'center', textcolor);
    Screen(w, 'Flip');
    KbWait(-1)
    WaitSecs(0.5);
    
    DrawFormattedText(w, 'Get Ready!', 'center', 'center', textcolor);
    Screen(w, 'Flip');
    fprintf('\nwaiting for scanner trigger...');
    
    %doneCode=KbName('6^');
    doneCode=KbName('5%');
    
    while 1
        [ keyIsDown, timeSecs, keyCode ] = KbCheck(-1);
        if keyIsDown
            index=find(keyCode);
            if (index==doneCode)
                timeStart = timeSecs; %Record start time
                break;
            end
        end
    end
    
    fprintf('drawing initial black screen. We will start in 5 seconds\n');
    Screen('FillRect', w, black);
    Screen('Flip',w);
    WaitSecs(5);
    
    %% BEGIN THE LOOP
   %________________________________________________________________
    
    %Loop the pairs
    DisableKeysForKbCheck(doneCode);
    for i = 1:3
        
        dims = [240 640];
        xcenter = screenXpixels/2;
        x = xcenter - dims(1); 
        y = screenYpixels*0.3 + 100; 
        
        pairtype = PairOrder(i);
        
        if pairtype == 1
            go1 = 'HAPPY'; 
            go2 = 'FEARFUL';
            nogo = 'NEUTRAL';
        elseif pairtype == 2
            go1 = 'HAPPY';
            go2 = 'NEUTRAL';
            nogo = 'FEARFUL';
        elseif pairtype == 3
            go1 = 'NEUTRAL';
            go2 = 'FEARFUL';
            nogo = 'HAPPY';
        end
        
        %PAIR-SPECIFIC INSTRUCTIONAL TEXT
        
        Screen('FillRect', w, black);
        DrawFormattedText(w, ['PRESS for:' go1 ' and ' go2 ...
            ' faces.'...
            '\n\n DO NOT PRESS for a ' nogo ' face.'...
            '\n\n Answer as quickly and accurately as possible.'],...
            'center', screenYpixels*0.3, white);
        Screen('Flip', w);
        WaitSecs(7);
        ColorOrder = randperm(3,3);
        %Loop the colors within the pairs
        for a = 1:3
            if ColorOrder(a) == 1
                block_color = [100 0 150]; block_color_name = 'purple';
                block_event = ', \n you will not hear a noise or win any money.';
            elseif ColorOrder(a) == 2
                block_color = [0 170 0]; block_color_name = 'green';
                block_event = ', \n there is a chance that you will win up to $100.';
            else
                block_color = [170 0 0]; block_color_name = 'red';
                block_event = ', \n there is a chance that you will hear a loud noise.';
            end
            
            
            Screen('FillRect', w, block_color);
            if pairtype == 1
                if ColorOrder(a) == 1
                    inimage = makepair1_p;
                elseif ColorOrder(a) == 2
                    inimage = makepair1_g;
                elseif ColorOrder(a) == 3
                    inimage = makepair1_r;
                end
                
            elseif pairtype == 2
                if ColorOrder(a) == 1
                    inimage = makepair2_p;
                elseif ColorOrder(a) == 2
                    inimage = makepair2_g;
                elseif ColorOrder(a) == 3
                    inimage = makepair2_r;
                end
                
                
            elseif pairtype == 3
                if ColorOrder(a) == 1
                    inimage = makepair3_p;
                elseif ColorOrder(a) == 2
                    inimage = makepair3_g;
                elseif ColorOrder(a) == 3
                    inimage = makepair3_r;
                end
            end
            
            %BLOCK wait time + INSTRUCTIONS
            Screen('FillRect',w, black);
            DrawFormattedText(w, 'We will start the next part shortly',...
                'center', screenYpixels*0.3, white);
            Screen('Flip',w);
            WaitSecs(15);
        
            
            Screen('FillRect', w, block_color);
            Screen('DrawTexture', w, inimage);
            Screen('Flip', w);
            WaitSecs(10);
           
            blockstart = GetSecs-timeStart;
            
            makeup_time = [];
            itimat = [];
            iprepmat = [];
            %Shuffle ITIs
            itiorder = Shuffle(itifile.x);
            
            OrderList = randperm(15, 15);
            
            while OrderList((1)) > 12
                OrderList = Shuffle(OrderList);
                while OrderList((2)) > 12
                    OrderList = Shuffle(OrderList);
                    while OrderList((3)) > 12
                        OrderList = Shuffle(OrderList);
                    end
                end
            end
            
            
            %Loop the trials within colors within pairs
            for j = 1:15
                eventoff = 0;
                
                fprintf('\n you are on trial %d/15 of color %d/3 of pair %d/3', j,a,i);
                
                imgprepstart = GetSecs-timeStart;
                if pairtype == 1
                    go1Random = HappyImages(randi([1,xhappy])).name;
                    go2Random =  FearImages(randi([1, xfear])).name;
                    nogoRandom = NeutralImages(randi([1,xneutral])).name;
                elseif pairtype == 2
                    go1Random = HappyImages(randi([1,xhappy])).name;
                    go2Random = NeutralImages(randi([1,xneutral])).name;
                    nogoRandom = FearImages(randi([1, xfear])).name;
                elseif pairtype == 3
                    go1Random = NeutralImages(randi([1,xneutral])).name;
                    go2Random = FearImages(randi([1, xfear])).name;
                    nogoRandom = HappyImages(randi([1,xhappy])).name;
                end
                
                ifprepend = GetSecs-timeStart;
                ifprep = ifprepend-imgprepstart;
                
                readstart = GetSecs-timeStart;
                imgo1 = imread(fullfile('NIMSTIM',go1Random));
                imgo2 = imread(fullfile('NIMSTIM',go2Random));
                imnogo = imread(fullfile('NIMSTIM',nogoRandom));
                readend = GetSecs- timeStart;
                read = readend-readstart;
                
                textstart = GetSecs-timeStart;
                go1Face = Screen('MakeTexture',w,imgo1);
                go2Face = Screen('MakeTexture',w,imgo2);
                nogoFace = Screen('MakeTexture',w,imnogo);
                
                imgprepend = GetSecs-timeStart;
                text = imgprepend-textstart;
                
                alliprep = imgprepend-imgprepstart;
%                 fprintf('\n\nyour total image prep time was: %0.4f', alliprep);
%                 fprintf('\nyour if image prep time was: %0.4f', ifprep);
%                 fprintf('\nyour read time was %0.4f', read);
%                 fprintf('\nyour make texture time was %0.4f', text);
                
                
                orderstart = GetSecs-timeStart;
                
                %PRESENT THE IMAGE (12 go, 3 nogo)
                if OrderList((j)) <= 6
                    Screen('DrawTexture', w, go1Face);
                    answer='go';
                    emotion = go1;
                elseif OrderList((j)) > 6 && OrderList((j)) < 13
                    Screen('DrawTexture', w, go2Face);
                    answer='go';
                    emotion = go2;
                elseif OrderList((j)) > 12
                    Screen('DrawTexture', w, nogoFace);
                    answer='nogo';
                    emotion = nogo;
                end
                orderend = GetSecs-timeStart;
                
                ordertime = orderend-orderstart;
%               fprintf('\n the time it took to choose the face was: %0.6f', ordertime);
                
                [vbl, timeStart2] = Screen('Flip',w);
                
               
                trial_onset = GetSecs-timeStart;
                stim_onset = GetSecs-timeStart;
                
                imgwait = 0.5;
                keypressed = 0;
                rt = 0;
                beenhere = 0;
             
                %RESP WINDOW
                %WAIT FOR KEYPRESS OR FOR TIMEOUT
               while 1
                    if ((GetSecs - timeStart2) >= 0.5 && keypressed == 0 && beenhere == 0)
                        Screen('Flip', w);
                        beenhere = 1;
                        stimoff = GetSecs - timeStart;
                    end
                    if ((GetSecs-timeStart2) > 1)
                        break;
                    end
                    %     check if key is pressed
                    [keyIsDown, keyTime, keyCode] = KbCheck(-1);
                    if (keyIsDown) && (find(keyCode) == KbName('1!') || find(keyCode) == KbName('2@') || find(keyCode) == KbName('3#') || find(keyCode) == KbName('4$'))
     
                        keypressed = 1;
                        rt = 1000.*(keyTime - timeStart2);
                        rttime = GetSecs- timeStart2;
                        
                        if ((GetSecs-timeStart2) < imgwait)
                            Screen('Flip', w);
                            stimoff = GetSecs- timeStart;
                            rttime = GetSecs- timeStart2;
                        elseif ((GetSecs -timeStart) > imgwait)
                            rttime = GetSecs- timeStart2;
                        end
                        break;
                      
                    end
               end
               
                %fprintf('if 1 took: %0.6f', (if1_off-if1_on));
            
                %determine extra fixation time
                if keypressed == 1
                    if strcmp(answer,'go')
                        correct=1;
                    elseif strcmp(answer,'nogo')
                        correct = 0;
                    end
                    
                  Screen('FillRect',w,block_color);
                     Screen('Flip',w);
                     extratime = (1-rttime);
                     WaitSecs(extratime);
                 
                elseif keypressed == 0
                    if strcmp(answer,'go')
                        correct = 0; 
                    elseif strcmp(answer,'nogo')
                        correct = 1;
                    end                
                end
              
                stim_length = stimoff - trial_onset;
                trialoff = GetSecs- timeStart;
               % fprintf('\nstim length is: %0.6f', stim_length)
                %Sound code from http://www.h6.dion.ne.jp/~fff/old/technique/auditory/matlab.html
                
                if i==1 && (.5>=rand()) && (j>3) || i == 1 && j == 14
                    if strcmp(sound_event,'incomplete') && strcmp(block_color_name,'red')
                        Screen('FillRect',w,block_color);
                        Screen('Flip',w);
                        sf = 22050; nf = sf / 2; dur = 1.0;
                        nsample = sf * dur;
                        noise = randn(1, nsample);
                        noise = noise / max(abs(noise));
                        sound(noise, sf); pause(dur + 0.5);
                        sound_event='complete';
                        event = 'sound';
                        eventtime = 1.5;
                        eventoff = 1;
                        fprintf('\n the sound went off!');
                    elseif strcmp(cash_event,'incomplete') && strcmp(block_color_name,'green')
                        Screen('FillRect',w,block_color);
                        DrawFormattedText(w,'Congratulations! You have won $5!','center',...
                            'center',black);
                        Screen('Flip',w);
                        WaitSecs(.5);
                        cash_event = 'complete';
                        event = 'cash';
                        eventoff = 1;
                        eventtime = 0.5;
                        fprintf('\n the reward event went off!');
                    end
                end
                
               
                trial_length = (trialoff - trial_onset);
                fprintf('\ntrial length %0.6f', trial_length);
                
                %WRITE DATA
                fprintf(logfile, '%s\t%d\t%0.6f\t%0.6f\t%0.6f\t%0.6f\t%s\t%s\t%s\t%d\t%0.3f\n',...
                    record_id,j,trial_onset,trial_length,stim_onset,stim_length,answer,emotion,block_color_name,correct,rt);

                
                %Present blank screen for iti
                
                Screen('FillRect', w, block_color);
                Screen('Flip', w);
                itistart = GetSecs-timeStart;
                
               
                %Make up for time created by the image readings
                waititi = itiorder((j));
                if j == 1
                    if alliprep < waititi
                        waititi = waititi-alliprep;
                        makeup_add = 0;
                    else
                        makeup_add = alliprep- waititi;
                        waititi = 0;
                    end
                elseif j ~= 1
                    if alliprep < waititi
                        waititi = waititi - alliprep;
                        makeup_add = 0;
                    elseif alliprep > waititi
                        if alliprep < makeup_time((j-1))
                            waititi = waititi - (makeup_time((j-1)));
                        else
                            makeup_add = alliprep - waititi;
                            waititi = 0;
                        end
                    end
                end
                makeup_time = [makeup_time, makeup_add];
               % fprintf('\n\ni adjusted my iti to be: %0.6f', waititi);

                WaitSecs(waititi);
                itiend = GetSecs-timeStart;
                ititime = itiend-itistart;
                itimat = [itimat, ititime];
                iprepmat = [iprepmat, alliprep];
                
                fprintf('\n Answer: %s', answer);

            end
            grandtotal = sum(itimat) + sum(iprepmat);
            grandtotaldif = abs(29.6 - grandtotal);
            blockend = GetSecs- timeStart;
            blocklength = blockend-blockstart;
            fprintf('\n\n your block length was %0.3f s', blocklength);
            fprintf('\n your total iti time for this block was %0.3f s, with a mean of %0.3f s', sum(itimat), mean(itimat));
            fprintf('\n BUT your total image prep time for this block was %0.3f s, with a mean of %0.3f s', sum(iprepmat), mean(iprepmat));
            fprintf('\n after all of the adjustments... \nthe grand total of iti + img prep for this block was %0.3f s, which is only %0.2f s off!\n\n', grandtotal, grandtotaldif);
    
        end
    end
    
    
    %End screen
    Screen('FillRect',w,white);
    DrawFormattedText(w,'This concludes the session.','center','center',black);
    Screen('Flip',w);
    WaitSecs(3);
    
    Screen('CloseAll');
    sca;
    
    toldyou = GetSecs-timeStart;
    fprintf('\n\n\nYOUR TIME WAS: %0.3f minutes\n', (toldyou/60));
    clear all;
end











