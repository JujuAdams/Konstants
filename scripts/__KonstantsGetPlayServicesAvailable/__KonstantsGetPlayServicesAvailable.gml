/// This function is not public and should not be called directly. To detect if Google Play
/// Services is available, please use `K_PLAY_SERVICES`.

function __KonstantsGetPlayServicesAvailable()
{
    static _once = (function()
    {
        var _available = false;
        
        if (K_PLAY_SERVICES_PRESENT)
        {
            try
            {
                var _available = GooglePlayServices_IsAvailable();
            }
            catch(_error)
            {
            }
        }
        
        return _available;
    })();
    
    return _once;
}