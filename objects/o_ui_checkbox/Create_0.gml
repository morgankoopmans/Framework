event_inherited();

sprCheck = sUICheck;

checked = false;

Activate = function()
{
    audio_play_sound(sfx_ui_blip, 100, false);
    o_ui_manager.Dispatch(actionId, payload);
}
