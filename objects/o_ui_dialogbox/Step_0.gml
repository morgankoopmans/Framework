if(!isOpen) exit;
    
if(dialogState == DIALOG_STATE.TYPING)
{
    if(typist.get_state() == 1)
    {
        dialogState = DIALOG_STATE.WAITING;
    }
}

if(DialogConfirmPressed())
{
    Advance();
}