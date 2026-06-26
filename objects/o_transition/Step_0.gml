switch(state)
{
    case TRANSITION_STATE.IDLE:
        alpha = 0;
        break;
    
    case TRANSITION_STATE.FADING_OUT:
        timer++;
        
        alpha = clamp(timer / durationOut, 0, 1);
        
        if(timer >= durationOut)
        {
            alpha = 1;
            
            if(!is_undefined(onCovered))
            {
                onCovered();
                onCovered = undefined;
            }
            
            timer = 0;
            state = TRANSITION_STATE.HOLD;
        }
        break;
    
    case TRANSITION_STATE.HOLD:
        timer++;
        
        if(timer >= holdFrames)
        {
            timer = 0;
            state = TRANSITION_STATE.FADING_IN;
        }
        break;
    
    case TRANSITION_STATE.FADING_IN:
        timer++;
        
        alpha = 1 - clamp(timer / durationIn, 0, 1);
        
        if(timer >= durationIn)
        {
            alpha = 0;
            timer = 0;
            
            state = TRANSITION_STATE.IDLE;
            
            if(inputLocked)
            {
                global.inputGate.Pop(INPUT_CONTEXT.ALL);
                inputLocked = false;
            }
        }
        
        break;
}