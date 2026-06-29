// TODO depends on global.gameclock

function animation_controller(_owner) constructor {
	owner = _owner;
	prev_image_index = owner.image_index;
	animation_just_looped = false;
	frame_just_changed = false;	
	spriteUpdateCounter = 0;
	
	function animation_hit_frame_range(_low, _high) {
		return frame_just_changed && owner.image_index >= _low && owner.image_index <= _high;
	}

	function set_state_sprite(_sprite, _speed, _imageIndex) {
		if(owner.sprite_index != _sprite) {
			owner.sprite_index = _sprite;
			owner.image_speed = _speed;
			owner.image_index = _imageIndex;
        }
	}

    function get_anim_frames(_sprite = owner.sprite_index)
    {
        if (_sprite == -1) return 0;
        return sprite_get_number(_sprite);
    }
    
    function get_anim_fps(_sprite = owner.sprite_index)
    {
        if (_sprite == -1) return 0;
        return sprite_get_speed(_sprite);
    }
    
    function get_anim_duration_ticks(_sprite = owner.sprite_index)
    {
        if (_sprite == -1) return 0;
    
        var _fps = sprite_get_speed(_sprite);
        if (_fps <= 0) return 0;
    
        var _frames = sprite_get_number(_sprite);
        var _ticksPerFrame = global.gameclock.GetUpdateFrequency() / _fps;
    
        return ceil(_frames * _ticksPerFrame);
    }
    
	function animation_hit_frame(_frame) {
	    return frame_just_changed && owner.image_index == _frame;
	}

	function animation_end() {
	    return animation_just_looped;
	}

	function UpdateSprite() { Update(); }

	// --- Sprite advance with time_multiplier ---
	function Update(_timeScale) {
		animation_just_looped = false;
		frame_just_changed = false;
		
	    if (owner.sprite_index == -1) return;
	    var _fps = sprite_get_speed(owner.sprite_index);
	    if (_fps <= 0) return;

	    spriteUpdateCounter += _timeScale;
	    var _frames_per_step = (global.gameclock.GetUpdateFrequency() / _fps);

	    var _steps = floor(spriteUpdateCounter / _frames_per_step);
	    if (_steps > 0) {
	        spriteUpdateCounter -= _steps * _frames_per_step;
	        owner.image_index += _steps;

	        if (owner.image_index >= owner.image_number) {
	            owner.image_index -= owner.image_number;
	            animation_just_looped = true;
	        }

	        frame_just_changed = true;
	    } else {
	        animation_just_looped = false;
	        frame_just_changed = false;
	    }
	}
    
    function reset()
    {
        owner.image_index = 0;
        prev_image_index = 0;
        animation_just_looped = false;
        frame_just_changed = false;
        spriteUpdateCounter = 0;
    }
}

