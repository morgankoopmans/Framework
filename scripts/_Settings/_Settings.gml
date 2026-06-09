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

function SettingsService() constructor 
{
    fullscreen = window_get_fullscreen();
    
    music_volume = 1.0;
    sfx_volume = 1.0;
    
    // Read a setting
    
    static Get = function(_settingId)
    {
        switch (_settingId) 
        {
        	case SETTING_ID.FULLSCREEN:
                return fullscreen;
                
            case SETTING_ID.MUSIC_VOLUME:
                return music_volume;
                
            case SETTING_ID.SFX_VOLUME:
                return sfx_volume;
        }
        
        return undefined;
    }
    
    // Set a value and apply
    static Set = function(_settingId, _value)
    {
        switch (_settingId) 
        {
            case SETTING_ID.MUSIC_VOLUME:
                music_volume = clamp(_value, 0, 1);
                audio_group_set_gain(audiogroup_music, music_volume, 0);
                break;
            
            case SETTING_ID.SFX_VOLUME:
                sfx_volume = clamp(_value, 0, 1);
                audio_group_set_gain(audiogroup_sfx, sfx_volume, 0);
                break;
        }
    }
    
    // Toggle a boolean setting
    static Toggle = function(_settingId)
    {
        switch(_settingId)
        {
            case SETTING_ID.FULLSCREEN:
            {
                ToggleFullscreen();
                
                fullscreen = window_get_fullscreen();
                
                break;
            }
        }
    }
    
    // Window-specific setting action
    static CycleWindowScale = function()
    {
        ZoomWindow();
    }

    // Apply settings after loading a save file
    static ApplyAll = function()
    {
        audio_group_set_gain(audiogroup_music, music_volume, 0);

        audio_group_set_gain(audiogroup_sfx, sfx_volume, 0);
    }
}