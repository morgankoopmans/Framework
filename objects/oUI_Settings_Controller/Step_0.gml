var _isFullscreen = window_get_fullscreen();

var _fullscreenCheckbox = settings_chk_fullscreen;
_fullscreenCheckbox.enabled = _isFullscreen;


var _zoomNode = flexpanel_node_get_child(settings_menu, "ZoomPanel");
if(_isFullscreen and zoomPanelVisable)
{
   HideFlexpanel(_zoomNode);
    zoomPanelVisable = false; 
} 
else if(!_isFullscreen and !zoomPanelVisable)
{
    ShowFlexpanel(_zoomNode);
    zoomPanelVisable = true;
}
    
var _elm = layer_text_get_id("SettingsMenu", "settings_txt_window_scale");               // Find element in the layer through its name
layer_text_text(_elm, "Scale: " + string(global.window_scale) + "/" + string(global.max_window_scale));