import 'package:test_ios/Library/loader_animation/loader.dart';
import 'package:test_ios/Library/loader_animation/dot.dart';
//import 'package:test_ios/Screen/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:test_ios/Screen/Login/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => new _loginState();
}

class _loginState extends State<login> {
  bool _isSelected = false;
  bool isLoading = false;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String _email, _pass, _email2, _pass2, _name, _id;

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  ///
  /// Create Show Password
  ///
  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  ///
  ///  Create line horizontal
  ///
  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    ///
    /// Loading user for check email and password to firebase database
    ///
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      ///
      /// Check loading for layout
      ///
      body: isLoading
          ? Center(
              child: ColorLoader5(
              dotOneColor: Colors.red,
              dotTwoColor: Colors.blueAccent,
              dotThreeColor: Colors.green,
              dotType: DotType.circle,
              dotIcon: Icon(Icons.adjust),
              duration: Duration(seconds: 1),
            ))

          ////
          /// Layout loading
          ///
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Image.asset(
                        "assets/image/image_01.png",
                        height: 250.0,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Image.asset("assets/image/image_02.png")
                  ],
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 28.0, right: 28.0, top: 100.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            Text("Event",
                                style: TextStyle(
                                    fontFamily: "Popins",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(60),
                                    letterSpacing: 1.2,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(180),
                        ),
                        Container(
                          width: double.infinity,
                          height: ScreenUtil.getInstance().setHeight(550),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 15.0),
                                    blurRadius: 15.0),
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, -10.0),
                                    blurRadius: 10.0),
                              ]),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 0.0, right: 0.0, top: 0.0),
                            child: Form(
                              key: _registerFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 120.0,
                                    height: 45.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(80.0)),
                                      color: Color(0xFFD898F8),
                                    ),
                                    child: Center(
                                      child: Text("Login",
                                          style: TextStyle(
                                              fontSize: ScreenUtil.getInstance()
                                                  .setSp(36),
                                              fontFamily: "Popins",
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              letterSpacing: .63)),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Email",
                                            style: TextStyle(
                                                fontFamily: "Popins",
                                                fontSize:
                                                    ScreenUtil.getInstance()
                                                        .setSp(30),
                                                letterSpacing: .9)),
                                        TextFormField(
                                          ///
                                          /// Add validator
                                          ///
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'Please typle an email';
                                            }
                                          },
                                          onSaved: (input) => _email = input,
                                          controller: loginEmailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: TextStyle(
                                              fontFamily: "WorkSansSemiBold",
                                              fontSize: 16.0,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            icon: Icon(
                                              FontAwesomeIcons.envelope,
                                              color: Colors.black45,
                                              size: 20.0,
                                            ),
                                            hintText: "Email Address",
                                            hintStyle: TextStyle(
                                                fontFamily: "Sans",
                                                fontSize: 15.0,
                                                letterSpacing: 1.5,
                                                color: Colors.black45),
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil.getInstance()
                                              .setHeight(30),
                                        ),
                                        Text("Password",
                                            style: TextStyle(
                                                fontFamily: "Popins",
                                                fontSize:
                                                    ScreenUtil.getInstance()
                                                        .setSp(30),
                                                letterSpacing: .9)),
                                        TextFormField(
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'Please typle an password';
                                            }
                                          },
                                          onSaved: (input) => _pass = input,
                                          controller: loginPasswordController,
                                          obscureText: _obscureTextLogin,
                                          style: TextStyle(
                                              fontFamily: "Arial",
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            icon: Icon(
                                              FontAwesomeIcons.lock,
                                              size: 20.0,
                                              color: Colors.black45,
                                            ),
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                fontFamily: "Sans",
                                                fontSize: 16.0,
                                                color: Colors.black54),
                                            suffixIcon: GestureDetector(
                                              onTap: _toggleLogin,
                                              child: Icon(
                                                FontAwesomeIcons.eye,
                                                size: 15.0,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil.getInstance()
                                              .setHeight(35),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: ScreenUtil.getInstance().setHeight(40)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 12.0,
                                ),
                                GestureDetector(
                                  onTap: _radio,
                                  child: radioButton(_isSelected),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text("Remember me",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Poppins-Medium"))
                              ],
                            ),
                            InkWell(
                              child: Container(
                                width: ScreenUtil.getInstance().setWidth(330),
                                height: ScreenUtil.getInstance().setHeight(100),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xFFD898F8),
                                      Color(0xFF8189EC)
                                    ]),
                                    borderRadius: BorderRadius.circular(6.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color(0xFF6078ea).withOpacity(.3),
                                          offset: Offset(0.0, 8.0),
                                          blurRadius: 8.0)
                                    ]),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () async {
                                      SharedPreferences prefs;
                                      prefs =
                                          await SharedPreferences.getInstance();
                                      final formState =
                                          _registerFormKey.currentState;
                                      User user;
                                      if (formState.validate()) {
                                        formState.save();
                                        try {
                                          prefs.setString("username", _email);
                                          prefs.setString("id", _id);
                                          user = (await FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                            email: _email,
                                            password: _pass,
                                          ))
                                              .user;

                                          setState(() {
                                            isLoading = true;
                                          });
                                          // user.sendEmailVerification();

                                        } catch (e) {
                                          print('Error: $e');
                                          CircularProgressIndicator();
                                          print(e.message);
                                          print(_email);

                                          print(_pass);
                                        } finally {
                                          if (user != null) {
                                            user = await FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                                  email: _email,
                                                  password: _pass,
                                                )
                                                .then((currentUser) => FirebaseFirestore
                                                    .instance
                                                    .collection("users")
                                                    .doc(currentUser.user.uid)
                                                    .get()
                                                    /*.then((DocumentSnapshot
                                                            result) =>
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                PageRouteBuilder(
                                                                    pageBuilder: (_,
                                                                            __,
                                                                            ___) =>
                                                                        new bottomNavBar(
                                                                          idUser: currentUser
                                                                              .user
                                                                              .uid,
                                                                        ))))*/
                                                    .catchError(
                                                        (err) => print(err)))
                                                .catchError(
                                                    (err) => print(err));
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Login Failed"),
                                                    content: Text(
                                                        "Please check your password and try again!"),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        child: Text("Close"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  );
                                                });
                                          }
                                        }
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Error"),
                                                content: Text(
                                                    "Please check your email and password"),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    child: Text("Close"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      }
                                    },
                                    child: Center(
                                      child: Text("SIGNIN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 18,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(40),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            horizontalLine(),
                            Text("Don't Have Account?",
                                style: TextStyle(
                                    fontSize: 13.0, fontFamily: "Popins")),
                            horizontalLine()
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(30),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                        pageBuilder: (_, __, ___) => signUp()));
                              },
                              child: Container(
                                height: 50.0,
                                width: 300.0,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                  border: Border.all(
                                      color: Color(0xFFD898F8), width: 1.0),
                                ),
                                child: Center(
                                  child: Text("SignUp",
                                      style: TextStyle(
                                          color: Color(0xFFD898F8),
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 1.4,
                                          fontSize: 15.0,
                                          fontFamily: "Popins")),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
