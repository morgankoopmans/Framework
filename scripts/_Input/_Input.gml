enum INPUT_CONTEXT 
{
    UI,
    GAMEPLAY,
    ALL
}

function InputGate() constructor 
{
    uiLocks = 0;
    gameplayLocks = 0;
    
    static Push = function(_context)
    {
        switch(_context)
        {
            case INPUT_CONTEXT.UI:
                uiLocks++;
                break;
            
            case INPUT_CONTEXT.GAMEPLAY:
                gameplayLocks++;
                break;
            
            case INPUT_CONTEXT.ALL:
                uiLocks++;
                gameplayLocks++;
                break;
        }
    }
    
    static Pop = function(_context)
    {
        switch (_context)
        {
            case INPUT_CONTEXT.UI:
                uiLocks = max(0, uiLocks - 1);
                break;

            case INPUT_CONTEXT.GAMEPLAY:
                gameplayLocks = max(0, gameplayLocks - 1);
                break;

            case INPUT_CONTEXT.ALL:
                uiLocks = max(0, uiLocks - 1);
                gameplayLocks = max(0, gameplayLocks - 1);
                break;
        }
    }
    
    static CanRead = function(_context)
    {
        switch(_context)
        {
            case INPUT_CONTEXT.UI:
                return uiLocks <= 0;
                
            case INPUT_CONTEXT.GAMEPLAY:
                return gameplayLocks <= 0;
                
            case INPUT_CONTEXT.ALL:
                return uiLocks <= 0 and gameplayLocks <= 0;
        }
        
        return true;
    }
}

// Wrapper functions

function UIInputPressed(_verb)
{
    if (!global.inputGate.CanRead(INPUT_CONTEXT.UI))
    {
        return false;
    }

    return InputPressed(_verb);
}


function UIInputOpposingRepeat(_negative, _positive)
{
    if (!global.inputGate.CanRead(INPUT_CONTEXT.UI))
    {
        return 0;
    }

    return InputOpposingRepeat(
        _negative,
        _positive
    );
}


function GameplayInputPressed(_verb)
{
    if (!global.inputGate.CanRead(INPUT_CONTEXT.GAMEPLAY))
    {
        return false;
    }

    return InputPressed(_verb);
}


function GameplayInputDown(_verb)
{
    if (!global.inputGate.CanRead(INPUT_CONTEXT.GAMEPLAY))
    {
        return false;
    }

    return InputDown(_verb);
}


function GameplayInputOpposing(_negative, _positive)
{
    if (!global.inputGate.CanRead(INPUT_CONTEXT.GAMEPLAY))
    {
        return 0;
    }

    return InputOpposing(
        _negative,
        _positive
    );
}


function GameplayInputOpposingRepeat(_negative, _positive)
{
    if (!global.inputGate.CanRead(INPUT_CONTEXT.GAMEPLAY))
    {
        return 0;
    }

    return InputOpposingRepeat(
        _negative,
        _positive
    );
}

