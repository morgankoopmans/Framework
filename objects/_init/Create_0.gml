if(!variable_global_exists("settings"))
{
    global.settings = new SettingsService();
    
    global.settings.ApplyAll();
}

room_goto_next();