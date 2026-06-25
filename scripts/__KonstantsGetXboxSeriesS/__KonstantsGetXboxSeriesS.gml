/// This function is not public and should not be called directly. To detect if Steamworks is
/// available, please use `K_XBOX_SERIES_S`.

function __KonstantsGetXboxSeriesS()
{
    static _once = (function()
    {
        var _xboxSeriesS = false;
        
        if (K_XBOX_SERIES_ANY)
        {
            var _infoMap = os_get_info();
            _xboxSeriesS = (_infoMap[? "device_type"] == device_gdk_xboxseriess);
            ds_map_destroy(_infoMap);
        }
        
        return _xboxSeriesS;
    })();
    
    return _once;
}