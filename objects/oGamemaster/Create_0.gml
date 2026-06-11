enum GAME_STATE
{
    MENU,
    RUNNING,
    PAUSED
}

state = GAME_STATE.MENU;

function ShowMainMenu()
{
    state = GAME_STATE.MENU;
    
    o_ui_manager.OpenRoot(UI_SCREEN.MAIN_MENU);
}

function StartGame()
{
    state = GAME_STATE.RUNNING;
    
    o_ui_manager.CloseAll();
}

function PauseGame()
{
    if(state != GAME_STATE.RUNNING) return;
        
    state = GAME_STATE.PAUSED;
    
    o_ui_manager.OpenRoot(UI_SCREEN.PAUSE, UI_ACTION.RESUME_GAME);
}

function ResumeGame()
{
    if(state != GAME_STATE.PAUSED) return;
        
    state = GAME_STATE.RUNNING;
    
    o_ui_manager.CloseAll();
}