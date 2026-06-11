function UIScreen(_layerId, _widgets, _onOpen=undefined, _onClose=undefined, _navigationAxis = UI_NAV_AXIS.VERTICAL) constructor 
{
    layerId = _layerId;
    widgets = _widgets;
    
    onOpen = _onOpen;
    onClose = _onClose;
      
    navigationAxis = _navigationAxis;
}
