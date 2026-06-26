enum DIALOG_STATE
{
    OPEN,
    TYPING,
    WAITING,
    CLOSE
}

function DialogLine(_speaker, _text, _center = false) constructor 
{
    speaker = _speaker;
    text = _text;
    center = _center;
}

function DialogBlockGameplay()
{
    if(variable_global_exists("inputGate"))
    {
        global.inputGate.Push(INPUT_CONTEXT.GAMEPLAY);
    }
    
    oGamemaster.state = GAME_STATE.DIALOG;
}

function DialogUnblockGameplay()
{
    if(variable_global_exists("inputGate"))
    {
        global.inputGate.Pop(INPUT_CONTEXT.GAMEPLAY);
    }
    
    oGamemaster.state = GAME_STATE.RUNNING;
}

function DialogConfirmPressed()
{
    return InputPressed(INPUT_VERB.ACCEPT);
}

function DialogMakeScribble(_text, _wrapWidth = -1)
{
    var _s = scribble(_text);

    if (_wrapWidth > 0)
    {
        _s.wrap(_wrapWidth);
    }

    return _s;
}

function DialogDrawScribble(_scribble, _x, _y, _typist = noone)
{
    if (is_struct(_scribble))
    {
        if(_typist != noone)
        {
            _scribble.draw(_x, _y, _typist);
        }
        else 
        {
            _scribble.draw(_x, _y);
        }
        
    }
}

function ShowDialog(_lines)
{
    var _dialog = instance_create_layer(0, 0, "Effects", o_ui_dialogbox);
    _dialog.Open(_lines);
    return _dialog;
}