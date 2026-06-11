// Initialize display setup
InitWindow();

// Initialize settings
if (!variable_global_exists("settings"))
{
    global.settings = new SettingsService();

    global.settings.Load();
    global.settings.ApplyAll();
}

room_goto_next();