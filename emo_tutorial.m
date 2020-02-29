function emo_tutorial(record_id)

% Altered Emotional Go/No-Go Task

%   Sarah Hennessy 2018

% THIS IS A TUTORIAL
record_id = input('record id: ','s');
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
screenRect = [0 0 1024 768];
[w, ~] = Screen('OpenWindow', screenNumber, 0, [0 0 1024 768]);%, screenRect);


%WHEN SCANNING, USE
% [w, ~]=PsychImaging('OpenWindow', screenNumber, block_color);

%Always use,
[screenXpixels, screenYpixels] = Screen('WindowSize', w);


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

makehappy = Screen('MakeTexture',w,HAPPY);
makeneutral = Screen('MakeTexture',w,NEUTRAL);
makefearful = Screen('MakeTexture',w,FEARFUL);
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



%RANDOMIZE ORDER OF THINGS
PairOrder = randperm(3,3);
sound_event = 'incomplete';
cash_event = 'incomplete';
ColorOrder = randperm(3,3);
OrderList = randperm(5,5);

while OrderList((1)) > 12 
    OrderList = Shuffle(OrderList);
    while OrderList((2)) > 12
        OrderList = Shuffle(OrderList);
        while OrderList((3)) > 12
            OrderList = Shuffle(OrderList);
        end
    end
