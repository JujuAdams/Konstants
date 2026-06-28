/// Konstants is a library that contains basic macros that return OS and SDK state for a game. Many
/// of these macros resolve at compile time and as such can be used for performance-sensitive
/// branching.



///////
// Miscellaneous
///////

// Version of the Konstants library.
#macro KONSTANTS_VERSION  "1.0.0"

// Publication date of the Konstants library.
#macro KONSTANTS_DATE  "2026-06-25"

// Whether the game is running from the IDE or not. Helpful for toggling off features that should
// never be available in production builds.
#macro K_RUNNING_FROM_IDE  (GM_build_type == "run")



///////
// Collective
///////

// Whether game is running on Windows, macOS, or Linux.
#macro K_DESKTOP  (K_WINDOWS || K_MACOS || K_LINUX)

// Whether the game is running on iOS or Android. This constant will be `false` when running using
// the tvOS export target.
#macro K_MOBILE  (K_IOS || K_ANDROID)

// Whether the game is running on macOS, iOS, or tvOS. This macro may be of use when setting up
// in-app purchases using Apple's SDK.
#macro K_APPLE  (K_IOS || K_TVOS || K_MACOS)

// Whether the game is running on any type of XBOX.
#macro K_XBOX  (K_XBOX_ONE || K_XBOX_SERIES_ANY)

// Whether the game is running on Sony PlayStation 3, 4, or 5.
#macro K_PSX  (K_PS3 || K_PS4 || K_PS5)

// Whether the game is running on Nintendo Switch 1 or 2.
#macro K_SWITCH_X  (K_SWITCH || K_SWITCH_2)

// Whether the game is using DirectX for rendering. This is only the case when running on Windows
// not through a browser and when running on an XBOX console.
// 
// N.B. This macro will not necessarily be resolved at compile time and should not be used in areas
//      of your codebase that are performance-sensitive.
#macro K_DIRECTX  ((K_WINDOWS || K_XBOX) && (not K_WEB))

// Whether the game is using OpenGL for rendering. This is every platform other than Windows and
// XBOX, and when running through the browser on any platform.
// 
// N.B. This macro will not necessarily be resolved at compile time and should not be used in areas
//      of your codebase that are performance-sensitive.
#macro K_OPENGL  (not K_DIRECTX)

// Whether the game is running on a platform with normative matrix behaviour. "Normative" for the
// purposes of this macro means a native Windows export.
// 
// N.B. This macro will not necessarily be resolved at compile time and should not be used in areas
//      of your codebase that are performance-sensitive.
#macro K_MATRIX_NORMATIVE  ((os_type == os_xboxone) || (os_type == os_xboxseriesxs) || (os_type == os_ps5) || ((os_type == os_windows) && (os_browser == browser_not_a_browser)))

// Whether the game is running through a browser. This macro will return `true` when running using
// the HTML5 export target or the GX.Games export target.
// 
// N.B. This macro will not necessarily be resolved at compile time and should not be used in areas
//      of your codebase that are performance-sensitive.
#macro K_WEB  (K_GXGAMES || (os_browser != browser_not_a_browser))



///////
// Platforms
///////

// Whether the game is running on Microsoft Windows. This macro will return `true` when running on
// Windows through a web browser when using the HTML5 export target.
#macro K_WINDOWS  (os_type == os_windows)

// Whether the game is running using the Apple macOS export target. This macro will return `true`
// when running on macOS through a web browser when using the HTML5 export target.
#macro K_MACOS  (os_type == os_macosx)

// Whether the game is running using Linux export target. This macro will return `true` when
// running on Linux through a web browser when using the HTML5 export target.
#macro K_LINUX  (os_type == os_linux)

// Whether the game is running using Apple iOS export target. This macro will return `true` when
// running on iOS through a web browser when using the HTML5 export target.
#macro K_IOS  (os_type == os_ios)

// Whether the game is running using Apple tvOS export target. This macro will return `true` when
// running on tvOS through a web browser when using the HTML5 export target.
#macro K_TVOS  (os_type == os_tvos)

// Whether the game is running using Android export target. This macro will return `true` when
// running on Android through a web browser when using the HTML5 export target.
#macro K_ANDROID  (os_type == os_android)

// Whether the game is running using XBOX Series X or Series S export target.
#macro K_XBOX_SERIES_ANY  (os_type == os_xboxseriesxs)

