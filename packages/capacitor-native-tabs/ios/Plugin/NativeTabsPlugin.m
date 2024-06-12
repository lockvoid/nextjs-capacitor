#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(NativeTabsPlugin, "NativeTabs",
           CAP_PLUGIN_METHOD(pushViewController, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(popViewController, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(presentViewController, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(dismissViewController, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(prepareViewController, CAPPluginReturnPromise);
)
