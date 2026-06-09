focused = false;
enabled = true;


CanFocus = function()
{
    return enabled;
}

SetFocused = function(_focused)
{
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
   
}

Adjust = function(_amount)
{
    
}