enum GAME_STATE
{
    MENU,
    RUNNING,
    GAME_OVER,
    PAUSED
}

state = GAME_STATE.MENU;

// -----------------------------------------------------
// Imediate methods
// There do the actual state changes
// -----------------------------------------------------

function ShowMainMenuImmediate()
{
    room_goto(_rm_mainmenu);
    
    global.audio.StopMusic();
    
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
        
    if(!global.inputGate.CanRead(INPUT_CONTEXT.UI)) return;
        
    state = GAME_STATE.PAUSED;
    
    o_ui_manager.OpenRoot(UI_SCREEN.PAUSE, UI_ACTION.RESUME_GAME);
}

function ResumeGame()
{
    if(state != GAME_STATE.PAUSED) return;
        
    state = GAME_STATE.RUNNING;
    
    o_ui_manager.CloseAll();
}

function ShowCredits()
{
    state = GAME_STATE.MENU;
    o_ui_manager.CloseAll();
    room_goto(_rm_credits);
}

function GameOver()
{
    if(state != GAME_STATE.RUNNING) return;
        
    if(!global.inputGate.CanRead(INPUT_CONTEXT.UI)) return;
        
    state = GAME_STATE.GAME_OVER;
    
    o_ui_manager.OpenRoot(UI_SCREEN.GAMEOVER);
}

// -----------------------------------------------------
// Transitioned requests
// These are called by UI actions
// -----------------------------------------------------

function RequestStartGame()
{
    if(state != GAME_STATE.MENU and state != GAME_STATE.GAME_OVER) return;
        
    global.transition.FadeCallback(
        function()
        {
            oGamemaster.StartGameImmediate();
        }
    )
}

function RequestMainMenu()
{
    //if(state == GAME_STATE.MENU) return;
        
    global.transition.FadeCallback(
        function()
        {
            oGamemaster.ShowMainMenuImmediate();
        }
    )
}

function RequestCredits()
{
    //if(state == GAME_STATE.MENU) return;
        
    global.transition.FadeCallback(
        function()
        {
            oGamemaster.ShowCredits();
        },
        300,
        120,
        0
    )
}