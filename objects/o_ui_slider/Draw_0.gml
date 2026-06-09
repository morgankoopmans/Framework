var _value = GetValue();

var _handle_x = x + (_value * trackWidth);


// Track
draw_rectangle(x, y, x + trackWidth, y + trackHeight, false);


// Handle
draw_rectangle(_handle_x - 2, y - 2, _handle_x + 2, y + trackHeight + 2, false);


// Focus outline
if (focused)
{
    draw_rectangle(x - 3, y - 5, x + trackWidth + 3, y + trackHeight + 5, true);
}


// Percentage text
draw_text(x + trackWidth + 10, y - 4, string(round(_value * 100)) + "%");