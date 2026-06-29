if (flashAlpha <= 0)
{
    exit;
}

draw_set_colour(flashColor);
draw_set_alpha(flashAlpha);

draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

draw_set_alpha(1);
draw_set_colour(c_white);