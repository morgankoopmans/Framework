// Credits File
var credits_list_file = file_text_open_read("credits.txt");
text = "";

// Read the file and store content in the "text" variable
while(!file_text_eof(credits_list_file)) {
	text += file_text_readln(credits_list_file) + "\n";
}
file_text_close(credits_list_file);


// Scrolling variables
scrollSpeed = 0.2;
yPosition = GUI_HEIGHT;

scribble_anim_wave(4,50,.05);