end
%% Begin
tic;
fprintf('press enter to start');
    
    %INSTRUCTIONS
    Screen('TextSize',w,30);
    Screen('TextFont',w,'Comic Sans MS');
    DrawFormattedText(w, ['In this game, you will see a series of faces appear on the screen.'...
        '\n\n You will be asked to press the button \n for certain facial expressions (ex. "happy" or "fearful").'],...
        'center','center', textcolor);
    Screen(w, 'Flip');
    KbWait(-1);
    WaitSecs(0.5);
    
    DrawFormattedText(w, 'One picture will appear at a time.\n Answer as quickly as you can.',...
        'center','center', textcolor);
    Screen(w, 'Flip');
    KbWait(-1);
    WaitSecs(0.5);
    
    DrawFormattedText(w, ['While you are going through the images,\n the background color may be green, red, or purple.'...
        '\n\n If the background is green,\n you could win up to $100.'...
        '\n\n If the background is red, \nyou might hear a loud, shocking noise.'...
        '\n\n The chances of these events \nis determined randomly by the computer.'...
        '\n\n If the background is purple, \nno event will happen.'],...
        'center','center', textcolor);
    Screen(w, 'Flip');
    KbWait(-1);
    WaitSecs(0.5);
    
    
    DrawFormattedText(w, 'You will be reminded of the color meanings before each change.',...
        'center','center', textcolor);
    Screen(w, 'Flip');
    KbWait(-1);
    WaitSecs(0.5);
    
    
    Screen('FillRect', w, block_color);
    DrawFormattedText(w, 'First, I''m going to show you \nsome faces so you know what they look like.', 'center', 'center', textcolor);
    Screen(w, 'Flip');
    KbWait(-1)
    WaitSecs(0.5);
    
    %Show the 3 types of faces
    
    Screen('DrawTexture', w, makehappy);
    DrawFormattedText(w, 'Happy...',...
        screenXpixels*.1, screenYpixels*.25, black);
    Screen('Flip',w);
    KbWait(-1);
    WaitSecs(0.5);
    
    
    Screen('DrawTexture', w, makeneutral);
    DrawFormattedText(w, 'Neutral...',...
        screenXpixels*.1, screenYpixels*.25, black);
    Screen('Flip',w);
    KbWait(-1);
    WaitSecs(0.5);
    
    Screen('DrawTexture', w, makefearful);
    DrawFormattedText(w, 'and Fearful.',...
        screenXpixels*.1, screenYpixels*.25, black);
    Screen('Flip',w);
    KbWait(-1);
    WaitSecs(0.5);
    
    %Introduce the display background colors
    
    Screen('FillRect', w, block_color);
    DrawFormattedText(w, 'Now, I''m going to show you \nwhat the different background colors look like.', 'center', 'center', textcolor);
    Screen(w, 'Flip');
    KbWait(-1);
    WaitSecs(0.5);
    
    %Red
    
    %Red info screen
    Screen('FillRect', w, red);
    DrawFormattedText(w, ['When the screen is red, '...
        '\n you might hear a loud, shocking noise.... like this!'],...
        'center', screenYpixels*0.3, black);
    Screen('Flip',w);
    KbWait(-1);
    WaitSecs(0.5);
    
    fprintf('\npress any key to make the sound')
   
    Screen('FillRect',w,red);
    Screen('Flip',w);
    sf = 22050; nf = sf / 2; dur = 1.0;
    nsample = sf * dur;
    noise = randn(1, nsample);
    noise = noise / max(abs(noise));
    sound(noise, sf); pause(dur + 0.5);
    
    %Green info screen
    Screen('FillRect', w, green);
    DrawFormattedText(w, ['When the screen is green,'...
        '\n there is a chance you will win up to $100.'],...
        'center', screenYpixels*0.3, black);
    Screen('Flip',w);
    KbWait(-1);
    WaitSecs(0.5);
    
    %Purple info screen
    Screen('FillRect', w, purple);
    DrawFormattedText(w, ['When the screen is purple, '...
        '\n you will not hear a noise or win any money.'],...
        'center', screenYpixels*0.3, black);
    Screen('Flip',w);
    KbWait(-1);
    WaitSecs(0.5);
    
    %TRIAL
    Screen('FillRect', w, black);
    DrawFormattedText(w, ['Now, try it out! \n\nThe following is a short tutorial version '...
        '\n of the real game. Practice answering to be prepared for the full trial!'...
        '\n\n'],...
        'center', screenYpixels*0.3, white);
    
    Screen('Flip',w);
    KbWait(-1);
    
    Screen('FillRect', w, black);
    Screen('Flip',w);
    WaitSecs(1);
    
    Screen('FillRect', w, black);
    DrawFormattedText(w, ['Press the button when a HAPPY and NEUTRAL' ...
        ' face appears on the screen.'...
        '\n\n Do not press for a FEARFUL face'...
        '\n\n Answer as quickly and accurately as possible.'],...
        'center', screenYpixels*0.3, white);
    Screen('Flip', w);
    KbWait(-1);
    WaitSecs(.5);
    
    Screen('FillRect', w, green);
    DrawFormattedText(w, ['Reminder: Press for HAPPY and NEUTRAL faces. \nDo not press for FEARFUL faces!'...
        '\n\n Because the background color is green, \nthere is a chance you will win up to $100.'...
        '\n\n Get ready!'],...
        'center', screenYpixels*0.3, black);
    Screen('Flip',w);
    WaitSecs(7);
    
    %Display images in trial timing
    %Always happy->neutral->happy
    HAPPY = imread(fullfile('NIMSTIM',HappyImages(randi([1,xhappy])).name));
    makehappy = Screen('MakeTexture',w,HAPPY);
    Screen('DrawTexture', w, makehappy);
    Screen('Flip',w);
    WaitSecs(.5);
    Screen('Flip',w);
    WaitSecs(2.5);
    
    NEUTRAL = imread(fullfile('NIMSTIM',NeutralImages(randi([1,xneutral])).name));
    makeneutral = Screen('MakeTexture',w,NEUTRAL);
    Screen('DrawTexture', w, makeneutral);
    Screen('Flip',w);
    WaitSecs(.5);
    Screen('Flip',w);
    WaitSecs(4);
    
    HAPPY = imread(fullfile('NIMSTIM',HappyImages(randi([1,xhappy])).name));
    makehappy = Screen('MakeTexture',w,HAPPY);
    Screen('DrawTexture', w, makehappy);
    Screen('Flip',w);
    WaitSecs(.5);
    Screen('Flip',w);
    WaitSecs(3);
    
    %Display the correct answers
    Screen('FillRect', w, black);
    DrawFormattedText(w, '\n\n Let''s try that again!',...
        'center', screenYpixels*0.3, white);
    Screen('Flip',w);
    KbWait(-1);
    
    %Again
    
    Screen('FillRect', w, black);
    Screen('Flip',w);
    WaitSecs(1);
    
    Screen('FillRect', w, black);
    DrawFormattedText(w, ['Press the button when a neutral' ...
        ' or fearful face appears on the screen.'...
        '\n\n Do not press for a happy face.'...
        '\n\n Answer as quickly and accurately as possible.'],...
        'center', screenYpixels*0.3, white);
    Screen('Flip', w);
    KbWait(-1);
    WaitSecs(.5);
    
    Screen('FillRect', w, red);
    DrawFormattedText(w, ['Reminder: Press for NEUTRAL faces and FEARFUL.\n Do not press for HAPPY faces!'...
        '\n\n Because the background color is red,\n there is a chance you will hear a loud noise.'...
        '\n\n Get ready!'],...
        'center', screenYpixels*0.3, black);
    Screen('Flip',w);
    WaitSecs(7);
    
    %Display images in trial timing
    HAPPY = imread(fullfile('NIMSTIM',HappyImages(randi([1,xhappy])).name));
    makehappy = Screen('MakeTexture',w,HAPPY);
    Screen('DrawTexture', w, makehappy);
    Screen('Flip',w);
    WaitSecs(.5);
    Screen('Flip',w);
    WaitSecs(2.5);
    
    NEUTRAL = imread(fullfile('NIMSTIM',NeutralImages(randi([1,xneutral])).name));
    makeneutral = Screen('MakeTexture',w,NEUTRAL);
    Screen('DrawTexture', w, makeneutral);
    Screen('Flip',w);
    WaitSecs(.5);
    
    Screen('FillRect',w,red);
    Screen('Flip',w);
    sf = 22050; nf = sf / 2; dur = 1.0;
    nsample = sf * dur;
    noise = randn(1, nsample);
    noise = noise / max(abs(noise));
    sound(noise, sf); pause(dur + 0.5);
    
    HAPPY = imread(fullfile('NIMSTIM',HappyImages(randi([1,xhappy])).name));
    makehappy = Screen('MakeTexture',w,HAPPY);
    Screen('DrawTexture', w, makehappy);
    Screen('Flip',w);
    WaitSecs(1);
    Screen('Flip',w);
    WaitSecs(3);
    
    Screen('FillRect', w, black);
    DrawFormattedText(w, 'Great Job! Do you understand the game?',...
        'center', screenYpixels*0.3, white);
    Screen('Flip',w);
    KbWait(-1);
    WaitSecs(0.5);
 
    Screen('TextSize',w,35);
    Screen('TextFont',w,'Comic Sans MS');
    %INSTRUCTIONS
    DrawFormattedText(w, ['We are now going to play that game that for real!\n'...
        '\nRemember: the screen will tell you\n which type of face to press for -- \nfearful, happy, or neutral.\n'...
        '\nThen, your job is to go AS FAST AS YOU CAN!\n\n'...
        '\n\nAnd don''t forget! When the background is GREEN, \nyou could win money!\n'...
        '\nWhen the background is RED,\n you could hear a loud noise!\n'...
        '\nAnd when the background is PURPLE,\n no event will happen.'], 'center', 'center', textcolor);
    Screen(w, 'Flip');
    KbWait(-1)
   
    
    DrawFormattedText(w, 'Get Ready!', 'center', 'center', textcolor);
    Screen(w, 'Flip');
    KbWait(-1);
    
    for i = 1:2
        
        
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
        
         
                
                %orderstart = GetSecs-timeStart;
        %PAIR-SPECIFIC INSTRUCTIONAL TEXT
        
        Screen('FillRect', w, black);
        DrawFormattedText(w, ['PRESS for:' go1 ' and ' go2 ...
            ' faces.'...
            '\n\n DO NOT PRESS for a ' nogo ' face.'...
            '\n\n Answer as quickly and accurately as possible.'],...
            'center', screenYpixels*0.3, white);
        Screen('Flip', w);
        WaitSecs(7);
        
        %Loop the colors within the pairs
        for a = 1:2
            if ColorOrder(a) == 1
                block_color = [100 0 150]; block_color_name = 'purple';
               
            elseif ColorOrder(a) == 2
                block_color = [0 170 0]; block_color_name = 'green';
              
            else
                block_color = [170 0 0]; block_color_name = 'red';
               
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

            Screen('FillRect', w, block_color);
            Screen('DrawTexture', w, inimage);
            Screen('Flip', w);
            WaitSecs(7);
           
            %Loop the trials within colors within pairs
            for j = 1:5
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
                
                
            
                imgo1 = imread(fullfile('NIMSTIM',go1Random));
                imgo2 = imread(fullfile('NIMSTIM',go2Random));
                imnogo = imread(fullfile('NIMSTIM',nogoRandom));
         
                go1Face = Screen('MakeTexture',w,imgo1);
                go2Face = Screen('MakeTexture',w,imgo2);
                nogoFace = Screen('MakeTexture',w,imnogo);
                
                
                
                %PRESENT THE IMAGE (12 go, 3 nogo)
                if OrderList((j)) < 3
                    Screen('DrawTexture', w, go1Face);
                    
                elseif (OrderList((j)) == 3) || (OrderList((j)) == 4)
                    Screen('DrawTexture', w, go2Face);
                    
                elseif OrderList((j)) == 5
                    Screen('DrawTexture', w, nogoFace);
                    
                end
            
                
                [vbl, timeStart2] = Screen('Flip',w);
                
               
                keypressed = 0;
                beenhere = 0;
             
                %RESP WINDOW
                %WAIT FOR KEYPRESS OR FOR TIMEOUT
               while 1
                    if ((GetSecs - timeStart2) >= 0.5 && keypressed == 0 && beenhere == 0)
                        Screen('Flip', w);
                        beenhere = 1;
                    end
                    
                    if ((GetSecs-timeStart2) > 1)
                        break;
                    end
               end
               
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
                     
                        fprintf('\n the sound went off!');
                    elseif strcmp(cash_event,'incomplete') && strcmp(block_color_name,'green')
                        Screen('FillRect',w,block_color);
                        DrawFormattedText(w,'Congratulations! You have won $5!','center',...
                            'center',black);
                        Screen('Flip',w);
                        WaitSecs(.5);
                        cash_event = 'complete';
                      
                        fprintf('\n the reward event went off!');
                    end
               end
               Screen('FillRect', w, block_color);
               Screen('Flip', w);
               WaitSecs(0.5);
            end
        end
    end
    Screen('FillRect', w, black);
      DrawFormattedText(w,'Great job!! \nDo you think you can do that while we take a picture of your brain?',...
                            'center', white);
    toc;
    
    Screen('CloseAll');
    sca;
    
end

    


