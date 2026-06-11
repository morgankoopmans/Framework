enum SETTING_ID
{
    NONE,
    
    FULLSCREEN,
    WINDOW_SCALE,
    
    MUSIC_VOLUME,
    SFX_VOLUME
}

function SettingsService() constructor 
{
    // File
    fileName = "settings.ini";
    
    // Default values
    // Used on first launch, or whenever a key is missing from INI file
    fullscreen = false;
    windowScale = global.window_scale;
    
    musicVolume = 1.0;
    sfxVolume = 1.0;
    
    dirty = false;
    
    // Load
    static Load = function()
    {
        ini_open(fileName);
        
        fullscreen = ini_read_real("video", "fullscreen", fullscreen ? 1: 0) > 0.5;
        
        windowScale = clamp(round(ini_read_real("video", "window_scale", windowScale)), 1, global.max_window_scale);
        
        musicVolume = clamp(ini_read_real("audio", "music_volume", musicVolume), 0, 1);
        
        sfxVolume = clamp(ini_read_real("audio", "sfx_volume", sfxVolume), 0, 1);
        
        ini_close();
        
        dirty = false;
    }
    
    // Save
    static Save = function()
    {
        ini_open(fileName);
        
        ini_write_real("video", "fullscreen", fullscreen?1:0);
        
        ini_write_real("video", "window_scale", windowScale);
        
        ini_write_real("audio", "music_volume", musicVolume);
        
        ini_write_real("audio", "sfx_volume", sfxVolume);
        
        ini_close();
        
        dirty = false;
    }
    
    static SaveIfDirty = function()
    {
        if (dirty)
        {
            Save();
        }
    }

    
    // Apply loaded values
    static ApplyAll = function()
    {
        ApplyWindowScale(windowScale);
        ApplyFullscreen(fullscreen);
        
        audio_group_set_gain(audiogroup_music, musicVolume, 0);

        audio_group_set_gain(audiogroup_sfx, sfxVolume, 0);
    }
    
    // Read a setting
    
    static Get = function(_settingId)
    {
        switch (_settingId) 
        {
        	case SETTING_ID.FULLSCREEN:
                return fullscreen; 
                
            case SETTING_ID.WINDOW_SCALE:
                return windowScale;
                
            case SETTING_ID.MUSIC_VOLUME:
                return musicVolume;
                
            case SETTING_ID.SFX_VOLUME:
                return sfxVolume;
        }
        
        return undefined;
    }
    
    // Set a value and apply
    static Set = function(_settingId, _value)
    {
        switch (_settingId) 
        {
            case SETTING_ID.FULLSCREEN:
                fullscreen = _value;
                ApplyFullscreen(_value);
                break;
            
            case SETTING_ID.WINDOW_SCALE:
                windowScale = clamp(round(_value), 1, global.max_window_scale);
                ApplyWindowScale(windowScale);
                break;
            
            case SETTING_ID.MUSIC_VOLUME:
                musicVolume = clamp(_value, 0, 1);
                audio_group_set_gain(audiogroup_music, musicVolume, 0);
                break;
            
            case SETTING_ID.SFX_VOLUME:
                sfxVolume = clamp(_value, 0, 1);
                audio_group_set_gain(audiogroup_sfx, sfxVolume, 0);
                break;
            
            default:
                return;
        }
        
        dirty = true;
    }
    
    // Convenience methods used by UI
    
    // Toggle a boolean setting
    static Toggle = function(_settingId)
    {
        switch(_settingId)
        {
            case SETTING_ID.FULLSCREEN:
            {
                ToggleFullscreen();
                
                Set(SETTING_ID.FULLSCREEN,!fullscreen);
                
                break;
            }
        }
    }
    
    // Window-specific setting action
    static CycleWindowScale = function()
    {
        var _next_scale = Wrap(global.window_scale + 1, 1, global.max_window_scale);

        Set(SETTING_ID.WINDOW_SCALE, _next_scale);
    }

   
}