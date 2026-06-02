function Vector2(_x = 0, _y = 0) constructor {
    x = _x;
    y = _y;

	// -------------------------
    // Mutators (chainable)
    // -------------------------
	
	/// Sets Vector2 to (_x, _y)
    Set = function(_x, _y) {
        x = _x;
        y = _y;
		return self;
    }

	/// Adds (_x, _y) to Vector2
    Add = function(_x, _y) {
        x += _x;
        y += _y;
		return self;
    }
	
	/// Adds another Vector2
	AddV = function(_v) {
		x += _v.x;
		y += _v.y;
		return self;
	}

	/// Scales Vector2 by scalar
    Scale = function(_scalar) {
        x *= _scalar;
        y *= _scalar;
		return self;
    }
	
	/// Sets Vector2 to (0, 0)
	Zero = function() {
		x = 0;
		y = 0;
		return self;
	}
	
	/// Normalizes this vector in-place
	Normalize = function(_eps = 0.0001) {
	    var _len_sq = x * x + y * y;
	    if (_len_sq <= (_eps * _eps)) {
	        x = 0; 
			y = 0;
	        return self;
	    }
		
	    var _inv_len  = 1 / sqrt(_len_sq);
	    x *= _inv_len ;
	    y *= _inv_len ;
	    return self;
	}
	
	/// Approaches target Vector2
	Approach = function(_target, _rate) {
		if(is_instanceof(_rate, Vector2)) {
			x = approach(x, _target.x, _rate.x);
			y = approach(y, _target.y, _rate.y);
		} else {
			x = approach(x, _target.x, _rate);
			y = approach(y, _target.y, _rate);
		}
    }
	
	/// Clamps vector length between min and max (in-place)
	ClampLength = function(_min, _max)
	{
	    var len_sq = x * x + y * y;

	    if (len_sq <= 0.0000001) {
	        x = 0;
	        y = 0;
	        return self;
	    }

	    var len = sqrt(len_sq);

	    if (len < _min) {
	        var s = _min / len;
	        x *= s;
	        y *= s;
	    }
	    else if (len > _max) {
	        var s = _max / len;
	        x *= s;
	        y *= s;
	    }

	    return self;
	}
	
	// -------------------------
    // Queries / Math
    // -------------------------
	
	LengthSq = function() {
		return x * x + y * y;	
	}
	
	Length = function()
	{
		return sqrt(x * x + y * y);
	}
	
	/// Returns normalized copy (safe)
	Normal = function(_eps = 0.0001) {
        var _len_sq = x * x + y * y;
        if (_len_sq <= (_eps * _eps)) {
            return new Vector2(0, 0);
        }

        var _inv_len = 1 / sqrt(_len_sq);
        return new Vector2(x * _inv_len, y * _inv_len);
    }
	
	/// Dot product
	Dot = function(_v) {
		return x * _v.x + y * _v.y;
	}
	
	/// Distance squared to another Vector2
	DistanceSq = function(_v) {
		var _dx = _v.x - x;	
		var _dy = _v.y - y;
		return _dx * _dx + _dy * _dy;
	}
	
	/// Distance to another Vector2
	Distance = function(_v) {
		return sqrt(DistanceSq(_v));	
	}
	
	/// Returns true if vector is approximately zero
	IsZero = function(_eps = 0.0001) {
	    return (x * x + y * y) <= (_eps * _eps);
	}
	
	/// Returns a new Vector2 with same values
    Clone = function() {
        return new Vector2(x, y);
    }
}

// ------------------------------------
// Static helper
// ------------------------------------


Vector2_DirSpeed = function(_angle, _speed) {
	return new Vector2(lengthdir_x(_speed, _angle), lengthdir_y(_speed, _angle));
}