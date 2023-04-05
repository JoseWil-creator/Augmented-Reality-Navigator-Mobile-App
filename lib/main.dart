import 'package:provider/provider.dart';
import 'package:unitrail/views/Provider/event_provider.dart';
import 'package:unitrail/views/Widgets/utils.dart';
import 'package:unitrail/BackEndTesting/Gmap.dart';
import 'package:unitrail/BackEndTesting/calandar.dart';
import 'package:unitrail/views/welcome.dart';
import 'package:unitrail/BackEndTesting/Testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:device_preview/device_preview.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(DevicePreview(enabled: false, builder: (context) => MyApp()));

}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return ChangeNotifierProvider(
        create: (context) => EventProvider(),
        child: MaterialApp(
          scaffoldMessengerKey: Utils().messengerKey,
          navigatorKey: navigatorKey,
          title: 'UniTrail',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: DefaultBottomBarController(child: Welcome()),
        ),
      );
    });
  }
}
