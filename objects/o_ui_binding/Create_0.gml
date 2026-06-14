// Inherit the parent event
event_inherited();

Activate = function()
{
    global.audio.PlayUIAccept();
    
    o_ui_manager.BeginControlRebind(verbId, alternate);
}
