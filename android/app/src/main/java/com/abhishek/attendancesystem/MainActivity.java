package com.abhishek.attendancesystem;

import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.localauth.LocalAuthPlugin;
//import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterFragmentActivity {

  @Override
  public void configureFlutterEngine(FlutterEngine flutterEngine) {
//    GeneratedPluginRegistrant.registerWith(this);
    flutterEngine.getPlugins().add(new LocalAuthPlugin());
  }
}
