import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'Screen/Bottom_Nav_Bar/bottomNavBar.dart';
//import 'Screen/Login/OnBoarding.dart';
import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:dikouba/activity/onboarding_activity.dart';

import 'AppTheme.dart';
import 'AppThemeNotifier.dart';
import 'activity/splashscreen_activity.dart';
//import 'firebase_options.dart';


/// Run first apps open
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );
  //runApp(myApp());
  runApp(ChangeNotifierProvider<AppThemeNotifier>(
    create: (context) => AppThemeNotifier(),
    child: myApp(),
  ));
}

/// Set orienttation
class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));

    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
        /*UserModel userModel = new UserModel(
        nbre_followers: '0',
            id_users: 'NekuDL6WO6eiX08LY8jmiUCkIot2',
            email: 'youmsijunior@gmail.com',
            nbre_following: '0',
            name: 'ROMUALD JUNIOR YOUMSI MOUMBE',
            password: 'NekuDL6WO6eiX08LY8jmiUCkIot2',
            photo_url: 'https://lh3.googleusercontent.com/a-/AOh14GghjI3-geYdM4kHUOllmG39EUQBabouB9mjnUMQFw=s96-c',
            email_verified: 'true',
            phone: '',
            password_hash: 'TmVrdURMNldPNmVpWDA4TFk4am1pVUNrSW90Mg==',
            uid: 'NekuDL6WO6eiX08LY8jmiUCkIot2'

        );*/
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
          /*localizationsDelegates: const [
              location_picker.S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          supportedLocales: const <Locale>[
              Locale('en', ''),
              Locale('fr', ''),
          ],*/
          // home: RegisterActivity(userModel: userModel),);
          // navigatorObservers: <NavigatorObserver>[observer],
          home: SplashScreen(),
          // Move splash screen to ChoseLogin Layout
          // Routes
          routes: <String, WidgetBuilder>{
            "login": (BuildContext context) => new SplashScreen()
          },
        );
      },
    );
    return new MaterialApp(
      title: "Dikouba",
      theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColorLight: Colors.white,
          primaryColorBrightness: Brightness.light,
          primaryColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

      /// Move splash screen to ChoseLogin Layout
      /// Routes
      routes: <String, WidgetBuilder>{
        "login": (BuildContext context) => new SplashScreen()
      },
    );
  }
}

/*
/// Component UI
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// Component UI
class _SplashScreenState extends State<SplashScreen> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    startTime();
    if (Platform.isAndroid) {
      // Android-specific code
    } else if (Platform.isIOS) {
      startTime();
      // iOS-specific code
    }

    ///
    /// Setting Message Notification from firebase to user
    ///
    _messaging.getToken().then((token) {
      print(token);
    });

    @override
    void dispose() {
      super.dispose();
    }
  }

  /// Check user
  bool _checkUser = true;

  bool loggedIn = false;

  @override
  late SharedPreferences prefs;

  ///
  /// Checking user is logged in or not logged in
  ///
  Future<Null> _function() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    this.setState(() {
      if (prefs.getString("username") != null) {
        print('false');
        _checkUser = false;
      } else {
        print('true');
        _checkUser = true;
      }
    });
  }

  /// Setting duration in splash screen
  startTime() async {
    return new Timer(Duration(milliseconds: 4500), NavigatorPage);
  }

  /// Navigate user if already login or no
  void NavigatorPage() {
    Navigator.of(context).pushReplacement(
        PageRouteBuilder(pageBuilder: (_, __, ___) => OnBoardingActivity(
          /*analytics: widget.analytics,
          observer: widget.observer,*/
        )));
    /*FirebaseAuth.instance.authStateChanges().listen((User? currentUser) {
      if (currentUser == null) {
        Navigator.of(context).pushReplacement(
            PageRouteBuilder(pageBuilder: (_, __, ___) => onBoarding()));
      } else {
        FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.uid)
            .get()
            /*.then((DocumentSnapshot result) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => bottomNavBar(
                          idUser: currentUser.uid,
                        ))))*/
            .catchError((err) => print(err));
      }
    });*/
  }

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    ///
    /// Check connectivity
    ///
    return

        ///
        /// Layout if user connect internet
        ///

        Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/image/cover.png",
                  ),
                  fit: BoxFit.cover)),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Event Country",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w200,
                        fontSize: 36.0,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/