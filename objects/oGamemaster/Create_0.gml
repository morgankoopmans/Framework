enum GAME_STATE
{
    MENU,
    RUNNING,
    PAUSED
}

state = GAME_STATE.MENU;

// -----------------------------------------------------
// Imediate methods
// There do the actual state changes
// -----------------------------------------------------

function ShowMainMenuImmediate()
{
    state = GAME_STATE.MENU;
    
    o_ui_manager.OpenRoot(UI_SCREEN.MAIN_MENU);
}

function StartGameImmediate()
{
    state = GAME_STATE.RUNNING;
    
    o_ui_manager.CloseAll();
}

function PauseGame()
{
    if(state != GAME_STATE.RUNNING) return;
        
    if(variable_global_exists("transition") and global.transition.BlocksInput()) return;
        
    state = GAME_STATE.PAUSED;
    
    o_ui_manager.OpenRoot(UI_SCREEN.PAUSE, UI_ACTION.RESUME_GAME);
}

function ResumeGame()
{
    if(state != GAME_STATE.PAUSED) return;
        
    state = GAME_STATE.RUNNING;
    
    o_ui_manager.CloseAll();
}


// -----------------------------------------------------
// Transitioned requests
// These are called by UI actions
// -----------------------------------------------------

function RequestStartGame()
{
    if(state != GAME_STATE.MENU) return;
        
    global.transition.FadeCallback(
        function()
        {
            oGamemaster.StartGameImmediate();
        }
    )
}

function RequestMainMenu()
{
    if(state == GAME_STATE.MENU) return;
        
    global.transition.FadeCallback(
        function()
        {
            oGamemaster.ShowMainMenuImmediate();
        }
    )
}