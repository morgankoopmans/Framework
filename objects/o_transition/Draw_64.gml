if(state == TRANSITION_STATE.IDLE and alpha <= 0) exit;
    
draw_set_alpha(alpha);
draw_set_colour(c_black);

draw_rectangle(0, 0, GUI_WIDTH, GUI_HEIGHT, false);

draw_set_alpha(1);
draw_set_colour(c_white);