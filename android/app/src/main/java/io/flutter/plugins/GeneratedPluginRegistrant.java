package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.difrancescogianmarco.arcore_flutter_plugin.ArcoreFlutterPlugin;
import io.flutter.plugins.camera.CameraPlugin;
import com.amolg.flutterbarcodescanner.FlutterBarcodeScannerPlugin;
import sq.flutter.tflite.TflitePlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    ArcoreFlutterPlugin.registerWith(registry.registrarFor("com.difrancescogianmarco.arcore_flutter_plugin.ArcoreFlutterPlugin"));
    CameraPlugin.registerWith(registry.registrarFor("io.flutter.plugins.camera.CameraPlugin"));
    FlutterBarcodeScannerPlugin.registerWith(registry.registrarFor("com.amolg.flutterbarcodescanner.FlutterBarcodeScannerPlugin"));
    TflitePlugin.registerWith(registry.registrarFor("sq.flutter.tflite.TflitePlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
