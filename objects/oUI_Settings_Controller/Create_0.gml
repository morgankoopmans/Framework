settings_menu = layer_get_flexpanel_node("SettingsMenu");

//uiFullscreen.enabled = true;


// TODO FUCK THIS> IT WORKS BUT THIS OBJECT NEEDS TO BE CREATED FIRST IN CREATION ORDER OTHERWISE YOUR GOING TO HAVE A BAD TIME

var _isFullscreen = window_get_fullscreen();

var _fullscreenCheckbox = settings_chk_fullscreen;
_fullscreenCheckbox.enabled = _isFullscreen;
_fullscreenCheckbox.action = function(){ ToggleFullscreen();};


zoomPanelVisable = !_isFullscreen;

// Zoom window button
inst_67F59F90.action = function ()
{
    ZoomWindow();
}
