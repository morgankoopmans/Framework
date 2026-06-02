enum GAME_STATE
{
    RUNNING,
    PAUSED
}

ui_pauseLayer = "PauseMenu";

state = GAME_STATE.RUNNING;

function PauseGame()
{
    // Return if already paused
    if(state == GAME_STATE.PAUSED) return;
    state = GAME_STATE.PAUSED;
    layer_set_visible(ui_pauseLayer, true);
}

function ResumeGame()
{
    // Return if already paused
    if(state == GAME_STATE.RUNNING) return;
    state = GAME_STATE.RUNNING;
    layer_set_visible(ui_pauseLayer, false);
    layer_set_visible("SettingsMenu", false);
}