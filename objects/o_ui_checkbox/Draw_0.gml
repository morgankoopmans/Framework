image_alpha = focused ? 0.5 : 1;

draw_self();

if (checked)
{
    draw_sprite(sprCheck, 0, x, y);
}