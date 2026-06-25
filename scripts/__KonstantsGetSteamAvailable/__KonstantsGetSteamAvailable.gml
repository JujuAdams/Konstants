/// This function is not public and should not be called directly. To detect if Steamworks is
/// available, please use `K_STEAMWORKS`.

function __KonstantsGetSteamAvailable()
{
    static _once = (function()
    {
        var _available = false;
        
        if (K_WINDOWS_GDK)
        {
            if (K_STEAMWORKS_PRESENT)
            {
                show_error(" \nCannot use Steam extension and Windows GDK extension together\n ", true);
            }
        }
        else if (K_STEAMWORKS_PRESENT)
        {
            try
            {
                var _available = steam_initialised();
            }
            catch(_error)
            {
            }
        }
        
        return _available;
    })();
    
    return _once;
}