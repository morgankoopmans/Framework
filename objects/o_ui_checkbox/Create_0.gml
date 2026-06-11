event_inherited();

sprCheck = sUICheck;

checked = false;

Activate = function()
{
    global.audio.PlayUIAccept();
    
    o_ui_manager.Dispatch(actionId, payload);
}
