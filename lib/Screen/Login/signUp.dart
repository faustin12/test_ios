import 'package:test_ios/Library/loader_animation/loader.dart';
import 'package:test_ios/Library/loader_animation/dot.dart';
//import 'package:test_ios/Screen/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class signUp extends StatefulWidget {
  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  bool _isSelected = false;
  File selectedImage;
  bool imageUpload = true;
  String filename;
  File tempImage;
  bool isLoading = false;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String _email, _pass, _pass2, _name, _country, _city;
  var profilePicUrl;
  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupCountryController = new TextEditingController();
  TextEditingController signupCityController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  ///
  /// Response file from image picker
  ///
  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response == null) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.type == RetrieveType.video) {
        } else {}
      });
    } else {}
  }

  ///
  /// Get data from gallery image
  ///
  Future selectPhoto() async {
    tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = tempImage;
      filename = basename(selectedImage.path);
      uploadImage();

      retrieveLostData();
    });
  }

  ///
  /// Upload image to firebase storage
  ///
  // Future uploadImage() async {
  //   final StorageReference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child(filename);
  //   StorageUploadTask uploadTask = firebaseStorageRef.putFile(selectedImage);
  //   var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
  //   profilePicUrl = dowurl.toString();
  //   print("download url = $profilePicUrl");
  //   return profilePicUrl;
  // }

  // Future uploadImage() async {
  //   FirebaseStorage storage = FirebaseStorage.instance;

  //   Reference ref = storage.ref().child("image1" + DateTime.now().toString());
  //   UploadTask uploadTask = ref.putFile(_image);

  //   // Waits till the file is uploaded then stores the download url
  //   // Uri location = (await uploadTask.).downloadUrl;
  //   // TaskSnapshot taskSnapshot =
  //   //     await ref.putFile(_image).whenComplete(() => ref.getDownloadURL());
  //   // print("dsad" + taskSnapshot.ref.getDownloadURL().toString());

  //   String image = "dsadas";
  //   FirebaseStorage.instance
  //       .refFromURL(image)
  //       .getDownloadURL()
  //       .then((url) async {
  //     print("irl " + url);
  //   });

  //   uploadTask.then((res) {
  //     String linkPP = res.ref.getDownloadURL().toString();
  //     print(linkPP);
  //     // print('File Uploaded');
  //     profilePicUrl = res.toString();
  //     if (profilePicUrl == null) {
  //       imageUpload = false;
  //     }
  //     setState(() {
  //       profilePicUrl = res.toString();
  //     });

  //     print("download urls = $linkPP");
  //     return linkPP;
  //   });
  // }

  Future uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(selectedImage);

    // Waits till the file is uploaded then stores the download url
    // Uri location = (await uploadTask.).downloadUrl;
    // TaskSnapshot taskSnapshot =
    //     await ref.putFile(_image).whenComplete(() => ref.getDownloadURL());
    // print("dsad" + taskSnapshot.ref.getDownloadURL().toString());

    String image = "dsadas";
    FirebaseStorage.instance
        .refFromURL(image)
        .getDownloadURL()
        .then((url) async {
      print("irl " + url);
    });

    uploadTask.then((res) {
      String linkPP = res.ref.getDownloadURL().toString();
      print(linkPP);
      // print('File Uploaded');
      profilePicUrl = res.toString();
      if (profilePicUrl == null) {
        imageUpload = false;
      }
      setState(() {
        profilePicUrl = res.toString();
      });

      print("download urls = $linkPP");
      return linkPP;
    });
  }

  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  ///
  /// Show password
  ///
  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  ///
  /// Show password
  ///
  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

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

    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: isLoading
          ?

          ///
          /// Loading layout login
          ///
          Center(
              child: ColorLoader5(
              dotOneColor: Colors.red,
              dotTwoColor: Colors.blueAccent,
              dotThreeColor: Colors.green,
              dotType: DotType.circle,
              dotIcon: Icon(Icons.adjust),
              duration: Duration(seconds: 1),
            ))
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
                                    fontFamily: "Sofia",
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
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12.withOpacity(0.08),
                                    offset: Offset(0.0, 15.0),
                                    blurRadius: 15.0),
                                BoxShadow(
                                    color: Colors.black12.withOpacity(0.01),
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
                                      child: Text("Signup",
                                          style: TextStyle(
                                              fontSize: ScreenUtil.getInstance()
                                                  .setSp(32),
                                              fontFamily: "Sofia",
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
                                        Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                height: 100.0,
                                                width: 100.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50.0)),
                                                    color: Colors.blueAccent,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black12
                                                              .withOpacity(0.1),
                                                          blurRadius: 10.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                child: selectedImage == null
                                                    ? new Stack(
                                                        children: <Widget>[
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .blueAccent,
                                                            radius: 400.0,
                                                            backgroundImage:
                                                                AssetImage(
                                                              "assets/image/emptyProfilePicture.png",
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: InkWell(
                                                              onTap: () {
                                                                selectPhoto();
                                                              },
                                                              child: Container(
                                                                height: 30.0,
                                                                width: 30.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              50.0)),
                                                                  color: Colors
                                                                      .blueAccent,
                                                                ),
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 18.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : new CircleAvatar(
                                                        backgroundImage:
                                                            new FileImage(
                                                                selectedImage),
                                                        radius: 220.0,
                                                      ),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                "Photo Profile",
                                                style: TextStyle(
                                                    fontFamily: "Sofia",
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text("Name",
                                            style: TextStyle(
                                                fontFamily: "Sofia",
                                                fontSize:
                                                    ScreenUtil.getInstance()
                                                        .setSp(30),
                                                letterSpacing: .9,
                                                fontWeight: FontWeight.w600)),
                                        TextFormField(
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'Please input your name';
                                            }
                                          },
                                          onSaved: (input) => _name = input,
                                          controller: signupNameController,
                                          keyboardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          style: TextStyle(
                                              fontFamily: "WorkSofiaSemiBold",
                                              fontSize: 16.0,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            icon: Icon(
                                              FontAwesomeIcons.user,
                                              size: 19.0,
                                              color: Colors.black45,
                                            ),
                                            hintText: "Name",
                                            hintStyle: TextStyle(
                                                fontFamily: "Sofia",
                                                fontSize: 15.0),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text("Country",
                                            style: TextStyle(
                                                fontFamily: "Sofia",
                                                fontSize:
                                                    ScreenUtil.getInstance()
                                                        .setSp(30),
                                                letterSpacing: .9,
                                                fontWeight: FontWeight.w600)),
                                        TextFormField(
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'Please input your country';
                                            }
                                          },
                                          onSaved: (input) => _country = input,
                                          controller: signupCountryController,
                                          keyboardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          style: TextStyle(
                                              fontFamily: "WorkSofiaSemiBold",
                                              fontSize: 16.0,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            icon: Icon(
                                              FontAwesomeIcons.university,
                                              size: 19.0,
                                              color: Colors.black45,
                                            ),
                                            hintText: "Country",
                                            hintStyle: TextStyle(
                                                fontFamily: "Sofia",
                                                fontSize: 15.0),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text("City",
                                            style: TextStyle(
                                                fontFamily: "Sofia",
                                                fontSize:
                                                    ScreenUtil.getInstance()
                                                        .setSp(30),
                                                letterSpacing: .9,
                                                fontWeight: FontWeight.w600)),
                                        TextFormField(
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'Please input your city';
                                            }
                                          },
                                          onSaved: (input) => _city = input,
                                          controller: signupCityController,
                                          keyboardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          style: TextStyle(
                                              fontFamily: "WorkSofiaSemiBold",
                                              fontSize: 16.0,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            icon: Icon(
                                              Icons.location_city,
                                              size: 22.0,
                                              color: Colors.black45,
                                            ),
                                            hintText: "City",
                                            hintStyle: TextStyle(
                                                fontFamily: "Sofia",
                                                fontSize: 15.0),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text("Email",
                                            style: TextStyle(
                                                fontFamily: "Sofia",
                                                fontSize:
                                                    ScreenUtil.getInstance()
                                                        .setSp(30),
                                                letterSpacing: .9,
                                                fontWeight: FontWeight.w600)),
                                        TextFormField(
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'Please input your email';
                                            }
                                          },
                                          onSaved: (input) => _email = input,
                                          controller: signupEmailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: TextStyle(
                                              fontFamily: "WorkSofiaSemiBold",
                                              fontSize: 16.0,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            icon: Icon(
                                              FontAwesomeIcons.envelope,
                                              color: Colors.black45,
                                              size: 18.0,
                                            ),
                                            hintText: "Email Address",
                                            hintStyle: TextStyle(
                                                fontFamily: "Sofia",
                                                fontSize: 16.0),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text("Password",
                                            style: TextStyle(
                                                fontFamily: "Sofia",
                                                fontSize:
                                                    ScreenUtil.getInstance()
                                                        .setSp(30),
                                                letterSpacing: .9,
                                                fontWeight: FontWeight.w600)),
                                        TextFormField(
                                          controller: signupPasswordController,
                                          obscureText: _obscureTextSignup,
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'Please input your password';
                                            }
                                            if (input.length < 8) {
                                              return 'Input more 8 character';
                                            }
                                          },
                                          onSaved: (input) => _pass = input,
                                          style: TextStyle(
                                              fontFamily: "WorkSofiaSemiBold",
                                              fontSize: 16.0,
                                              color: Colors.black45),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            icon: Icon(
                                              FontAwesomeIcons.lock,
                                              color: Colors.black45,
                                              size: 18.0,
                                            ),
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                fontFamily: "Sofia",
                                                fontSize: 16.0),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                _toggleSignup();
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.eye,
                                                size: 15.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        // Text("Re-Password",
                                        //     style: TextStyle(
                                        //         fontFamily: "Sofia",
                                        //         fontSize:
                                        //             ScreenUtil.getInstance()
                                        //                 .setSp(30),
                                        //         letterSpacing: .9,
                                        //         fontWeight: FontWeight.w600)),
                                        // TextFormField(
                                        //   controller:
                                        //       signupConfirmPasswordController,
                                        //   obscureText:
                                        //       _obscureTextSignupConfirm,
                                        //   validator: (input) {
                                        //     if (input.isEmpty) {
                                        //       return 'Please re-input your password';
                                        //     }
                                        //   },
                                        //   onSaved: (input) => _pass2 = input,
                                        //   style: TextStyle(
                                        //       fontFamily: "WorkSofiaSemiBold",
                                        //       fontSize: 16.0,
                                        //       color: Colors.black45),
                                        //   decoration: InputDecoration(
                                        //     border: InputBorder.none,
                                        //     icon: Icon(
                                        //       FontAwesomeIcons.lock,
                                        //       color: Colors.black45,
                                        //       size: 18.0,
                                        //     ),
                                        //     hintText: "Password",
                                        //     hintStyle: TextStyle(
                                        //         fontFamily: "Sofia",
                                        //         fontSize: 16.0),
                                        //     suffixIcon: GestureDetector(
                                        //       onTap: () {
                                        //         _toggleSignupConfirm();
                                        //       },
                                        //       child: Icon(
                                        //         FontAwesomeIcons.eye,
                                        //         size: 15.0,
                                        //         color: Colors.black,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
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
                                        fontWeight: FontWeight.w600,
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
                                      if (formState.validate()) {
                                        formState.save();
                                        setState(() {
                                          isLoading = true;
                                        });
                                        try {
                                          if (profilePicUrl == null) {
                                            setState(() {
                                              profilePicUrl =
                                                  "https://firebasestorage.googleapis.com/v0/b/event-f3833.appspot.com/o/emptyProfilePicture.png?alt=media&token=c129b8c2-3e0e-4c26-95d1-fb767fdd7259";
                                            });
                                          }
                                          prefs.setString("username", _name);
                                          prefs.setString("email", _email);
                                          prefs.setString("country", _country);
                                          prefs.setString("photoURL",
                                              profilePicUrl.toString());
                                          prefs.setString("city", _city);

                                          FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: signupEmailController
                                                      .text,
                                                  password:
                                                      signupPasswordController
                                                          .text)
                                              .then((currentUser) =>
                                                  FirebaseFirestore.instance
                                                      .collection("users")
                                                      .doc(currentUser.user.uid)
                                                      .set({
                                                        "uid": currentUser
                                                            .user.uid,
                                                        "name":
                                                            signupNameController
                                                                .text,
                                                        "email":
                                                            signupEmailController
                                                                .text,
                                                        "password":
                                                            signupPasswordController
                                                                .text,
                                                        "country":
                                                            signupCountryController
                                                                .text,
                                                        "city":
                                                            signupCityController
                                                                .text,
                                                        "photoProfile":
                                                            profilePicUrl
                                                                .toString(),
                                                      })
                                                      /*.then((result) => {
                                                            Navigator.of(context).pushReplacement(
                                                                PageRouteBuilder(
                                                                    pageBuilder: (_,
                                                                            __,
                                                                            ___) =>
                                                                        new bottomNavBar(
                                                                          idUser: currentUser
                                                                              .user
                                                                              .uid,
                                                                        ))),
                                                          })*/
                                                      .catchError(
                                                          (err) => print(err)))
                                              .catchError((err) => print(err));
                                        } catch (e) {
                                          print(e.message);
                                          print(_email);
                                          print(_pass);
                                        }
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Error"),
                                                content: Text(
                                                    "Please input all form"),
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
                                      child: Text("SIGNUP",
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
                            Text("Have Account?",
                                style: TextStyle(
                                    fontSize: 13.0, fontFamily: "Sofia")),
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
                                        pageBuilder: (_, __, ___) => login()));
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
                                  child: Text("SignIn",
                                      style: TextStyle(
                                          color: Color(0xFFD898F8),
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 1.4,
                                          fontSize: 15.0,
                                          fontFamily: "Sofia")),
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
