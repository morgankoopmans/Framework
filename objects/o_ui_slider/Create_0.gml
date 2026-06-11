event_inherited();

dragging = false;

GetValue = function ()
{
    return o_ui_manager.GetSetting(payload);
}

Adjust = function(_direction)
{
    global.audio.PlayUIAdjust();
    
    o_ui_manager.AdjustSetting(payload, _direction * stepSize);
}

function SetFromPointer()
{
    var _mouse_x = InputMouseGuiX();
    
    var _value = (_mouse_x - x) / trackWidth;
    
    o_ui_manager.SetSetting(payload, _value);
}

trackWidth = sprite_width;
trackHeight = sprite_height;