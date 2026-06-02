function HideFlexpanel(node_id) 
{
    // hide the flexpanel
    flexpanel_node_style_set_display(node_id, flexpanel_display.none);
    // hide all layerElements within that flexpanel
    var _fpStruct = flexpanel_node_get_struct(node_id);
    for (var i = 0; i < array_length(_fpStruct.layerElements); i++) {
        var _fpStructElem = _fpStruct.layerElements[i]
        layer_text_alpha(_fpStructElem.elementId, 0); // or 1
        // only layer_text_alpha made text elements invisible, not working:
        // fpStructElem.flexVisible = false
        // layer_text_xscale(fpStructElem.elementId, 0); // or 1
        // if you have other elements besides text, you may need additional code to hide them, I just tested with text
    }
}

function ShowFlexpanel(node_id) 
{
    // hide the flexpanel
    flexpanel_node_style_set_display(node_id, flexpanel_display.flex);
    // hide all layerElements within that flexpanel
    var _fpStruct = flexpanel_node_get_struct(node_id);
    for (var i = 0; i < array_length(_fpStruct.layerElements); i++) {
        var _fpStructElem = _fpStruct.layerElements[i]
        layer_text_alpha(_fpStructElem.elementId, 1); // or 1
        // only layer_text_alpha made text elements invisible, not working:
        // fpStructElem.flexVisible = false
        // layer_text_xscale(fpStructElem.elementId, 0); // or 1
        // if you have other elements besides text, you may need additional code to hide them, I just tested with text
    }
}