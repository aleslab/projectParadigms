function [conditionInfo,expInfo] = pdgm_melody(expInfo) 

%Paradigm Name is a short name that identifies this paradigm
expInfo.paradigmName = 'Melody';

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
expInfo.instructions = ['Two sequences note sequences will be presented' ...
    'Which sequence ...'...
    'Press ''f'' if the first sequence, ''j'' if the 2nd' ...
];

expInfo.enableAudio = true;

% The chords are as they would be on a circle of fifths - in 'song' at the
% bottom becuase it begins on 0, 2 and 4 are the third and fifth
% respectively

%conditionInfo(1).notesequence = [1 3 5 3 5 1' 5 3 1];

conditionInfo(1).label            = 'Correct';
conditionInfo(1).type             = '2afc';
conditionInfo(1).iti              = 1;
conditionInfo(1).trialFun=@trial_melody;
conditionInfo(1).noteSequence = [1 5 8 5 8 13 8 5 1]+12;
conditionInfo(1).noteDuration = [2 2 2 2 2  2 2 2 2]/4;
conditionInfo(1).nReps = 2;
conditionInfo(1).responseDuration = 2;
conditionInfo(1).collectResponse = false
nullCondition = conditionInfo(1);
conditionInfo(1).nullCondition = nullCondition;


conditionInfo(2) = conditionInfo(1);
conditionInfo(2).label            = 'OctaveViolationLow';
conditionInfo(2).noteSequence = [1 5 8 5 8 13 8 5 -11]+12;
conditionInfo(2).nullCondition = nullCondition;

conditionInfo(3) = conditionInfo(1);
conditionInfo(3).label            = 'OctaveViolationHigh';
conditionInfo(3).noteSequence = [1 5 8 5 8 13 8 5 13]+12;
conditionInfo(3).nullCondition = nullCondition;

conditionInfo(4) = conditionInfo(1);
conditionInfo(4).label            = '2ndViolation';
conditionInfo(4).noteSequence = [1 5 8 5 8 13 8 5 3]+12;
conditionInfo(4).nullCondition = nullCondition;




%Finally, in order for ptbCorgi to know how to group conditions we need to
%define the grouping field.  In this case we are going to group conditions
%by contrast. 



%conditionInfo(1).key = randomize

%conditionInfo(1).largeViolation = [1 3 5 3 5 1' 5 3 x], where x =
%random number between 1 and 6

%For the manipulation check, it would be playing two subsequent melodies,
%where the second is a random selection of small and large violations (I
%did not modify this file to write that in)
