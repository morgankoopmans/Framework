global.feedback = id;

// -----------------------------------------------------
// Time
// -----------------------------------------------------

timeScale = 1;

hitstopFrames = 0;

slowmoTimer = 0;
slowmoDuration = 0;
slowmoScale = 1;

// -----------------------------------------------------
// Shake
// -----------------------------------------------------

shakeTimer = 0;
shakeDuration = 0;
shakeStrength = 0;
shakeX = 0;
shakeY = 0;

// -----------------------------------------------------
// Screen Flash
// -----------------------------------------------------

flashColor = c_white;
flashAlpha = 0;
flashStartAlpha = 0;
flashTimer = 0;
flashDuration = 0;

// -----------------------------------------------------
// API
// -----------------------------------------------------

Hitstop = function(_frames)
{
    hitstopFrames = max(hitstopFrames, max(0, _frames));
}

Slowmo = function(_scale, _frames)
{
    slowmoScale = clamp(_scale, 0, 1);
    slowmoDuration = max(1, _frames);
    slowmoTimer = slowmoDuration;   
}

Shake = function(_strength, _frames)
{
    shakeStrength = max(shakeStrength, _strength);
    shakeDuration = max(1, _frames);
    shakeTimer = max(shakeTimer, shakeDuration);
}

Flash = function(_color = c_white, _alpha = 0.35, _frames = 0)
{
    flashColor = _color;
    flashStartAlpha = max(flashStartAlpha, _alpha);
    flashAlpha = flashStartAlpha;
    flashDuration = max(1, _frames);
    flashTimer = flashDuration;
}

GetTimeScale = function()
{
    return timeScale;
}

GetShakeX = function()
{
    return shakeX;
}

GetShakeY = function()
{
    return shakeY;
}

IsFrozen = function()
{
    return hitstopFrames > 0;
}