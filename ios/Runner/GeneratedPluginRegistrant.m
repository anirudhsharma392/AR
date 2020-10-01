//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<arcore_flutter_plugin/ArcoreFlutterPlugin.h>)
#import <arcore_flutter_plugin/ArcoreFlutterPlugin.h>
#else
@import arcore_flutter_plugin;
#endif

#if __has_include(<camera/CameraPlugin.h>)
#import <camera/CameraPlugin.h>
#else
@import camera;
#endif

#if __has_include(<flutter_barcode_scanner/FlutterBarcodeScannerPlugin.h>)
#import <flutter_barcode_scanner/FlutterBarcodeScannerPlugin.h>
#else
@import flutter_barcode_scanner;
#endif

#if __has_include(<tflite/TflitePlugin.h>)
#import <tflite/TflitePlugin.h>
#else
@import tflite;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [ArcoreFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"ArcoreFlutterPlugin"]];
  [CameraPlugin registerWithRegistrar:[registry registrarForPlugin:@"CameraPlugin"]];
  [FlutterBarcodeScannerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterBarcodeScannerPlugin"]];
  [TflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"TflitePlugin"]];
}

@end
