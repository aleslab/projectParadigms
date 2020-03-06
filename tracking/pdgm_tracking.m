function [conditionInfo,expInfo] = pdgm_tracking(expInfo) 

%Paradigm Name is a short name that identifies this paradigm
expInfo.paradigmName = 'Gabor Tracking';

%Randomly present each condition.
expInfo.randomizationType = 'random';

%Define the viewing distance.
expInfo.viewingDistance = 57;

%Setup a simple fixation cross. See help drawFixation for more info on how
%to setup this field.
% expInfo.fixationInfo(1).type  = 'cross';
% expInfo.fixationInfo(1).size  = .5;
% expInfo.fixationInfo(1).lineWidthPix = 2;
% expInfo.fixationInfo(1).color = 0;

%Instructions are displayed once at the begining of an experiment
expInfo.instructions = ['Insert insructions\n' ...
    'Here\n'...
    'Press space to start\n' ...
];

%This is just a label for bookkeeping/organization
conditionInfo(1).label            = 'Brownian'; 

%What file/function to run for the trial.
conditionInfo(1).trialFun=@trial_tracking;

%How long to pause between trials
conditionInfo(1).iti              = 1;
%How many repititions to run for this condition.
conditionInfo(1).nReps = 2;
conditionInfo(1).trialDuration = 15; %trial duration in seconds. 

conditionInfo(1).motionType       = 'Brownian'; 
%This is the amount of noise to add to the movement sequence
conditionInfo(1).stepSigma    = 10;
conditionInfo(1).bounceOffEdges = true;
conditionInfo(1).frameDuration = .10;
%Initialize the 2nd condition to be the same as 1 and just change what we
%want
conditionInfo(2) = conditionInfo(1);
conditionInfo(2).label            = 'Random'; 
conditionInfo(2).motionType       = 'random'; 
conditionInfo(2).positionSigma    = conditionInfo(1).stepSigma;


conditionInfo(3) = conditionInfo(1);
conditionInfo(3).label            = 'Smooth'; 
conditionInfo(3).motionType       = 'smooth'; 
conditionInfo(3).accelSigma       = 6;

