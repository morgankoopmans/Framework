// Move the text up 
yPosition -= scrollSpeed;

// End credits when text is off-screen
var text_height = string_height_ext(text, -1, 480) + 275;
if(yPosition < -text_height or InputCheck(INPUT_VERB.CANCEL)) 
{
	oGamemaster.RequestMainMenu();
}