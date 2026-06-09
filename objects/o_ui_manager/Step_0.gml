if(InputPressed(INPUT_VERB.PAUSE))
{
    if(currentScreen == UI_SCREEN.NONE)
    {
        oGamemaster.PauseGame();
    }
    else
    { 
        Back();
    }
    exit;
}

if(currentScreen == UI_SCREEN.NONE) exit;

if(InputPressed(INPUT_VERB.CANCEL))
{
    Back();
    exit;
}

var _vertical = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN, , 30,120); //InputPressed(INPUT_VERB.DOWN) - InputPressed(INPUT_VERB.UP);// InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);

if(_vertical != 0)
{
    MoveFocus(_vertical);
}

var _horizontal = InputOpposingRepeat(INPUT_VERB.LEFT, INPUT_VERB.RIGHT, , 15,120)

if(_horizontal != 0 and instance_exists(focusedWidget))
{
    focusedWidget.Adjust(_horizontal);
}
    
if(InputPressed(INPUT_VERB.ACCEPT) and instance_exists(focusedWidget))
{
    focusedWidget.Activate();
}
