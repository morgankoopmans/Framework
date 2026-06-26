draw_set_font(fnt_ui_text);


scribble("[fa_center]" + text).draw(240, yPosition);


var _icon = InputIconGet(INPUT_VERB.CANCEL);	
var _string = " Skip";
var _w = string_width(_string);
draw_set_halign(fa_right);
if(is_string(_icon)) {
	draw_text(GUI_WIDTH - 16, GUI_HEIGHT - 16, _icon + _string);
} else {
	gpu_set_fog(true, c_white, 0, 0);
	draw_sprite_ext(_icon, 0, GUI_WIDTH - 16 - _w, GUI_HEIGHT - 16, 1.1,1.1, 0,c_white, 1);
	gpu_set_fog(false, c_black, 0, 0);
	draw_sprite(_icon, 0, GUI_WIDTH - 16 - _w, GUI_HEIGHT - 16);
}
draw_set_halign(fa_left);