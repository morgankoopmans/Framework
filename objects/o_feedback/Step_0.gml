// -----------------------------------------------------
// Hitstop / Slowmo time scale
// -----------------------------------------------------

if(hitstopFrames > 0)
{
    hitstopFrames--;
    
    timeScale = 0;
}
else if (slowmoTimer > 0)
{
    slowmoTimer--;
    
    var _t = 1 - (slowmoTimer / slowmoDuration);
    
    // Ease back toward normal speed
    timeScale = lerp(slowmoScale, 1, _t);
}
else 
{
    timeScale = 0;   
}

// -----------------------------------------------------
// Shake
// -----------------------------------------------------

if (shakeTimer > 0)
{
    shakeTimer--;
    
    var _t = shakeTimer / shakeDuration;
    
    var _currentStrength = shakeStrength * _t;
    
    shakeX = random_range(-_currentStrength, _currentStrength);
    
    shakeY = random_range(-_currentStrength, _currentStrength);
    
    if(shakeTimer <= 0)
    {
        shakeX = 0;
        shakeY = 0;
        shakeStrength = 0;
    }
}
else 
{
    shakeX = 0; 
    shakeY = 0; 
    shakeStrength = 0;
}

// -----------------------------------------------------
// Screen flash
// -----------------------------------------------------

if (flashTimer > 0)
{
    flashTimer--;

    var _t =
        flashTimer / flashDuration;

    flashAlpha =
        flashStartAlpha * _t;

    if (flashTimer <= 0)
    {
        flashAlpha = 0;
        flashStartAlpha = 0;
    }
}
else
{
    flashAlpha = 0;
    flashStartAlpha = 0;
}