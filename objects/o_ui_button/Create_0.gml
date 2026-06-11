event_inherited();
Activate = function()
{
    global.audio.PlayUIAccept();
    
    o_ui_manager.Dispatch(actionId, payload);
}