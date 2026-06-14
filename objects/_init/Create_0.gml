draw_set_font(fntUI_Default);

// Initialize window service
if(!variable_global_exists("window"))
{
    global.window = new WindowService(BASE_WINDOW_WIDTH, BASE_WINDOW_HEIGHT, BASE_GUI_WIDTH, BASE_GUI_HEIGHT);
    global.window.Initialize();
}

// Initialize audio service
if(!variable_global_exists("audio"))
{
    global.audio = new AudioService();
}

// Initialize settings
if (!variable_global_exists("settings"))
{
    global.settings = new SettingsService();

    global.settings.Load();
    global.settings.ApplyAll();
}

// Initialize controls
if(!variable_global_exists("controls"))
{
    global.controls = new ControlsService();
    
    global.controls.Load();
}

room_goto_next();