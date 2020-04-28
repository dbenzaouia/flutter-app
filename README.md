# flutter

Add this dependency in pubspec.yaml : 

  pedometer: ^1.0.0 
  shared_preferences : ^0.5.6+2 
  intl: ^0.16.1 
  sqflite: ^1.3.0 
  path_provider: any
  charts_flutter: ^0.9.0
  connectivity: ^0.4.8+2
  sensors: ^0.4.1+10
  light: ^0.1.1
  flutter_bluetooth_serial: ^0.2.2
  new_geolocation: ^1.0.0
  geocoder: ^0.2.1
  geolocator: ^5.1.5


modify the minsdkVersion to 21 in android/app/build.gradle (defaultconfig)
add this line "<uses-sdk android:minSdkVersion="21"/>" in android/src/debug/AndroidManifest.xml


The assets file must be added outside lib file.
add assetsdependencies to yaml file like that :


  # To add assets to your application, add an assets section, like this:
  assets:
    - assets/images/
    - assets/fitness_app/
    
  #  To add the map on your device, you should get a google map API key : 
    https://pub.dev/packages/google_maps_flutter	
    
    https://www.raywenderlich.com/4466319-google-maps-for-flutter-tutorial-getting-started	    

