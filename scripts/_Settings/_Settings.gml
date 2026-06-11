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
    fullscreen = global.window.IsFullscreen();
    windowScale = global.window.GetScale();
    
    musicVolume = 1.0;
    sfxVolume = 1.0;
    
    dirty = false;
    
    // Load
    static Load = function()
    {
        ini_open(fileName);
        
        fullscreen = ini_read_real("video", "fullscreen", fullscreen ? 1: 0) > 0.5;
        
        windowScale = clamp(round(ini_read_real("video", "window_scale", windowScale)), 1, global.window.GetMaxScale());
        
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
        global.window.SetScale(windowScale);
        global.window.SetFullscreen(fullscreen);
        
        global.audio.ApplyMusicVolume(musicVolume);
        global.audio.ApplySFXVolume(sfxVolume);
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
                global.window.SetFullscreen(_value);
                break;
            
            case SETTING_ID.WINDOW_SCALE:
                windowScale = clamp(round(_value), 1, global.window.GetMaxScale());
                global.window.SetScale(windowScale);
                break;
            
            case SETTING_ID.MUSIC_VOLUME:
                musicVolume = clamp(_value, 0, 1);
                global.audio.ApplyMusicVolume(musicVolume);
                break;
            
            case SETTING_ID.SFX_VOLUME:
                sfxVolume = clamp(_value, 0, 1);
                global.audio.ApplySFXVolume(sfxVolume);
                break;
            
            default:
                return;
        }
        
        dirty = true;
    }
    
    // TODO Could probably remove both of these, now that I updated affected systems to recieve a _value
    // Convenience methods used by UI
    
    // Toggle a boolean setting
    static Toggle = function(_settingId)
    {
        switch(_settingId)
        {
            case SETTING_ID.FULLSCREEN:
            {
                Set(SETTING_ID.FULLSCREEN,!fullscreen);
                
                break;
            }
        }
    }
    
    // Window-specific setting action
    static CycleWindowScale = function()
    {
        var _next_scale = Wrap(windowScale + 1, 1, global.window.GetMaxScale());

        Set(SETTING_ID.WINDOW_SCALE, _next_scale);
    }

   
}