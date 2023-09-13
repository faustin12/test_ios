import 'package:dikouba/AppTheme.dart';
import 'package:dikouba/AppThemeNotifier.dart';
import 'package:dikouba/activity/annoncer/eventnewannoncer_activity.dart';
import 'package:dikouba/activity/choseloginsignup_activity.dart';
import 'package:dikouba/activity/register_activity.dart';
import 'package:dikouba/activity/user/userprofil_activity.dart';
import 'package:dikouba/activity/welcome_activity.dart';
import 'package:dikouba/fragment/EventAgendaScreen.dart';
import 'package:dikouba/fragment/EventCreateScreen.dart';
import 'package:dikouba/fragment/EventHomeScreen.dart';
import 'package:dikouba/fragment/EventMapScreen.dart';
import 'package:dikouba/fragment/EventProfileScreen.dart';
import 'package:dikouba/fragment/EventSondagesScreen.dart';
import 'package:dikouba/model/user_model.dart';
import 'package:dikouba/provider/databasehelper_provider.dart';
import 'package:dikouba/utils/DikoubaColors.dart';
import 'package:dikouba/utils/SizeConfig.dart';
//import 'package:firebase_auth_ui/firebase_auth_ui.dart';
//import 'package:firebase_auth_ui/providers.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../fragment/EventLiveScreen.dart';

//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_analytics/observer.dart';

class HomeActivity extends StatefulWidget {
  HomeActivity({Key? key,
    //this.analytics, this.observer
  }) : super(key: key);

  //final FirebaseAnalytics analytics;
  //final FirebaseAnalyticsObserver observer;

  @override
  HomeActivityState createState() => HomeActivityState();
}

