function SpriteFlash(_color = c_white, _duration = 8, _scaleBoost = 0.2) constructor
{
    color = _color;

    duration = max(1, _duration);
    timer = 0;

    alpha = 0;

    scaleBoostAmount = _scaleBoost;
    scaleBoost = 0;

    static Start = function()
    {
        timer = duration;
        alpha = 1;
        scaleBoost = scaleBoostAmount;
    }

    static Step = function(_timeScale = 1)
    {
        if (timer <= 0)
        {
            alpha = 0;
            scaleBoost = 0;
            return;
        }

        timer -= _timeScale;

        var _t =
            clamp(
                timer / duration,
                0,
                1
            );

        alpha = _t;
        scaleBoost = scaleBoostAmount * _t;
    }

    static DrawSprite = function(_sprite,_image, _x, _y, _xscale, _yscale, _angle)
    {
        if (alpha <= 0)
        {
            return;
        }

        shader_set(shFlash);

        draw_sprite_ext(
            _sprite,
            _image,
            _x,
            _y,
            _xscale + scaleBoost,
            _yscale + scaleBoost,
            _angle,
            color,
            alpha
        );

        shader_reset();
    }
}