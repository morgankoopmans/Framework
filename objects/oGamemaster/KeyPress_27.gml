if(state == GAME_STATE.RUNNING)
{
    PauseGame();
    return;
}

if(state == GAME_STATE.PAUSED)
{
    ResumeGame();
    return;
}
