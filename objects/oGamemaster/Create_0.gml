enum GAME_STATE
{
    RUNNING,
    PAUSED
}

state = GAME_STATE.RUNNING;

function PauseGame()
{
    // Return if already paused
    if(state == GAME_STATE.PAUSED) return;
    state = GAME_STATE.PAUSED;
    o_ui_manager.Open(UI_SCREEN.PAUSE);
}

function ResumeGame()
{
    // Return if already paused
    if(state == GAME_STATE.RUNNING) return;
    state = GAME_STATE.RUNNING;
    o_ui_manager.CloseAll();
}