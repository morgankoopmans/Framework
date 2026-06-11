mainMenuLayer = "MainMenu";
pauseLayer = "PauseMenu";
settingsLayer = "SettingsMenu";

screens = [];
screensBuilt = false;

screenStack = [];
rootBackAction = UI_ACTION.NONE;
rootBackPayload = 0;

currentScreen = UI_SCREEN.NONE;

settingsUICached = false;
settingsZoomNode = undefined;
settingsTxtWindowScale = -1;

zoomPanelVisible = true;

focusWidgets = [];
focusIndex = -1;
focusedWidget = noone;

// Helper
function SetGroupEnabled(_widgets, _interactable)
{
    for (var _i = 0; _i < array_length(_widgets); _i++)
    {
        _widgets[_i].SetEnabled(_interactable);
    }

    EnsureValidFocus();
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

function ToggleSetting(_settingId)
{
    global.settings.Toggle(_settingId);
    RefreshSettings();
}

GetSetting = function(_settingId)
{
    return global.settings.Get(_settingId);
}

SetSetting = function(_settingId, _value)
{ 
    global.settings.Set(_settingId, _value);
    RefreshSettings();
}

AdjustSetting = function(_settingId, _amount)
{
    SetSetting(_settingId, GetSetting(_settingId) + _amount);
}

function SetZoomPanelVisible(_visible)
{
    if(zoomPanelVisible == _visible) return;
    
    CacheSettingsUI();
    
    if(_visible)
    {
        ShowFlexpanel(settingsZoomNode);
    }
    else 
    {
        HideFlexpanel(settingsZoomNode);    
    }
    
    zoomPanelVisible = _visible;
    
    SetGroupEnabled(
        [
            settings_btn_zoom
        ],
        _visible
    );
    
    EnsureValidFocus();
}

function RefreshSettings()
{
    CacheSettingsUI();
    
    var _fullscreen = global.settings.Get(SETTING_ID.FULLSCREEN);
    
    settings_chk_fullscreen.checked = _fullscreen;
    
    SetZoomPanelVisible(!_fullscreen);
    
    layer_text_text(settingsTxtWindowScale, "Scale: " + string(global.settings.Get(SETTING_ID.WINDOW_SCALE)) + "/" + string(global.max_window_scale));
}

#endregion

#region Focus

IsFocusable = function(_widget)
{
    return instance_exists(_widget) and _widget.CanFocus();
}

FocusWidget = function(_widget)
{
    if(!IsFocusable(_widget)) return false;
    
    var _index = array_get_index(focusWidgets, _widget);
    
    if(_index == -1) return false;
        
    if(instance_exists(focusedWidget)) focusedWidget.SetFocused(false);
   
    focusIndex = _index;
    focusedWidget = _widget;
    
    focusedWidget.SetFocused(true);
    
    return true;
}

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

SetFocusList = function(_widgets)
{
    ClearFocus();
    
    focusWidgets = _widgets;
    focusIndex = -1;
    
    MoveFocus(1);
}

function MoveFocus(_direction)
{
    var _count = array_length(focusWidgets);

    if (_count == 0) return;

    for (var _i = 1; _i <= _count; _i++)
    {
        var _index = (focusIndex + (_direction * _i) + _count) mod _count;

        var _widget = focusWidgets[_index];

        if (IsFocusable(_widget))
        {
            FocusWidget(_widget);
            return;
        }
    }
    
    ClearFocus();
}

function EnsureValidFocus()
{
    if (IsFocusable(focusedWidget))return;
    
    MoveFocus(1);
}

#endregion

function BuildScreenRegistry()
{
    screens = array_create(UI_SCREEN.COUNT);
    
    screens[UI_SCREEN.PAUSE] = 
        new UIScreen(
            pauseLayer, 
            [
                pause_btn_resume, 
                pause_btn_settings, 
                pause_btn_exit
            ]
        );
    
    screens[UI_SCREEN.SETTINGS] = 
        new UIScreen(
            settingsLayer, 
            [
                settings_chk_fullscreen,
                settings_btn_zoom,
                settings_sld_music,
                settings_sld_sfx,
                settings_btn_back
            ],
            function() {RefreshSettings()},
            function() {global.settings.SaveIfDirty()}
        );
    
    screens[UI_SCREEN.MAIN_MENU] =
        new UIScreen(
            mainMenuLayer,
            [
                main_btn_start,
                main_btn_settings,
                main_btn_quit
            ]
        );  
    
    screensBuilt = true;
}

function GetScreen(_screen)
{
    if(_screen <= UI_SCREEN.NONE or _screen >= UI_SCREEN.COUNT)
    {
        return undefined;
    }
    
    return screens[_screen];
}

function HideAllScreens()
{
    for(var _screen = UI_SCREEN.NONE + 1; _screen < UI_SCREEN.COUNT; _screen++)
    {
        var _entry = screens[_screen];
        
        if(!is_struct(_entry))
        {
            continue;
        }
        
        layer_set_visible(_entry.layerId, false);
    }
}

#region Screen nav

function CloseAll()
{
    var _current = GetScreen(currentScreen);
    
    if(!is_undefined(_current) and !is_undefined(_current.onClose))
    {
        _current.onClose();
    }
    
    ClearFocus();
    HideAllScreens();
    
    currentScreen = UI_SCREEN.NONE;
    
    screenStack = [];
    
    rootBackAction = UI_ACTION.NONE;
    rootBackPayload = 0;
}

function OpenRoot(_screen, _backAction = UI_ACTION.NONE, _backPayload = 0)
{
    screenStack = [];
    
    rootBackAction = _backAction;
    rootBackPayload = _backPayload;
    
    ShowScreen(_screen);
}

function PushScreen(_screen)
{
    if(currentScreen != UI_SCREEN.NONE)
    {
        array_push(screenStack, currentScreen);
    }
    
    ShowScreen(_screen);
}

function ShowScreen(_screen)
{
    if(currentScreen == _screen) return;
        
    var _previous = GetScreen(currentScreen);
    var _next = GetScreen(_screen);
    
    if(!is_undefined(_previous) and !is_undefined(_previous.onClose))
    {
        _previous.onClose();
    }
    
    ClearFocus();
    HideAllScreens();
    
    currentScreen = _screen;
    
    if(is_undefined(_next)) return;
        
    layer_set_visible(_next.layerId, true);
    
    if(!is_undefined(_next.onOpen))
    {
        _next.onOpen();
    }
    
    SetFocusList(_next.widgets);
}

function Back()
{
    if (array_length(screenStack) > 0)
    {
        ShowScreen(array_pop(screenStack));

        return;
    }

    if (rootBackAction != UI_ACTION.NONE)
    {
        Dispatch(rootBackAction, rootBackPayload);
    }
}

#endregion

#region Action routing

function Dispatch(_actionId, _payload = 0)
{
    switch (_actionId)
    {
        case UI_ACTION.START_GAME:
        {
            oGamemaster.StartGame();
        }
        break;
        
        case UI_ACTION.RESUME_GAME:
        {
            oGamemaster.ResumeGame();
        }
        break;

        case UI_ACTION.PUSH_SCREEN:
        {
            PushScreen(_payload);
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

        case UI_ACTION.CYCLE_WINDOW_SCALE:
        {
            global.settings.CycleWindowScale();

            RefreshSettings();
        }
        break;
    }
}

#endregion