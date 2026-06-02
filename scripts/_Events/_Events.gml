enum EventType {
    INPUT
}

function EventController() constructor {
	listeners = ds_list_create();
	eventBuffer = ds_map_create(); // map<EventType, array>
	
	#region === EVENT BUFFERING ===
	
	Buffer = function(_type, _event, _data) {
        if (!ds_map_exists(eventBuffer, _type))
            eventBuffer[? _type] = [];
        array_push(eventBuffer[? _type], { event: _event, data: _data });
    }

    Flush = function(_type) {
        if (!ds_map_exists(eventBuffer, _type)) return;

        var arr = eventBuffer[? _type];

        for (var i = 0; i < array_length(arr); i++) {
            var e = arr[i];
            Call(_type, e.event, e.data);
        }

        eventBuffer[? _type] = [];
    }
	
	#endregion
	
	Call = function(_eventType, _event, _data = undefined) {
		var _size = ds_list_size(listeners);
		
		for(var i = 0; i < _size; i++) {
			var _listener = listeners[| i];
			
			if(_listener.eventType == _eventType) {
				
				// Case A: listener wants specific event
				if(_listener.event != undefined) {
					if(_listener.event == _event) {
						if(is_method(_listener.action)) _listener.action(_data);		
					}
				} 
				
				// Case B: listener wants ANY event of this type
				else {
					if(is_method(_listener.action)) _listener.action(_event, _data);
				}
			}
		}
	}
	
	Add = function(_listener) {
		ds_list_add(listeners, _listener);	
	}
	
	Remove = function(_listener) {
		var _index = ds_list_find_index(listeners, _listener);
		if(_index >= 0) ds_list_delete(listeners, _index);
	}
	
	Cleanup = function() {
		ds_list_destroy(listeners);	
		ds_map_destroy(eventBuffer);
	}
}

// @function				EventListener(_eventType, _event, _action);
/// @param {Real}			_eventType
/// @param {String}			_event
/// @param {function}		_action
/// @description			Creates an EventListener
function EventListener(_eventType, _event = undefined, _action = function(_data) {}) constructor {
	eventType = _eventType;
	event = _event;
	action = _action;
}