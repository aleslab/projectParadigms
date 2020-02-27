function [conditionInfo,expInfo] = pdgm_manipulation(expInfo) 

%Paradigm Name is a short name that identifies this paradigm
expInfo.paradigmName = 'ManipulationCheck';

%Randomly present each condition.
expInfo.randomizationType = 'random';

%Define the viewing distance.
expInfo.viewingDistance = 57;

%Setup a simple fixation cross. See help drawFixation for more info on how
%to setup this field.
expInfo.fixationInfo(1).type  = 'cross';
expInfo.fixationInfo(1).size  = .5;
expInfo.fixationInfo(1).lineWidthPix = 2;
expInfo.fixationInfo(1).color = 0;

%Instructions are displayed once at the begining of an experiment
expInfo.instructions = ['A melody will be played.'...
    'Press 1 if you think the first melody is correct.'...
    'Press 2 if you think the second melody is correct.'];

expInfo.enableAudio = true;


%conditionInfo(1).notesequence = [1 3 5 3 5 1' 5 3 1];

conditionInfo(1).label            = 'Correct';
conditionInfo(1).trialFun=@manipulation_melody;
conditionInfo(1).noteSequence = [1 5 8 5 8 13 8 5 1]+12;
conditionInfo(1).noteDuration = [2 2 2 2 2  2 2 2 2]/4;
conditionInfo(1).nTrials = 1;
conditionInfo(1).responseDuration = 5;
conditionInfo(1).ViolationType = 0;

%--------------------------------------------------------------------------

conditionInfo(2) = conditionInfo(1);
conditionInfo(2).label            = 'OctaveViolationLow';
conditionInfo(2).noteSequence = [1 5 8 5 8 13 8 5 -11]+12;
conditionInfo(2).nTrials = 2;
conditionInfo(2).responseDuration = 5;
conditionInfo(2).ViolationType = 1; 

conditionInfo(3) = conditionInfo(1);
conditionInfo(3).label            = 'OctaveViolationMiddle';
conditionInfo(3).noteSequence = [1 5 8 5 8 13 8 5 13]+12;
conditionInfo(3).nTrials = 2;
conditionInfo(3).responseDuration = 5;
conditionInfo(3).ViolationType = 1;

conditionInfo(4) = conditionInfo(1);
conditionInfo(4).label            = 'OctaveViolationHigh';
conditionInfo(4).noteSequence = [1 5 8 5 8 13 8 5 25]+12;
conditionInfo(4).nTrials = 2;
conditionInfo(4).responseDuration = 5;
conditionInfo(4).ViolationType = 1;

conditionInfo(5) = conditionInfo(1);
conditionInfo(5).label            = '2ndViolationLow';
conditionInfo(5).noteSequence = [1 5 8 5 8 13 8 5 -9]+12;
conditionInfo(5).nTrials = 3;
conditionInfo(5).responseDuration = 5;
conditionInfo(5).ViolationType = 1;

conditionInfo(6) = conditionInfo(1);
conditionInfo(6).label            = '2ndViolationMiddle';
conditionInfo(6).noteSequence = [1 5 8 5 8 13 8 5 3]+12;
conditionInfo(6).nTrials = 3;
conditionInfo(6).responseDuration = 5;
conditionInfo(6).ViolationType = 1;

conditionInfo(7) = conditionInfo(1);
conditionInfo(7).label            = '2ndViolationHigh';
conditionInfo(7).noteSequence = [1 5 8 5 8 13 8 5 15]+12;
conditionInfo(7).nTrials = 3;
conditionInfo(7).responseDuration = 5;
conditionInfo(7).ViolationType = 1;

conditionInfo(8) = conditionInfo(1);
conditionInfo(8).label            = '7thViolationLow';
conditionInfo(8).noteSequence = [1 5 8 5 8 13 8 5 -5]+12;
conditionInfo(8).nTrials = 3;
conditionInfo(8).responseDuration = 5;
conditionInfo(8).ViolationType = 1;

conditionInfo(9) = conditionInfo(1);
conditionInfo(9).label            = '7thViolationMiddle';
conditionInfo(9).noteSequence = [1 5 8 5 8 13 8 5 12]+12;
conditionInfo(9).nTrials = 3;
conditionInfo(9).responseDuration = 5;
conditionInfo(9).ViolationType = 1;


expInfo.conditionGroupingField = 'ViolationType';



%For the manipulation check, it would be playing two subsequent melodies,
%where the second is a random selection of small and large violations (I
%did not modify this file to write that in)
