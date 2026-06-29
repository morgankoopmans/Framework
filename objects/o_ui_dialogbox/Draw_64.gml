if (!isOpen) exit;

draw_sprite_stretched(sUIPanel, 0, boxX, boxY, boxW, boxH);

// Speaker header
if (speaker != "")
{
    draw_sprite_stretched(sUIBack, 0, headerX, headerY, headerW, headerH);

    speakerScribble.starting_format("fnt_ui_default", c_white).align(fa_left, fa_middle).draw(headerX + 8, headerY + (headerH * 0.5));
}

// Body text
//bodyScribble.
if(center)
{
    bodyScribble.align(fa_center, fa_middle).draw(boxX + (boxW * 0.5), boxY + (boxH * 0.5) , typist);
}
else 
{
	bodyScribble.draw(boxX + pad, boxY + pad, typist);
}

// Continue indicator
if (dialogState == DIALOG_STATE.WAITING)
{
    var _icon = InputIconGet(INPUT_VERB.ACCEPT);
    //draw_text(boxX + boxW - 24, boxY + boxH - 22, ">");
    scribble(_icon).align(fa_right, fa_bottom).draw(boxX + boxW - pad, boxY + boxH - pad);
}

draw_set_alpha(1);