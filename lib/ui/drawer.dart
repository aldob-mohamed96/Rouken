import 'package:flutter/material.dart';
import 'package:flutter_apps/theme/theme.dart' as Themes;
import 'package:flutter_apps/ui/Appbar.dart';
import 'package:flutter_apps/ui/login_and_register.dart';
import 'package:flutter_apps/ui/update_profile.dart';

import 'package:flutter_apps/ui/webview.dart';

Future<void> _neverSatisfied(String txt, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Login Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(txt),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('login'),
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
          ),
        ],
      );
    },
  );
}

class Drawerpage extends StatefulWidget {
  final Widget child;

  Drawerpage({Key key, this.child}) : super(key: key);

  _DrawerpageState createState() => _DrawerpageState();
}

class _DrawerpageState extends State<Drawerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Themes.Colors.bulecolors, Themes.Colors.bulecolors],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: new ListView(
          children: <Widget>[
            new Container(
              height: 150.0,
              child: new DrawerHeader(
                  padding: new EdgeInsets.all(0.0),
                  decoration:
                      new BoxDecoration(color: Themes.Colors.bulecolors),
                  child: new Center(
                      child: new Container(
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.only(right: 10.0),
                        ),
                        drawerimages(),
                        new Padding(
                          padding: EdgeInsets.only(right: 10.0),
                        ),
                        drawerimage(),
                      ],
                    ),
                  ))),
            ),
            new Container(
              height: MediaQuery.of(context).size.height / 2 + 9,
              alignment: Alignment.bottomCenter,
              color: Themes.Colors.bulecolors,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new ListTile(
                      contentPadding: EdgeInsets.only(left: 140),
                      title: new Text(
                        'عن التطبيق',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'DroidSansArabic'),
                      ),
                      onTap: () {
                        // Navigator.pop(context);
                        Navigator.of(context).pushNamed('/about_app');
                      }),
                  new ListTile(
                      contentPadding: EdgeInsets.only(left: 150),
                      title: new Text(
                        'منشوراتي',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'DroidSansArabic'),
                      ),
                      onTap: () {
                        //    Navigator.pop(context);
                        if (userforall != null)
                          Navigator.of(context).pushNamed('/my_posts');
                        else {
                          _neverSatisfied('login to show your Posts', context);
                        }
                      }),
                  new ListTile(
                      contentPadding: EdgeInsets.only(left: 153),
                      title: new Text(
                        'المفضلات',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'DroidSansArabic'),
                      ),
                      onTap: () {
                        //    Navigator.pop(context);
                        if (userforall != null)
                          Navigator.of(context).pushNamed('/fav_posts');
                        else {
                          _neverSatisfied(
                              'login to show your your liked  Posts', context);
                        }
                      }),
                  new ListTile(
                      contentPadding: EdgeInsets.only(left: 94),
                      title: new Text(
                        'معلومات الاتصال',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'DroidSansArabic'),
                      ),
                      onTap: () {
                        //    Navigator.pop(context);
                        Navigator.of(context).pushNamed('/info_connect');
                      }),
                  new ListTile(
                      contentPadding: EdgeInsets.only(left: 140),
                      title: new Text(
                        '  الاتصال بنا ',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'DroidSansArabic'),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/contact_us');
                      }),
                  new ListTile(
                      contentPadding: EdgeInsets.only(left: 120),
                      title: new Text(
                        'تعديل بياناتي',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'DroidSansArabic'),
                      ),
                      onTap: () {
                        //    Navigator.pop(context);
                        if (userforall != null)
                          Navigator.of(context).pushNamed('/update_profile');
                        else {
                          _neverSatisfied(
                              'login to update your profile', context);
                        }
                      }),
                ],
              ),
            )
                ////////////////////////////////

                ,
            new Container(
              height: MediaQuery.of(context).size.height / 5,
              alignment: Alignment.bottomCenter,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new IconButton(
                    onPressed: () {
                      setState(() {
                        urlwebview = "https://www.facebook.com/rouken";
                      });
                      Navigator.of(context).pushNamed('/webview');
                    },
                    color: Colors.white,
                    icon: new Image.asset(
                      'assets/img/face.png',
                      color: Colors.white,
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  new IconButton(
                    onPressed: () {
                      setState(() {
                        urlwebview = "https://www.instagram.com/rouckn/";
                      });
                      Navigator.of(context).pushNamed('/webview');
                    },
                    color: Colors.white,
                    icon: new Image.asset('assets/img/instagram.png',
                        color: Colors.white),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  new IconButton(
                    onPressed: () {
                      setState(() {
                        urlwebview = "https://twitter.com/roukn2?lang=en";
                      });
                      Navigator.of(context).pushNamed('/webview');
                    },
                    color: Colors.white,
                    icon: new Image.asset('assets/img/twitter.png',
                        color: Colors.white),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(5),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
