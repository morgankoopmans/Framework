if(!global.inputGate.CanRead(INPUT_CONTEXT.UI))
{
    exit;
}

if(global.controls.IsRebinding())
{
    if(global.controls.Update())
    {
        RefreshControls();
    }
    
    exit;
}

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

var _screen = GetScreen(currentScreen);

if(!is_undefined(_screen))
{
    var _vertical = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN, , 30,120);
    
    var _horizontal = InputOpposingRepeat(INPUT_VERB.LEFT, INPUT_VERB.RIGHT, , 15,120);
    
    switch (_screen.navigationAxis) 
    {
    	case UI_NAV_AXIS.VERTICAL:
            if(_vertical != 0)
            {
                MoveFocus(_vertical);
            }
            
            if(_horizontal != 0 and instance_exists(focusedWidget))
            {
                focusedWidget.Adjust(_horizontal);
            }
            break;
        
        case UI_NAV_AXIS.HORIZONTAL:
            if (_horizontal != 0)
            {
                MoveFocus(_horizontal);
            }
            break;
    }
}
    
if(InputPressed(INPUT_VERB.ACCEPT) and instance_exists(focusedWidget))
{
    focusedWidget.Activate();
}