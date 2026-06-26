enum TRANSITION_STATE
{
    IDLE,
    FADING_OUT,
    HOLD,
    FADING_IN
}

global.transition = id;

state = TRANSITION_STATE.IDLE;

alpha = 0;

timer = 0;

durationOut = 12;
durationIn = 12;
holdFrames = 1;

onCovered = undefined;

inputLocked = false;

// -----------------------------------------------------
// Query
// -----------------------------------------------------

IsBusy = function()
{
    return state != TRANSITION_STATE.IDLE;
}

// -----------------------------------------------------
// Start a generic fade:
// fade to black -> run callback -> fade back in
// -----------------------------------------------------

FadeCallback = function(_callback, _durationOut = 12, _durationIn = 12, _holdFrames = 1)
{
    if(IsBusy()) return false;
        
    onCovered = _callback;
    
    durationOut = max(1, _durationOut);
    durationIn = max(1, _durationIn);
    holdFrames = max(1, _holdFrames);
    
    timer = 0;
    alpha = 0;
    
    if(!inputLocked)
    {
        global.inputGate.Push(INPUT_CONTEXT.ALL);
        inputLocked = true;
    }
    
    state = TRANSITION_STATE.FADING_OUT;
    
    return true;
}

// -----------------------------------------------------
// Common room helpers
// -----------------------------------------------------

FadeToRoom = function(_room, _durationOut = 12, _durationIn = 12)
{
    var _func = function(_rm) { room_goto(_rm); }  
    
    return FadeCallback(
        _func(_room),
        _durationOut,
        _durationIn
    )
}

FadeRestartRoom = function(_durationOut = 12, _durationIn = 12)
{
    return FadeCallback(
        function()
        {
            room_restart();
        },
        _durationOut,
        _durationIn
    )
}

// -----------------------------------------------------
// Useful for entering a room already covered
// Example: start a scene black, then fade in
// -----------------------------------------------------

FadeInFromBlack = function(_durationIn = 12)
{
    if(IsBusy()) return false;
        
    alpha = 1;
    timer = 0;
    
    durationIn = max(1, _durationIn);
    
    state = TRANSITION_STATE.FADING_IN;
    
    return true;
}