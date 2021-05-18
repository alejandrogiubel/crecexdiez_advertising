#import "CrecexdiezAdvertisingPlugin.h"
#if __has_include(<crecexdiez_advertising/crecexdiez_advertising-Swift.h>)
#import <crecexdiez_advertising/crecexdiez_advertising-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "crecexdiez_advertising-Swift.h"
#endif

@implementation CrecexdiezAdvertisingPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCrecexdiezAdvertisingPlugin registerWithRegistrar:registrar];
}
@end
