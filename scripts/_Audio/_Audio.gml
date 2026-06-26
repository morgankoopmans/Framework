
function AudioService() constructor 
{
    // -----------------------------------------------------
    // Currently active music
    // -----------------------------------------------------
    
    musicAsset = -1;
    musicInstance = -1;
    
    // Initalize audio groups
    // TODO maybe audio groups isn't the best way to control volume, as I don't want to load all the music into memory at once
    audio_group_load(audiogroup_sfx);
    audio_group_load(audiogroup_music);
    
    // -----------------------------------------------------
    // Group Volume
    //
    // SettingsService owns the preffered values,
    // AudioService only applies them
    // -----------------------------------------------------
    
    static SetGroupGain = function(_group, _gain, _fadeMs = 0)
    {
        audio_group_set_gain(_group, clamp(_gain, 0, 1), max(0, _fadeMs));    
    }
    
    static ApplyMusicVolume = function(_gain, _fadeMs = 0)
    {
        SetGroupGain(audiogroup_music, _gain, _fadeMs);
    }
    
    static ApplySFXVolume = function(_gain, _fadeMS = 0)
    {
        SetGroupGain(audiogroup_sfx, _gain, _fadeMS);
    }
    
    // -----------------------------------------------------
    // General sound effects
    // -----------------------------------------------------
    
    static PlaySFX = function(_sound, _priority = 0, _gain = 1, _pitch = 1)
    {
        
        return audio_play_sound(_sound, _priority, false, _gain, 0, _pitch);
    }
    
    // -----------------------------------------------------
    // Standard UI feedback
    // -----------------------------------------------------
    
    static PlayUIAccept = function()
    {
        return PlaySFX(sfx_ui_accept, 100);
    }
    
    static PlayUIAdjust = function()
    {
        return PlaySFX(sfx_ui_adjust, 100);
    }
    
    static PlayUIFocus = function()
    {
        return PlaySFX(sfx_ui_focus, 100);
    }
    
    // -----------------------------------------------------
    // Simple music playback
    //
    // No crossfading yet. The service remembers one looping
    // music instance and avoids restarting the same track.
    // -----------------------------------------------------
    
    static PlayMusic = function(_sound, _restart = false)
    {
        if(!_restart and musicAsset == _sound and musicInstance != -1 and audio_is_playing(musicInstance)) return musicInstance;
            
        StopMusic();
        
        musicAsset = _sound;
        
        musicInstance = audio_play_sound(_sound, 0, true);
        
        return musicInstance;
    }
    
    static StopMusic = function()
    {
        if(musicInstance != -1 and audio_is_playing(musicInstance))
        {
            audio_stop_sound(musicInstance);
        }
        
        musicAsset = -1;
        musicInstance = -1;
    }
}