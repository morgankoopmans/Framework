/// Approach(a, b, amount)
// Moves "a" towards "b" by "amount" and returns the result
// Nice bcause it will not overshoot "b", and works in both directions
// Examples:
//      speed = Approach(speed, max_speed, acceleration);
//      hp = Approach(hp, 0, damage_amount);
//      hp = Approach(hp, max_hp, heal_amount);
//      x = Approach(x, target_x, move_speed);
//      y = Approach(y, target_y, move_speed);
function approach(_v, _target, _delta) {
    if (_v < _target) { _v = min(_v + _delta, _target); }
    else if (_v > _target) { _v = max(_v - _delta, _target); }
    return _v;
}

//Wave(from, to, duration, offset)

// Returns a value that will wave back and forth between [from-to] over [duration] seconds
// Examples
//      image_angle = Wave(-45,45,1,0)  -> rock back and forth 90 degrees in a second
//      x = Wave(-10,10,0.25,0)         -> move left and right quickly

// Or here is a fun one! Make an object be all squishy!! ^u^
//      image_xscale = Wave(0.5, 2.0, 1.0, 0.0)
//      image_yscale = Wave(2.0, 0.5, 1.0, 0.0)
function Wave(_from, _to, _dur, _off) {
	a4 = (_to - _from) * 0.5;
	return _from + a4 + sin((((current_time * 0.001) + _dur * _off) / _dur) * (pi*2)) * a4;
}

// Returns the value wrapped, values over or under will be wrapped around
function Wrap(_value, _min, _max) {
	if (_value mod 1 == 0) {
		while (_value > _max || _value < _min) {
			if (_value > _max)
				_value += _min - _max - 1;
			else if (_value < _min)
				_value += _max - _min + 1;
		}
		return(_value);
	} else {
		var vOld = _value + 1;
		while (_value != vOld) {
			vOld = _value;
			if (_value < _min)
				_value = _max - (_min - _value);
			else if (_value > _max)
				_value = _min + (_value - _max);
		}
		return(_value);
	}
}

// Teleports parent object to a spot based on given direction and distance
function JumpInDirection(_distance, _direction) {
	x += lengthdir_x(_distance,_direction);
	y += lengthdir_y(_distance,_direction);
}

// Returns true or false depending on RNG
// ex: 
//		Chance(0.7);	-> Returns true 70% of the time
function Chance(_percent) {
	return _percent > random(1);	
}

function ResetDrawGui() {
	draw_set_font(fntDefault);	// Co-Dependant
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_alpha(1);
	draw_set_color(c_white);
}

function valueInRange(_value, _min, _max) {
	if(_value > _min and _value < _max) {
		return true;
	} else {
		return false;	
	}
}

/// Ease from a -> b with t in [0,1]
function easeOutCubic(t, a, b) {
    var u = 1 - power(1 - t, 3);     // fast start, gentle settle
    return a + (b - a) * u;
}

function easeOutExpo(t, a, b) {
    var u = (t >= 1) ? 1 : (1 - power(2, -10 * t)); // snappier start, smooth tail
    return a + (b - a) * u;
}

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