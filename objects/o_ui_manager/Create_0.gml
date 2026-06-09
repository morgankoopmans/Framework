// Button zoom gets focus even while not visible

pauseLayer = "PauseMenu";
settingsLayer = "SettingsMenu";

currentScreen = UI_SCREEN.NONE;

settingsUICached = false;
settingsZoomNode = undefined;
settingsTxtWindowScale = -1;

zoomPanelVisible = true;

focusWidgets = [];
focusIndex = -1;
focusedWidget = noone;

if(!variable_global_exists("settings"))
{
    global.settings = new _GameSettings();    
}

#region cache references to UI elements once

function CacheSettingsUI()
{
    if(settingsUICached) return;
        
    var _settingsRoot = layer_get_flexpanel_node(settingsLayer);
    
    settingsZoomNode = flexpanel_node_get_child(_settingsRoot, "ZoomPanel");
    
    settingsTxtWindowScale = layer_text_get_id(settingsLayer, "settings_text_window_scale");
    
    settingsUICached = true;
}

#endregion

#region settings UI

GetSetting = function(_settingId)
{
    switch(_settingId)
    {
        case SETTING_ID.MUSIC_VOLUME:
            return global.settings.music_volume; 
            
        case SETTING_ID.SFX_VOLUME:
            return global.settings.sfx_volume;
    }
    
    return 0;
}

// TODO this adjusts audio group directly, should probably go through a controller and properly initilized and saved(pref)
SetSetting = function(_settingId, _value)
{
    _value = clamp(_value, 0, 1);
    
    switch (_settingId) 
    {
    	case SETTING_ID.MUSIC_VOLUME:
            global.settings.music_volume = _value;
            
            audio_group_set_gain(audiogroup_music, _value, 0);
            break;
        
        case SETTING_ID.SFX_VOLUME:
            global.settings.sfx_volume = _value;
            
            audio_group_set_gain(audiogroup_sfx, _value, 0);
            break;
    }
}

AdjustSetting = function(_setting_id, _amount)
{
    SetSetting(
        _setting_id,
        GetSetting(_setting_id) + _amount
    );
}

ApplyAudioSettings = function()
{
    audio_group_set_gain(
        audiogroup_music,
        global.settings.music_volume,
        0
    );

    audio_group_set_gain(
        audiogroup_sfx,
        global.settings.sfx_volume,
        0
    );
}

function SetZoomPanelVisible(_visible)
{
    CacheSettingsUI();
    
    if(zoomPanelVisible == _visible) return;
        
    if(_visible)
    {
        ShowFlexpanel(settingsZoomNode);
    }
    else 
    {
        HideFlexpanel(settingsZoomNode);    
    }
    
    zoomPanelVisible = _visible;
}

function RefreshSettings()
{
    CacheSettingsUI();
    
    var _fullscreen = window_get_fullscreen();
    
    global.settings.fullscreen = _fullscreen;
    
    settings_chk_fullscreen.checked = _fullscreen;
    
    SetZoomPanelVisible(!_fullscreen);
    
    layer_text_text(settingsTxtWindowScale, "Scale: " + string(global.window_scale) + "/" + string(global.max_window_scale));
}

#endregion

#region Focus

ClearFocus = function()
{
    if(instance_exists(focusedWidget))
    {
        focusedWidget.SetFocused(false);
    }
    
    focusWidgets = [];
    focusIndex = -1;
    focusedWidget = noone;
}

SetFocusIndex = function(_index)
{
    var _length = array_length(focusWidgets)
    
    if(_length == 0) return;
        
    if(instance_exists(focusedWidget))
    {
        focusedWidget.SetFocused(false);
    }
    
    _index = Wrap(_index, 0, _length - 1);
    
    focusIndex = _index;
    focusedWidget = focusWidgets[focusIndex];
    
    focusedWidget.SetFocused(true);
}

SetFocusList = function(_widgets)
{
    ClearFocus();
    
    focusWidgets = _widgets;
    
    if(array_length(focusWidgets) > 0)
    {
        SetFocusIndex(0);
    }
}

MoveFocus = function(_amount)
{
    SetFocusIndex(focusIndex + _amount);
}

#endregion

#region Screen nav

function CloseAll()
{
    ClearFocus();
    
    layer_set_visible(pauseLayer, false);
    layer_set_visible(settingsLayer, false);
    
    currentScreen = UI_SCREEN.NONE;
}

function Open(_screen)
{
    ClearFocus();   // We need to do this before setting visable, as the layers are also deactivated so widgets hold focused state
    
    layer_set_visible(pauseLayer, _screen == UI_SCREEN.PAUSE);
    
    layer_set_visible(settingsLayer, _screen == UI_SCREEN.SETTINGS);
    
    currentScreen = _screen;
    
    switch (_screen)
    {
        case UI_SCREEN.PAUSE:
        {
            SetFocusList(
            [
                pause_btn_resume,
                pause_btn_settings,
                pause_btn_exit
            ]);
        }
        break;

        case UI_SCREEN.SETTINGS:
        {
            RefreshSettings();

            SetFocusList(
            [
                settings_chk_fullscreen,
                settings_btn_zoom,
                settings_sld_music,
                settings_sld_sfx,
                settings_btn_back
            ]);
        }
        break;

        default:
        {
            ClearFocus();
        }
        break;
    }
}

// TODO should probably store a referene to what opened the current screen
// Example the settings menu is opened by the main menu instead of the pause menu
function Back()
{
    switch(currentScreen)
    {
        case UI_SCREEN.SETTINGS:
            Open(UI_SCREEN.PAUSE);
            break;
        
        case UI_SCREEN.PAUSE:
            oGamemaster.ResumeGame();
            break;
    }
}

#endregion

#region Action routing

function ToggleSetting(_settingId)
{
    switch(_settingId)
    {
        case SETTING_ID.FULLSCREEN:
            ToggleFullscreen();
            RefreshSettings();
            break;
    }
}

function Dispatch(_actionId, _payload = 0)
{
    switch (_actionId)
    {
        case UI_ACTION.RESUME_GAME:
        {
            oGamemaster.ResumeGame();
        }
        break;

        case UI_ACTION.OPEN_SCREEN:
        {
            Open(_payload);
        }
        break;

        case UI_ACTION.BACK:
        {
            Back();
        }
        break;

        case UI_ACTION.QUIT_GAME:
        {
            game_end();
        }
        break;

        case UI_ACTION.TOGGLE_SETTING:
        {
            ToggleSetting(_payload);
        }
        break;

        case UI_ACTION.ZOOM_WINDOW:
        {
            ZoomWindow();

            RefreshSettings();
        }
        break;
    }
}

#endregion