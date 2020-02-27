
function [trialData] = trial_melody(expInfo, conditionInfo)

%Set random seed if frozen noise:
if isfield(conditionInfo,'noiseSeed') && ~isempty(conditionInfo.noiseSeed)
    rng(conditionInfo.noiseSeed);
end

% Build a procedural gabor texture for a gabor with a support of tw x th
% pixels, and a RGB color offset of 0.5 -- a 50% gray.
% Initial stimulus params for the gabor patch:
res = 1*[128 128];
phase = 90;
sc = 5.0;
freq = .1;
tilt = 0;
contrast = 2;
aspectratio = .5;
tw = res(1);
th = res(2);
halfX=8*tw/1;
halfY=8*th/2;

%tricky way to build the destination rect vector:
textureCenter = [ expInfo.center] ;

destRec = [textureCenter textureCenter ] +[-halfX -halfY halfX halfY];

nonsymmetric = 0;
%gabortex = CreateProceduralGabor(expInfo.curWindow, tw, th, nonsymmetric, [0.5 0.5 0.5 0.0]);
gabortex = CreateProceduralGabor(expInfo.curWindow, tw, th, nonsymmetric, [[0.5 0.5 0.5 1]]);

%Setup the movement/location parameters. 

if ~isfield(conditionInfo,'bounceOffEdges') || isempty(conditionInfo.bounceOffEdges)
    conditionInfo.bounceOffEdges = false;
end


if isfield(conditionInfo,'startingVelocity')...
        && ~isempty(conditionInfo.startingVelocity)
    textureVelocity = conditionInfo.startingVelocity;
else
    textureVelocity = [0 0];
end

textureAcceleration = [0 0];

stepSigma = conditionInfo.stepSigma;
positionSigma = conditionInfo.positionSigma;
accelerationSigma = conditionInfo.accelSigma;

trialDuration = conditionInfo.trialDuration*1000;

nFrames = round(trialDuration/expInfo.frameDur);

keepShowing= true;
condInfo = [];
position = nan(nFrames,2);
velocity = nan(nFrames,2);
mousePos = nan(nFrames,2);

readyRect=[textureCenter textureCenter ] +[-10 -10 10 10]
Screen('DrawTexture', expInfo.curWindow, gabortex, [], destRec, 90+tilt, [], [], [], [], kPsychDontDoRotation, [180-phase, freq, sc, contrast, aspectratio, 0, 0, 0]);
Screen('FillRect',expInfo.curWindow,[1 1 1],readyRect)
Screen('flip',expInfo.curWindow);

readyRect=[textureCenter textureCenter ] +[-10 -10 10 10]
Screen('DrawTexture', expInfo.curWindow, gabortex, [], destRec, 90+tilt, [], [], [], [], kPsychDontDoRotation, [180-phase, freq, sc, contrast, aspectratio, 0, 0, 0]);
Screen('FillRect',expInfo.curWindow,[1 0 0],readyRect)
Screen('flip',expInfo.curWindow,GetSecs+2);

Screen('DrawTexture', expInfo.curWindow, gabortex, [], destRec, 90+tilt, [], [], [], [], kPsychDontDoRotation, [180-phase, freq, sc, contrast, aspectratio, 0, 0, 0]);
Screen('FillRect',expInfo.curWindow,[1 1 0],readyRect)
Screen('flip',expInfo.curWindow,GetSecs+.5);

Screen('DrawTexture', expInfo.curWindow, gabortex, [], destRec, 90+tilt, [], [], [], [], kPsychDontDoRotation, [180-phase, freq, sc, contrast, aspectratio, 0, 0, 0]);
Screen('FillRect',expInfo.curWindow,[0 1 0],readyRect)
Screen('flip',expInfo.curWindow,GetSecs+.5);

Screen('DrawTexture', expInfo.curWindow, gabortex, [], destRec, 90+tilt, [], [], [], [], kPsychDontDoRotation, [180-phase, freq, sc, contrast, aspectratio, 0, 0, 0]);
Screen('flip',expInfo.curWindow,GetSecs+.5);

for iFrame=1:nFrames,
    
    %showTargets(screenInfo, targets, [1 2 3])
    
    velocity(iFrame,:) = textureVelocity;
    position(iFrame,:) = textureCenter;
    
    % Draw the Gabor patch: We simply draw the procedural texture as any other
    % texture via 'DrawTexture', but provide the parameters for the gabor as
    % optional 'auxParameters'.
    Screen('DrawTexture', expInfo.curWindow, gabortex, [], destRec, 90+tilt, [], [], [], [], kPsychDontDoRotation, [180-phase, freq, sc, contrast, aspectratio, 0, 0, 0]);
    flipT(iFrame) = Screen('flip',expInfo.curWindow);
    [x,y] = GetMouse(expInfo.curWindow);
    mousePos(iFrame,1) = x;
    mousePos(iFrame,2) = y;
    
    
    switch lower(conditionInfo.motionType)
        case {'brownian'}
            % [keyIsDown,secs, keyCode, deltaSecs] = KbCheck([]);
            textureVelocity =stepSigma*randn(size(textureVelocity));
            %     textureAcceleration =  accelerationSigma*randn(size(textureVelocity));
            %     textureVelocity = textureVelocity + accelerationSigma*randn(size(textureVelocity));
            %
            
            textureCenter = textureCenter+textureVelocity;
        case {'random'}
            textureCenter = expInfo.center+positionSigma*randn(size(textureCenter));
            textureVelocity = zeros(size(textureCenter));
            
        case {'smooth'}
            %first draw a random number for a "force"/"acceleration to
            %apply to the object
            textureAcceleration =  accelerationSigma*randn(size(textureVelocity));
            %Update the current movement by this force change
            textureVelocity = textureVelocity + textureAcceleration;
            %Finally move the texture
            textureCenter = textureCenter+textureVelocity;
    
    end
   
   
    if conditionInfo.bounceOffEdges
        if textureCenter(1)<0 || textureCenter(1)>expInfo.windowSizePixels(1)
            
            textureVelocity(1) = -textureVelocity(1);
             %After resettring the velocity, bring  the texture back. 
            textureCenter = textureCenter+2*textureVelocity;
        end
        
        
        if textureCenter(2)<0 || textureCenter(2)>expInfo.windowSizePixels(2)
            textureVelocity(2) = -textureVelocity(2);
             %After resettring the velocity, bring  the texture back. 
            textureCenter = textureCenter+2*textureVelocity;
        end
        
       
       
    end

    destRec = [textureCenter textureCenter] +[-halfX -halfY halfX halfY];
    
    isCorrect = NaN;
    isDown = KbCheck();
    if any(isDown)
        break;
    end;
end


trialData.mousePos = mousePos;
trialData.position = position;




