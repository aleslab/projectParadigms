function [trialData] = trial_melody(expInfo, conditionInfo)
    
 
  
  %For the manipulation check, it would be playing two subsequent melodies,
  %where the second is a random selection of small and large violations (I
  %did not modify this file to write that in)
  
    rectSize = [0 0 100 100; ...
        150 150 175 175; ...
        200 200 700 700]';
    
    rectColor = [ 1 0 0;...
        0 1 1;...
        1 0 1;]';
    
    Screen('FrameRect',expInfo.curWindow,rectColor,rectSize)
    flipTimes=Screen('flip',expInfo.curWindow);
    
    key = 220+660*rand();
    semiToneRatio = 2.^((0:12)/12);
    semiToneRatio = [semiToneRatio 2*semiToneRatio(2:end) 4*semiToneRatio(2:end) 8*semiToneRatio(2:end) ];
    
    song = conditionInfo.noteSequence;
    song2 = conditionInfo.noteSequence+5;
    songDur = conditionInfo.noteDuration;
    noteStartTimes = zeros(size(songDur));
    for iSong = 1:length(song),
        PsychPortAudio('Volume', expInfo.audioInfo.pahandle, 0.7); %the volume of the beep 
        intervalBeep = MakeBeep(key*semiToneRatio(song(iSong)), expInfo.audioInfo.beepLength, expInfo.audioInfo.samplingFreq);
        intervalBeep2 = MakeBeep(key*semiToneRatio(song2(iSong)), expInfo.audioInfo.beepLength, expInfo.audioInfo.samplingFreq);
        intervalBeep = intervalBeep + intervalBeep2;
        PsychPortAudio('FillBuffer', expInfo.audioInfo.pahandle, [intervalBeep; intervalBeep]);
        noteStartTimes(iSong) = PsychPortAudio('Start', expInfo.audioInfo.pahandle,1,0,1);
        %WaitSecs(songDur(iSong));
        PsychPortAudio('Stop', expInfo.audioInfo.pahandle,3);
        noteStopTimes(iSong) = GetSecs;
    end
    
    trialData.noteStartTimes = noteStartTimes; 
    trialData.noteStopTimes = noteStopTimes; 
%%% Begin response collection 
    
    %Flush any events that happend before the end of the trial

if expInfo.useKbQueue
    KbQueueFlush();
end

curTime = GetSecs;
feedbackMsg='';
%Now fire a busy loop to process any keypress during the response window.
% if conditionInfo.collectResponse
%     while curTime<noteStopTimes(end)+conditionInfo.responseDuration
%         
%         
%         if expInfo.useKbQueue
%             [ trialData.pressed, trialData.firstPress]=KbQueueCheck(expInfo.deviceIndex);
%         else
%             [ trialData.pressed, secs, keyCode]=KbCheck(expInfo.deviceIndex);
%             trialData.firstPress = secs*keyCode;
%         end
%         
%         
%         if trialData.pressed
%             break;
%         end
%         curTime = GetSecs;
%     end
%     
%     
%     
%     if trialData.firstPress(KbName('ESCAPE'))
%         %pressed escape lets abort experiment;
%         trialData.validTrial = false;
%         trialData.abortNow = true;
%         
%     elseif trialData.firstPress(KbName('1!'))
%         trialData.response = '1';
%         trialData.responseTime = ...
%             trialData.firstPress(KbName('1!'))-trialData.noteStopTimes(end);
%         trialData.validTrial = true;
%         
%         
%     elseif trialData.firstPress(KbName('2@'))
%         trialData.response = '2';
%         trialData.responseTime = ...
%             trialData.firstPress(KbName('2@'))-trialData.noteStopTimes(end);
%         trialData.validTrial = true;
%         
%         
%         
%     else %Wait a minute this isn't a valid response
%         
%         feedbackMsg  = ['Invalid Response'];
%         trialData.validTrial = false;
%         
%     end
% end
% trialData.feedbackMsg = feedbackMsg;

%Reset times to be with respect to trial end.
%trialData.firstPress = trialData.firstPress-trialData.flipTimes(end);



end
    
    
    
