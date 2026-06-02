InitWindow();

function InitWindow() {
	//global.window_height = TARGET_GAME_HEIGHT;
	//global.window_width = round(global.window_height*ASPECT_RATIO);
	global.window_width = 960;
	global.window_height = 540;

	global.gui_width = 480;
	global.gui_height = 270;

	if(global.window_width & 1) global.window_width++;
	if(global.window_height & 1) global.window_height++;

	global.max_window_scale = min(floor(DISPLAY_WIDTH/global.window_width),floor(DISPLAY_HEIGHT/global.window_height));
	/*
	if(global.window_height * global.max_window_scale == DISPLAY_HEIGHT) {
	    global.max_window_scale--;
	}
	*/
	global.window_scale = global.max_window_scale;
	
	ResizeWindow();
}

function ResizeWindow() {
	if(window_get_fullscreen()) {
		global.window_scale = global.max_window_scale;	
	}
	
	window_set_size(global.window_width * global.window_scale, global.window_height * global.window_scale);
	surface_resize(application_surface, global.window_width * global.window_scale, global.window_height * global.window_scale);
	display_set_gui_size(global.gui_width,global.gui_height);
	//instance_create_depth(0,0,0,oBroadcastWindowChanged);	

	call_later(1, time_source_units_frames, function() {
		window_center();
		displayReady = true;	
	});
}

function ToggleFullscreen()
{
    window_set_fullscreen(!window_get_fullscreen());
    ResizeWindow();
}

function ZoomWindow() {
	global.window_scale = Wrap(global.window_scale+1, 1, global.max_window_scale);	
	ResizeWindow();
}