#import "BleWrapPlugin.h"
#if __has_include(<ble_wrap/ble_wrap-Swift.h>)
#import <ble_wrap/ble_wrap-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ble_wrap-Swift.h"
#endif

@implementation BleWrapPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBleWrapPlugin registerWithRegistrar:registrar];
}
@end
