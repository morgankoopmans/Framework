focused = false;
enabled = true;


CanFocus = function()
{
    return enabled;
}

SetFocused = function(_focused)
{
    global.audio.PlayUIFocus();
    focused = _focused;
}

SetEnabled = function(_enabled)
{
    enabled = _enabled;
    
    if(!enabled)
    {
        SetFocused(false);
    }
}

RequestFocus = function()
{
    if(CanFocus())
    {
        o_ui_manager.FocusWidget(id);
    }
}

Activate = function()
{
    global.audio.PlayUIAccept(); 
    o_ui_manager.Dispatch(actionId, payload);
}

Adjust = function(_amount)
{
    
}