class HomeActivityState extends State<HomeActivity>
    with SingleTickerProviderStateMixin {
  static final String TAG = 'HomeActivityState';
  int _currentIndex = 0;
  
  UserModel? _userModel;

  CustomAppTheme? customAppTheme;

  TabController? _tabController;

  _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController!.index;
    });
  }

  bool _showTabview = true;
  Widget _bodyCustom = Container();

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  void queryUser() async {
    final userRows = await dbHelper.query_user();
    print(
        '${TAG}:queryUser query all rows:${userRows.length} | ${userRows.toString()}');
    setState(() {
      _userModel = UserModel.fromJsonDb(userRows[0]);
    });
    _setUserId(_userModel!.uid);
  }

  Future<void> _setUserId(String uid) async {
    //await FirebaseAnalytics().setUserId(uid);
  }

  Future<void> _sendAnalyticsEvent(String name) async {
    /*await FirebaseAnalytics().logEvent(
      name: name,
      parameters: <String, dynamic>{},
    );*/
  }

  Future<void> _setCurrentScreen() async {
    /*await widget.analytics.setCurrentScreen(
      screenName: "HomeActivity",
      screenClassOverride: "HomeActivity",
    );*/
  }

  @override
  void didPush() {
    // Called when the current route has been pushed.
    _setCurrentScreen();
  }
  @override
  void didPopNext() {
    // Called when the top route has been popped off,
    // and the current route shows up.
    _setCurrentScreen();
  }
  @override
  void initState() {
    queryUser();

    _tabController = new TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController?.addListener(_handleTabSelection);
    _tabController?.animation?.addListener(() {
      final aniValue = _tabController?.animation?.value;
      if (aniValue! - _currentIndex > 0.5) {
        setState(() {
          _currentIndex = _currentIndex + 1;
        });
      } else if (aniValue - _currentIndex < -0.5) {
        setState(() {
          _currentIndex = _currentIndex - 1;
        });
      }
    });
    super.initState();
    _setCurrentScreen();
  }

  onTapped(value) {
    setState(() {
      _currentIndex = value;
    });
    _sendAnalyticsEvent("Page_Index_=_" +  _currentIndex.toString());
  }

  dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  ThemeData? themeData;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    MySize().init(context);
    themeData = Theme.of(context);
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
        customAppTheme  = AppTheme.getCustomAppTheme(value.themeMode());
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
          home: _showTabview
              ? Scaffold(
            key: _scaffoldKey,
            bottomNavigationBar: BottomAppBar(
                elevation: 0,
                shape: CircularNotchedRectangle(),
                child: Container(
                  decoration: BoxDecoration(
                    color: themeData?.bottomAppBarTheme.color,
                    boxShadow: [
                      BoxShadow(
                        color: customAppTheme!.shadowColor,
                        blurRadius: 3,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: themeData?.colorScheme.primary,
                    tabs: <Widget>[
                      Container(
                        child: (_currentIndex == 0)
                            ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              MdiIcons.home,
                              color: DikoubaColors.blue['pri'],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                  color: DikoubaColors.blue['pri'],
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(2.5))),
                              height: 5,
                              width: 5,
                            )
                          ],
                        )
                            : Icon(
                          MdiIcons.homeOutline,
                          color: DikoubaColors.blue['pri'],
                        ),
                      ),
                      Container(
                          child: (_currentIndex == 1)
                              ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                MdiIcons.calendar,
                                color: DikoubaColors.blue['pri'],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                    color: DikoubaColors.blue['pri'],
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(2.5))),
                                height: 5,
                                width: 5,
                              )
                            ],
                          )
                              : Icon(
                            MdiIcons.calendar,
                            color: DikoubaColors.blue['pri'],
                          )),
                      Container(
                          child: (_currentIndex == 2)
                              ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                MdiIcons.map,
                                color: DikoubaColors.blue['pri'],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                    color: DikoubaColors.blue['pri'],
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(2.5))),
                                height: 5,
                                width: 5,
                              )
                            ],
                          )
                              : Icon(
                            MdiIcons.mapOutline,
                            color: DikoubaColors.blue['pri'],
                          )),
                      Container(
                          child: (_currentIndex == 3)
                              ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                MdiIcons.ticketConfirmation,
                                color: DikoubaColors.blue['pri'],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                    color: DikoubaColors.blue['pri'],
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(2.5))),
                                height: 5,
                                width: 5,
                              )
                            ],
                          )
                              : Icon(
                            MdiIcons.ticketConfirmationOutline,
                            color: DikoubaColors.blue['pri'],
                          )),
                    ],
                  ),
                )),
            drawer: _userModel==null ? Container() : Drawer(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: ListView(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        gotoUpdateUserprofile();
                      },
                      child: UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        accountName: Text(
                          _userModel!.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        accountEmail: Text(
                          _userModel!.email,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        currentAccountPicture: CircleAvatar(
                          //backgroundColor: Theme.of(context).accentColor,
                          backgroundImage: NetworkImage(_userModel!.photo_url),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          _scaffoldKey.currentState?.openEndDrawer();
                          _showTabview = true;
                          _bodyCustom = Container();
                        });
                      },
                      leading: Icon(
                        Icons.home,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Accueil',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {

                        setState(() {
                          _scaffoldKey.currentState?.openEndDrawer();
                          _showTabview = false;
                          //_bodyCustom = EventUpcomingScreen(_userModel,);
                        });
                      },
                      leading: Icon(
                        MdiIcons.ticketConfirmation,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Mes évènements',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          _scaffoldKey.currentState?.openEndDrawer();
                          _showTabview = false;
                          _bodyCustom = EventSondagesScreen(_userModel!,);
                        });
                      },
                      leading: Icon(
                        MdiIcons.fileTableBoxMultiple,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Mes sondages',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Notification', arguments: 0);
                      },
                      leading: Icon(
                        Icons.notifications,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Notification',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/MyEvent', arguments: 3);
                      },
                      leading: Icon(
                        Icons.local_mall,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Locl mall',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Favorites');
                      },
                      leading: Icon(
                        Icons.favorite,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        "Favoris",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        "Autres" ,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Icon(
                        Icons.remove,
                        color: Theme.of(context).focusColor.withOpacity(0.3),
                      ),
                    ),
                    ListTile(

                      onTap: () {
                         gotoDevenirAnnoncer();
                      },
                      leading: Icon(
                        Icons.work_sharp,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        (_userModel?.id_annoncers == null || _userModel?.id_annoncers == "")
                        ? 'Devenir annonceur'
                        : 'Modifier annonceur',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        // Navigator.of(context).pop();
                        signOut(context);
                      },
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Se déconnecter',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Help');
                      },
                      leading: Icon(
                        Icons.help,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Support',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        "Dikouba 1.0" ,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Icon(
                        Icons.remove,
                        color: Theme.of(context).focusColor.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
                centerTitle: false,
                elevation: 0,
                backgroundColor: customAppTheme?.bgLayer1,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu_rounded),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
                title: Text(
                  "Dikouba",
                  style: AppTheme.getTextStyle(
                      themeData!.textTheme.headline5!,
                      fontSize: 24,
                      fontWeight: 700,
                      letterSpacing: -0.3,
                      color: DikoubaColors.blue['pri']),
                ),
              actions: [
                Stack(alignment: Alignment.center,
                  children: [
                    Container(
                      padding: Spacing.all(10),
                      decoration: BoxDecoration(
                          color: customAppTheme?.bgLayer1,
                          borderRadius: BorderRadius.all(
                              Radius.circular(MySize.size8!)),
                          boxShadow: [
                            BoxShadow(
                                color: customAppTheme!.shadowColor,
                                blurRadius: MySize.size4!)
                          ]),
                      child: Icon(
                        MdiIcons.bell,
                        size: MySize.size18,
                        color: themeData?.colorScheme.onBackground
                            .withAlpha(160),
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: MySize.size22,
                      child: Container(
                        width: MySize.size6,
                        height: MySize.size6,
                        decoration: BoxDecoration(
                            color: customAppTheme?.colorError,
                            shape: BoxShape.circle),
                      ),
                    )
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        gotoUpdateUserprofile();
                      },
                      child: Container(
                        margin: Spacing.left(16),
                        decoration: BoxDecoration(
                            color: customAppTheme?.bgLayer1,
                            borderRadius: BorderRadius.all(
                                Radius.circular(MySize.size8!)),
                            boxShadow: [
                              BoxShadow(
                                  color: customAppTheme!.shadowColor,
                                  blurRadius: MySize.size4!)
                            ]),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(MySize.size8!)),
                          child: _userModel == null
                              ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(DikoubaColors.blue['pri']!))
                              : _userModel?.photo_url == ""
                              ? Image(
                            image: AssetImage('./assets/logo/user_transparent.webp'),
                            fit: BoxFit.cover,
                            width: MySize.size36,
                            height: MySize.size36,):Image(
                            image: NetworkImage(_userModel!.photo_url),
                            fit: BoxFit.cover,
                            width: MySize.size36,
                            height: MySize.size36,),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(width: 12,)
              ],),
            body: _userModel == null
            ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(DikoubaColors.blue['pri']!))
            : TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                EventHomeScreen(_userModel!,),
                EventAgendaScreen(_userModel!,),
                EventMapScreen(),
                EventLiveScreen()
                //EventProfileScreen(_userModel!)
              ],),
          )
          : Scaffold(
            key: _scaffoldKey,
            drawer: _userModel==null ? Container() : Drawer(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: ListView(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        gotoUpdateUserprofile();
                      },
                      child: UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        accountName: Text(
                          _userModel!.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        accountEmail: Text(
                          _userModel!.email,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        currentAccountPicture: CircleAvatar(
                          //backgroundColor: Theme.of(context).accentColor,
                          backgroundImage: NetworkImage(_userModel!.photo_url),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          _scaffoldKey.currentState?.openEndDrawer();
                          _showTabview = true;
                          _bodyCustom = Container();
                        });
                      },
                      leading: Icon(
                        Icons.home,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Accueil',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          _scaffoldKey.currentState?.openEndDrawer();
                          _showTabview = false;
                          //_bodyCustom = EventUpcomingScreen(_userModel,);
                        });
                      },
                      leading: Icon(
                        MdiIcons.ticketConfirmation,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Mes évènements',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          _scaffoldKey.currentState?.openEndDrawer();
                          _showTabview = false;
                          _bodyCustom = EventSondagesScreen(_userModel!,);
                        });
                      },
                      leading: Icon(
                        MdiIcons.fileTableBoxMultiple,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Mes sondages',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Notification', arguments: 0);
                      },
                      leading: Icon(
                        Icons.notifications,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Notification',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/MyEvent', arguments: 3);
                      },
                      leading: Icon(
                        Icons.local_mall,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Locl mall',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Favorites');
                      },
                      leading: Icon(
                        Icons.favorite,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        "Favoris",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        "Autres" ,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Icon(
                        Icons.remove,
                        color: Theme.of(context).focusColor.withOpacity(0.3),
                      ),
                    ),
                    ListTile(

                      onTap: () {
                        gotoDevenirAnnoncer();
                      },
                      leading: Icon(
                        Icons.work_sharp,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        (_userModel?.id_annoncers == null || _userModel?.id_annoncers == "")
                            ? 'Devenir annonceur'
                            : 'Modifier annonceur',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        // Navigator.of(context).pop();
                        signOut(context);
                      },
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Se déconnecter',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Help');
                      },
                      leading: Icon(
                        Icons.help,
                        color: Theme.of(context).focusColor.withOpacity(1),
                      ),
                      title: Text(
                        'Support',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        "Dikouba 1.0" ,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Icon(
                        Icons.remove,
                        color: Theme.of(context).focusColor.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              centerTitle: false,
              elevation: 0,
              backgroundColor: customAppTheme?.bgLayer1,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu_rounded),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              title: Text(
                "Dikouba",
                style: AppTheme.getTextStyle(
                    themeData!.textTheme.headline5!,
                    fontSize: 24,
                    fontWeight: 700,
                    letterSpacing: -0.3,
                    color: DikoubaColors.blue['pri']),
              ),
              actions: [
                Stack(alignment: Alignment.center,
                  children: [
                    Container(
                      padding: Spacing.all(10),
                      decoration: BoxDecoration(
                          color: customAppTheme?.bgLayer1,
                          borderRadius: BorderRadius.all(
                              Radius.circular(MySize.size8!)),
                          boxShadow: [
                            BoxShadow(
                                color: customAppTheme!.shadowColor,
                                blurRadius: MySize.size4!)
                          ]),
                      child: Icon(
                        MdiIcons.bell,
                        size: MySize.size18,
                        color: themeData?.colorScheme.onBackground
                            .withAlpha(160),
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: MySize.size22,
                      child: Container(
                        width: MySize.size6,
                        height: MySize.size6,
                        decoration: BoxDecoration(
                            color: customAppTheme?.colorError,
                            shape: BoxShape.circle),
                      ),
                    )
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        gotoUpdateUserprofile();
                      },
                      child: Container(
                        margin: Spacing.left(16),
                        decoration: BoxDecoration(
                            color: customAppTheme?.bgLayer1,
                            borderRadius: BorderRadius.all(
                                Radius.circular(MySize.size8!)),
                            boxShadow: [
                              BoxShadow(
                                  color: customAppTheme!.shadowColor,
                                  blurRadius: MySize.size4!)
                            ]),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(MySize.size8!)),
                          child: _userModel == null
                              ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(DikoubaColors.blue['pri']!))
                              : _userModel?.photo_url == ""
                              ? Image(
                            image: AssetImage('./assets/logo/user_transparent.webp'),
                            fit: BoxFit.cover,
                            width: MySize.size36,
                            height: MySize.size36,) : Image(
                            image: NetworkImage(_userModel!.photo_url),
                            fit: BoxFit.cover,
                            width: MySize.size36,
                            height: MySize.size36,),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(width: 12,)
              ],),
            body: _userModel == null
                ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(DikoubaColors.blue['pri']!))
                : Container(
                    child: _bodyCustom,),
          ),
        );
      },
    );
  }

  void gotoUpdateUserprofile() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileActivity(_userModel!,)));
  }

  void signOut(BuildContext buildContext) async {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("NON"),
      onPressed:  () {
        Navigator.of(context).pop("non");
      },
    );
    Widget continueButton = TextButton(
      child: Text("OUI"),
      onPressed:  () {
        Navigator.of(context).pop("oui");
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Déconnexion"),
      content: Text("Voulez-vous vraiment vous déconnecter ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    var resPrompt = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    print("$TAG:resPrompt=$resPrompt");
    if(resPrompt == null || resPrompt == "non") return;

    //await FirebaseAuthUi.instance().logout();
    await dbHelper.delete_user();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChoseLoginSignupActivity(),));
  }

  void gotoDevenirAnnoncer()async {
    var resAc= await Navigator.push(context, MaterialPageRoute(builder: (context) => EvenNewAnnoncerActivity(_userModel!,)));
    queryUser();
  }
}
