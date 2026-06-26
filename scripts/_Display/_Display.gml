function WindowService(_windowWidth, _windowHeight, _guiWidth, _guiHeight) constructor 
{
    baseWidth = _windowWidth;
    if(baseWidth & 1) baseWidth++;
    
    baseHeight = _windowHeight;
    if(baseHeight & 1) baseHeight++;
    
    guiWidth = _guiWidth;
    guiHeight = _guiHeight;
    
    scale = 1;
    maxScale = 1;
    
    // -----------------------------------------------------
    // Determine the largest integer scale that fits
    // on the current display.
    // -----------------------------------------------------
    
    static RefreshMaxScale = function()
    {
        maxScale = min(floor(DISPLAY_WIDTH/baseWidth),floor(DISPLAY_HEIGHT/baseHeight));
        
        scale = clamp(scale, 1, maxScale);
    } 
    
    // -----------------------------------------------------
    // Fullscreen
    // -----------------------------------------------------
    static SetFullscreen = function(_enabled)
    {
        window_set_fullscreen(_enabled);
        ResizeWindow();
    }
    
    static IsFullscreen = function()
    {
        return window_get_fullscreen();
    }
    
    static ToggleFullscreen = function ()
    {
        SetFullscreen(!IsFullscreen());
    }
    
    // -----------------------------------------------------
    // Window scale
    // -----------------------------------------------------
    
    static SetScale = function(_scale)
    {
        RefreshMaxScale();
        
        scale = clamp(round(_scale), 1, maxScale);
        
        ResizeWindow();
    }
    
    static GetScale = function()
    {
        return scale;
    }
    
    static GetMaxScale = function()
    {
        return maxScale;
    }
    
    static CycleScale = function()
    { 
        var _scale = Wrap(scale + 1, 1, maxScale);	
        SetScale(_scale);
    }
    
    // -----------------------------------------------------
    // Apply window settings
    // -----------------------------------------------------
    
    static ResizeWindow = function()
    {
        if (!window_get_fullscreen())
        {
            window_set_size(
                baseWidth * scale,
                baseHeight * scale
            );
    
            surface_resize(
                application_surface,
                baseWidth * scale,
                baseHeight * scale
            );
    
            call_later(
                1,
                time_source_units_frames,
                function()
                {
                    window_center();
                }
            );
        }
    
        display_set_gui_size(guiWidth, guiHeight);
    }
    
    // -----------------------------------------------------
    // Initial setup
    // -----------------------------------------------------
    
    static Initialize = function()
    {
        RefreshMaxScale();
        SetScale(scale);
    }
}