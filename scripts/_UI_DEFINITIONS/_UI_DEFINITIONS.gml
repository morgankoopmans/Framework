enum UI_ACTION
{
    NONE,
    
    OPEN_SCREEN,
    BACK,
    
    RESUME_GAME,
    QUIT_GAME,
    
    TOGGLE_SETTING,
    ADJUST_SETTING,
    
    ZOOM_WINDOW
}

enum UI_SCREEN
{
    NONE,
    PAUSE,
    SETTINGS
}

enum SETTING_ID
{
    NONE,
    
    FULLSCREEN,
    MUSIC_VOLUME,
    SFX_VOLUME
}

function _GameSettings() constructor 
{
    fullscreen = window_get_fullscreen();
    
    music_volume = 1.0;
    sfx_volume = 1.0;
}