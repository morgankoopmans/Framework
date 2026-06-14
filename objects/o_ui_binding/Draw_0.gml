var _bindingLabel;

if(global.controls.IsRebindingVerb(verbId, alternate))
{
    _bindingLabel = "Press input...";
}
else 
{
    _bindingLabel = global.controls.GetBindingSummary(verbId);
}

image_alpha = focused?1.0:0.75;

draw_self();

draw_set_halign(fa_left);

draw_text(x + 8, y + 4, label);

draw_set_halign(fa_right);

draw_text(x + sprite_width - 8, y + 4, _bindingLabel);

draw_set_halign(fa_left);

draw_set_alpha(1);