dialogState = DIALOG_STATE.OPEN;

lines = [];
lineIndex = 0;

speaker = "";
text = "";

center = false;

typist = scribble_typist();
typist.in(1, 0);

boxX = 40;
boxY = display_get_gui_height() - 112;
boxW = display_get_gui_width() - 80;
boxH = 88;

pad = 10;

headerX = boxX + 12;
headerY = boxY - 22;
headerW = 120;
headerH = 22;

isOpen = false;

// -----------------------------------------------------
//  Lifecycle
// -----------------------------------------------------

Open = function(_lines)
{
    lines = _lines;
    lineIndex = 0;
    
    isOpen = true;
    
    DialogBlockGameplay();
    
    LoadLine(lineIndex);
}

Close = function()
{
    isOpen = false;
    
    DialogUnblockGameplay();
    
    instance_destroy();
}

LoadLine = function(_index)
{
    if(_index < 0 || _index >= array_length(lines))
    {
        Close();
        return;
    }
    
    var _line = lines[_index];
    
    speaker = _line.speaker;
    text = _line.text;
    center = _line.center;
    
    speakerScribble = DialogMakeScribble(speaker);
    bodyScribble = DialogMakeScribble(text, boxW - pad * 2);
    
    dialogState = DIALOG_STATE.TYPING;
}

Advance = function()
{
    if(dialogState == DIALOG_STATE.TYPING)
    {
        typist.skip();
        return;
    }
    
    if(dialogState == DIALOG_STATE.WAITING)
    {
        lineIndex++;
        
        if(lineIndex >= array_length(lines))
        {
            Close();
        }
        else 
        {
            LoadLine(lineIndex);
        }
    }
}