// Whether the game is running on an XBOX Series X console specifically. This is helpful to adjust
// graphics options to reflect the greater performance of the Series X hardware versus the Series S
// hardware.
// 
// N.B. This macro will not be resolved at compile time and should not be used in areas of your
//      codebase that are performance-sensitive.
#macro K_XBOX_SERIES_X  ((os_type == os_xboxseriesxs) && (not __KonstantsGetXboxSeriesS()))

// Whether the game is running on an XBOX Series S console specifically. This is helpful to adjust
// graphics options to reflect the lower performance of the Series S hardware versus the Series X
// hardware.
// 
// N.B. This macro will not be resolved at compile time and should not be used in areas of your
//      codebase that are performance-sensitive.
#macro K_XBOX_SERIES_S  ((os_type == os_xboxseriesxs) && __KonstantsGetXboxSeriesS())

// Whether the game is running using Sony PlayStation 4 export target.
#macro K_PS4  (os_type == os_ps4)

// Whether the game is running using Sony PlayStation 5 export target.
#macro K_PS5  (os_type == os_ps5)

// Whether the game is running using Nintendo Switch 1 specifically.
#macro K_SWITCH  (os_type == os_switch)

// Whether the game is running using Nintendo Switch 2 specifically.
#macro K_SWITCH_2  (os_type == os_switch2)

// Whether the game is running using the GX.Games export target.
#macro K_GXGAMES  (os_type == os_gxgames)

// Whether the game is running using the HTML5 export target.
// 
// N.B. This macro will not necessarily be resolved at compile time and should not be used in areas
//      of your codebase that are performance-sensitive.
#macro K_HTML5  ((not K_GXGAMES) && K_WEB)



///////
// SDKs
///////

// N.B. All SDK macros are partially dynamic and will not necessarily resolve at compile time.
//      Do not rely on these macros to be maximally performant and cache them if necessary.

// Whether the game is running on a desktop platform and Steamworks is present and has been
// initialized successfully.
// 
// N.B. This macro relies on the name of the Steamworks extension to be exactly "Steamworks".
//      The official YoYoGames extension uses this name so no user adjustment is expected.
#macro K_STEAMWORKS  (K_DESKTOP && __KonstantsGetSteamAvailable())

// Whether the game is running on iOS and GameCenter is present in the project.
// 
// N.B. This macro relies on the name of the GameCenter extension to be exactly "GameCenter".
//      The official YoYoGames extension uses this name so no user adjustment is expected.
#macro K_GAMECENTER  (K_IOS && extension_exists("GameCenter"))

// Whether the game is running on Android and Google Play Services is present and has been
// initialized successfully.
#macro K_PLAY_SERVICES  (K_ANDROID && __KonstantsGetPlayServicesAvailable())

// Whether the game is running on Windows and GDK is present in the project.
// 
// N.B. This macro relies on the name of the Windows GDK extension to be exactly "GDKExtension".
//      The official YoYoGames extension uses this name so no user adjustment is expected.
#macro K_WINDOWS_GDK  (K_WINDOWS && extension_exists("GDKExtension"))

// Whether the game is running on Windows and GDK is present in the project, or the game is running
// on XBOX Series X or Series S.
#macro K_XBOX_GDK  (K_XBOX_SERIES_ANY || K_WINDOWS_GDK)

// Whether the game is running on a desktop platform and Steamworks is present in the project. This
// macro does *not* consider whether Steamworks initialized successfully. This macro can therefore
// be used to detect a failure to initialize Steamworks.
// 
// N.B. This macro relies on the name of the Steamworks extension to be exactly "Steamworks".
//      The official YoYoGames extension uses this name so no user adjustment is expected.
#macro K_STEAMWORKS_PRESENT  (K_DESKTOP && extension_exists("Steamworks"))

// Whether the game is running on Android and Google Play Services is present in the project. This
// macro does *not* consider whether Google Play Services initialized successfully. This macro can
// therefore be used to detect a failure to initialize Google Play Services.
// 
// N.B. This macro relies on the name of the Windows GDK extension to be exactly "GDKExtension".
//      The official YoYoGames extension uses this name so no user adjustment is expected.
#macro K_PLAY_SERVICES_PRESENT  (K_ANDROID && extension_exists("GooglePlayServices"))



///////
// Deprecated
///////

// Whether the game is running using the Sony PlayStation 3 export target.
#macro K_PS3  (os_type == os_ps3)

// Whether the game is running using the XBOX One export target.
#macro K_XBOX_ONE  (os_type == os_xboxone)

show_debug_message($"Welcome to Konstants by Juju Adams! This is version {KONSTANTS_VERSION}, {KONSTANTS_DATE}");
