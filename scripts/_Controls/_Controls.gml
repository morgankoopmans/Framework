function ControlsService() constructor 
{
    // Increment this whenever the verb/default bindings change substantially
    schemaVersion = 1;
    
    fileName = "controls.json";
    playerIndex = 0;
    
    viewForGamepad = false;
    
    dirty = false;
    status = "";
    
    rebinding = false;
    rebindDevice = undefined;
    rebindForGamepad = false;
    rebindVerb = -1;
    rebindAlternate = 0;
    
    // -----------------------------------------------------
    // Device view
    // -----------------------------------------------------
    
    static IsViewingGamepad = function()
    {
        return viewForGamepad;
    }
    
    static GetViewLabel = function()
    {
        return viewForGamepad ? "Gamepad" : "Keyboard + Mouse";
    }
    
    static ToggleView = function()
    {
        if(rebinding) return;
            
        viewForGamepad = !viewForGamepad;
        status = "";
    }
    
    // -----------------------------------------------------
    // Connected gamepad lookup
    // -----------------------------------------------------
    
    static GetFirstConnectedGamepad = function()
    {
        var _devices = InputDeviceEnumerate(false);
        
        for(var _i = 0; _i < array_length(_devices); _i++)
        {
            var _device = _devices[_i];
            
            if(InputDeviceIsGamepad(_device)) return _device;
        }
        
        return undefined;
    }
    
    static GetScanDevice = function()
    {
        if(viewForGamepad) return GetFirstConnectedGamepad();
            
        return INPUT_KBM;
    }
    
    // -----------------------------------------------------
    // Binding labels
    // -----------------------------------------------------
    
    static GetBindingSlotLabel = function(_verb, _alternate = 0)
    {
        var _binding = InputBindingGet(viewForGamepad, _verb, _alternate, playerIndex);
        
        if(is_undefined(_binding)) return "Unbound";
            
        return InputGetBindingName(_binding, viewForGamepad, "Unbound");
    }
    
    static GetBindingSummary = function(_verb)
    {
        var _summary = "";
        var _alternate = 0;
        
        while(true)
        {
            var _binding = InputBindingGet(viewForGamepad, _verb, _alternate, playerIndex);
            
            if(is_undefined(_binding)) break;
                
            var _label = InputGetBindingName(_binding, viewForGamepad, "Unbound");
            
            if(_summary != "")
            {
                _summary += " / ";
            }
            
            _summary += _label;
            _alternate++;
        }
        
        return (_summary == "") ? "Unbound" : _summary;
    }
    
    // -----------------------------------------------------
    // Rebinding
    // -----------------------------------------------------

    static IsRebinding = function()
    {
        return rebinding;
    }
    
    static IsRebindingVerb = function(_verb, _alternate = 0)
    {
        return rebinding and rebindVerb == _verb and rebindAlternate == _alternate;
    }
    
    static BeginRebind = function(_verb, _alternate = 0)
    {
        if(rebinding) return;
            
        var _device = GetScanDevice();
        
        if(is_undefined(_device))
        {
            status = "Connect a gamepad before rebinding";
            
            return false;
        }
        
        rebinding = true;
        rebindDevice = _device;
        rebindForGamepad = viewForGamepad;
        rebindVerb = _verb;
        rebindAlternate = _alternate;
        
        status = rebindForGamepad ? "Press a new gamepad input." : "Press a new key or mouse input.";
        
        InputDeviceSetRebinding(rebindDevice, true);
        
        return true;
    }
    
    static Update = function()
    {
        if(!rebinding) return false;
            
        var _binding = InputDeviceGetRebindingResult(rebindDevice);
        
        if(is_undefined(_binding)) return false;
            
        InputDeviceSetRebinding(rebindDevice, false);
        
        var _forGamepad = rebindForGamepad;
        var _verb = rebindVerb;
        var _alternate = rebindAlternate;
        
        rebinding = false;
        rebindDevice = undefined;
        rebindForGamepad = false;
        rebindVerb = -1;
        
        var _changed = InputBindingSetSafe(_forGamepad, _verb, _binding, _alternate, playerIndex);
        
        if(_changed)
        {
            dirty = true;
            
            Save();
            
            status = "Bound to " + InputGetBindingName(_binding, _forGamepad, "new input") + ".";
        } 
        else 
        {
            status = "Binding unchanged.";
        }
        
        return true;
    }
    
    static CancelRebind = function()
    {
        if(rebinding)
        {
            InputDeviceSetRebinding(rebindDevice, false);
        }
        
        rebinding = false;
        rebindDevice = undefined;
        rebindForGamepad = false;
        rebindVerb = -1;
        rebindAlternate = 0;
        
        status = "";
    }
    
    // -----------------------------------------------------
    // Reset
    // -----------------------------------------------------
    
    static ResetDefaults = function()
    {
        CancelRebind();
        
        InputBindingsReset(false, playerIndex);
    
        InputBindingsReset(true, playerIndex);
        
        dirty = true;
        status = "Controls reset to defaults.";
        
        Save();
    }
    
    // -----------------------------------------------------
    // Persistence
    // -----------------------------------------------------
    
    static Save = function()
    {
        var _data = 
        {
            version : schemaVersion, 
            
            keyboard:
                InputBindingsExport(false, playerIndex),
                
            gamepad:
                InputBindingsExport(true, playerIndex)
        }
        
        var _file = file_text_open_write(fileName);
        
        if(_file == -1) return false;
            
        file_text_write_string(_file, json_stringify(_data));
        
        var _success = file_text_close(_file);
        
        dirty = !_success;
        
        return _success;
    }
    
    static SaveIfDirty = function()
    {
        if(dirty)
        {
            Save();
        }
    }
    
    static Load = function()
    {
        if(!file_exists(fileName)) return false;
            
        var _file = file_text_open_read(fileName);
        
        if(_file == -1) return false;
            
        // Save() writes compact JSON on a single line
        var _json = file_text_readln(_file);
        
        file_text_close(_file);
        
        try {
        	var _data = json_parse(_json);
            
            if(!is_struct(_data)) return false;
                
            if(!struct_exists(_data, "version") or _data.version != schemaVersion)
            {
                ResetDefaults();
                
                status = "";
                
                return false;
            }
            
            if(struct_exists(_data, "keyboard"))
            {
                InputBindingsImport(false, _data.keyboard, playerIndex);
            }
            
            if(struct_exists(_data, "gamepad"))
            {
                InputBindingsImport(true, _data.gamepad, playerIndex);
            }
            
            dirty = false;
            
            return true;
        }
        catch (_error)
        { 
        	show_debug_message("Unable to load controls.json: " + string(_error));
        }
        
        return false;
    }
}
