if(dragging)
{
    SetFromPointer();
}

if(mouse_check_button_released(mb_left))
{
    dragging = false;
}