gml_pragma("global", "_Macros()");

#macro GAME_NAME "Frameworks"

// #macro config:NAME value	

// Delta 
//#macro TARGET_DELTA 1/TARGET_FPS
//#macro TARGET_DELTA 1
//#macro TARGET_FPS 60

#macro TARGET_GAME_HEIGHT 540 //#macro GAME_WIDTH 480

// DEBUG
#macro NO_SPLASHSCREEN 0
#macro Test:NO_SPLASHSCREEN 1
#macro NO_MENU 0
#macro Test:NO_MENU 1
#macro UNLIMITED_MONEY 0
#macro Test:UNLIMITED_MONEY 1
#macro DEBUG_MODE 0
#macro Test:DEBUG_MODE 1
#macro SHOW_HITBOXES 1

#macro GAME_FREQ 60

// Display Manager
#macro CAM view_camera[0]
#macro CAM_X camera_get_view_x(CAM)
#macro CAM_Y camera_get_view_y(CAM)
#macro VIEW_WIDTH camera_get_view_width(CAM)
#macro VIEW_HEIGHT camera_get_view_height(CAM)
// Display
#macro DISPLAY_WIDTH display_get_width()
#macro DISPLAY_HEIGHT display_get_height()
#macro DISPLAY_CENTER_X DISPLAY_WIDTH / 2
#macro DISPLAY_CENTER_Y DISPLAY_HEIGHT / 2
// Aspect Ratio
#macro ASPECT_RATIO 16/9//DISPLAY_WIDTH/DISPLAY_HEIGHT
// GUI
#macro GUI_WIDTH display_get_gui_width()
#macro GUI_HEIGHT display_get_gui_height()
#macro GUI_CENTER_X GUI_WIDTH / 2
#macro GUI_CENTER_Y GUI_HEIGHT / 2
