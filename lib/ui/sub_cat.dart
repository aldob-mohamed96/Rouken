import 'package:flutter/material.dart';
import 'package:flutter_apps/theme/theme.dart' as Themes;
import 'package:flutter_apps/ui/drawer.dart';
import 'package:flutter_apps/ui/Appbar.dart';
import 'package:flutter_apps/ui/building_to_selling.dart';
import 'package:flutter_apps/ui/home.dart';
import 'package:flutter_apps/ui/login_and_register.dart';
import 'package:toast/toast.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_apps/utils/user.dart';
import 'home.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userEmail = '';

class sub_cat extends StatefulWidget {
  @override
  _sub_catState createState() => _sub_catState();
}

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

class _sub_catState extends State<sub_cat> with SingleTickerProviderStateMixin {
  int post_id;
  String sub_categoy_id;
  bool fristload=true;
  List<bool> icon_fav_colors = [];
  List<building> buildinglist = [];
  List<building> buildinglist_onclicked = [];
  List<building> buildinglist_sub = [];
  String ispressed1 = null;
  List<sub_catogray_item> sub_catogry_items_list = [];
  List<sub_catogray_item> sub_catogry_items_list1 = [];



  Future<void> add_fav(String post_id) async {
    final respone = await http
        .post('https://rouckn.com/api/v1/user/favourites/create', headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Auth': userforall.token.toString()
    }, body: {
      'post_id': post_id
    }).catchError((error) {
      Toast.show(
        'Post Added in your liked Posts',
        this.context,
        duration: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    });

    var jsondata = json.decode(respone.body);

    if (jsondata['message'].toString() == 'favourite added successfully') {
      Toast.show(
        'favourite added successfully',
        this.context,
        duration: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  Future<void> delete_fav(String post_id) async {
    final respone = await http
        .post('https://rouckn.com/api/v1/user/favourites/delete', headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Auth': userforall.token.toString()
    }, body: {
      'post_id': post_id
    }).catchError((error) {
      Toast.show(
        'favourite post not cancled',
        this.context,
        duration: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    });
     (respone.toString());
    var jsondata = json.decode(respone.body);

    if (jsondata['message'].toString() == 'favourite deleted successfully') {
      Toast.show(
        'favourite added successfully',
        this.context,
        duration: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  Future<List<sub_catogray_item>> _sub_catgroy_items_future() async {


    var data = await http
        .get(
            'https://rouckn.com/api/v1/category/subcategory/$on_clicked_catogray_id')
        .catchError((onError) {
      new Text('no sub_catogray');
    });

    var jsondata = json.decode(data.body);

    sub_catogry_items_list1.clear();

    for (var u in jsondata['subcategories']) {
      sub_catogray_item sub = new sub_catogray_item(
        u['id'],
        u['category_id'].toString(),
        u['arabic_name'].toString(),
        u['english_name'].toString(),
      );

      sub_catogry_items_list1.add(sub);
    }

    return sub_catogry_items_list1;
  }

  String time = 'اقل من ساعه';

Future<List<building>> _getinfromation_sub(String sub_id) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  userEmail = prefs.getString('user_email');
  print('email: $userEmail');


  final response = await http
        .get('https://rouckn.com/api/v1/posts/subcategory/$sub_id');

    var datauser = json.decode(response.body);

    for (var u in datauser['posts']) {
     
      List<String> files = [];
      for (var u in u['files']) {
        files.add(u.toString());
      }

      int year = int.parse(u['created_at'].toString().substring(0, 4));
      int yearcurrnet = int.parse(DateTime.now().year.toString());
      int mounth = int.parse(u['created_at'].toString().substring(5, 7));
      int mounthcurrent = int.parse(DateTime.now().month.toString());
      int day = int.parse(u['created_at'].toString().substring(8, 10));
      int daycurrnet = int.parse(DateTime.now().day.toString());
      int hour = int.parse(u['created_at'].toString().substring(11, 13));
      int hourcurrent = int.parse(DateTime.now().hour.toString());
      if (year == yearcurrnet) {
        if (mounth == mounthcurrent) {
          if (day == daycurrnet) {
            if (hour == hourcurrent) {
              setState(() {
                time;
              });
            } else {
              setState(() {
                time = ' من ' +
                    (hourcurrent - hour < 0
                            ? (-1 * (hourcurrent - hour))
                            : (hourcurrent - hour))
                        .toString() +
                    ' ساعه ';
              });
            }
          } else {
            setState(() {
              time = ' من ' + (daycurrnet - day).toString() + ' يوم ';
            });
          }
        } else {
          setState(() {
            time = ' من ' + (mounthcurrent - mounth).toString() + ' شهر ';
          });
        }
      } else {
        setState(() {
          time = ' من ' + (yearcurrnet - year).toString() + ' سنه ';
        });
      }
         
      building b1 = new building(
          u['id'].toString(),
          u['title'].toString(),
          u['category_id'].toString(),
          u['subcategory_id'].toString(),
          u['user_id'].toString(),
          u['approved'].toString(),
          u['hash'].toString(),
          u['price'].toString(),
          u['country'].toString(),
          u['governorate'].toString(),
          u['region'].toString(),
          u['address'].toString(),
          u['area'].toString(),
          u['has_parking'].toString(),
          u['rooms_number'].toString(),
          u['floors_number'].toString(),
          u['construction_year'].toString(),
          u['lat_lng'].toString(),
          u['notes'].toString(),
          u['extra'].toString(),
          time,
          u['updated_at'].toString(),
          u['image'].toString(),
          files,
          u['phone'].toString(),
          u['user']['image'].toString(),
          u['user']['name'].toString(),
          u['favorite']
          );
        
 
      buildinglist_onclicked.add(b1);
    }

      
    return buildinglist_onclicked;
  }
  Future<List<building>> _getinfromation() async {
    final response = await http
        .get('https://rouckn.com/api/v1/posts/category/$on_clicked_catogray_id');

    var datauser = json.decode(response.body);

    for (var u in datauser['posts']) {
     
      List<String> files = [];
      for (var u in u['files']) {
        files.add(u.toString());
      }

      int year = int.parse(u['created_at'].toString().substring(0, 4));
      int yearcurrnet = int.parse(DateTime.now().year.toString());
      int mounth = int.parse(u['created_at'].toString().substring(5, 7));
      int mounthcurrent = int.parse(DateTime.now().month.toString());
      int day = int.parse(u['created_at'].toString().substring(8, 10));
      int daycurrnet = int.parse(DateTime.now().day.toString());
      int hour = int.parse(u['created_at'].toString().substring(11, 13));
      int hourcurrent = int.parse(DateTime.now().hour.toString());
      if (year == yearcurrnet) {
        if (mounth == mounthcurrent) {
          if (day == daycurrnet) {
            if (hour == hourcurrent) {
              setState(() {
                time;
              });
            } else {
              setState(() {
                time = ' من ' +
                    (hourcurrent - hour < 0
                            ? (-1 * (hourcurrent - hour))
                            : (hourcurrent - hour))
                        .toString() +
                    ' ساعه ';
              });
            }
          } else {
            setState(() {
              time = ' من ' + (daycurrnet - day).toString() + ' يوم ';
            });
          }
        } else {
          setState(() {
            time = ' من ' + (mounthcurrent - mounth).toString() + ' شهر ';
          });
        }
      } else {
        setState(() {
          time = ' من ' + (yearcurrnet - year).toString() + ' سنه ';
        });
      }
         
      building b1 = new building(
          u['id'].toString(),
          u['title'].toString(),
          u['category_id'].toString(),
          u['subcategory_id'].toString(),
          u['user_id'].toString(),
          u['approved'].toString(),
          u['hash'].toString(),
          u['price'].toString(),
          u['country'].toString(),
          u['governorate'].toString(),
          u['region'].toString(),
          u['address'].toString(),
          u['area'].toString(),
          u['has_parking'].toString(),
          u['rooms_number'].toString(),
          u['floors_number'].toString(),
          u['construction_year'].toString(),
          u['lat_lng'].toString(),
          u['notes'].toString(),
          u['extra'].toString(),
          time,
          u['updated_at'].toString(),
          u['image'].toString(),
          files,
          u['phone'].toString(),

         
      u['user']['image'].toString(),
      u['user']['name'].toString() ,
        u['favorite']
          
         
          );
        

      buildinglist.add(b1);
    }

    return buildinglist;
  }

  void initState() {
    super.initState();
    _sub_catgroy_items_future();
     _getinfromation();
      buildinglist_sub = buildinglist;
      //sub_catogry_items_list1.clear();
      sub_catogry_items_list.clear();
      sub_catogry_items_list=sub_catogry_items_list1;
      fristload=true;

      print('init state ...');
  }

  Widget type_sub_catergory(BuildContext context, AsyncSnapshot snapshot) {
    List<sub_catogray_item> values_cat = snapshot.data;
     
    return new Container(
      // color: Colors.blue,
      width: MediaQuery.of(context).size.width,

      padding: const EdgeInsets.only(left: 3.0, right: 3),

      child: values_cat.length > 0
          ? ListView.builder(
              addAutomaticKeepAlives: true,
              itemCount: values_cat.length,
              scrollDirection: Axis.horizontal,
              primary: true,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                  // color: Colors.blue,
                  width: 100,
                  height: 50,

                  padding: const EdgeInsets.all(1.0),
                  child: new InkWell(
                      onTap: () {
                        setState(() {
                          fristload=false;
                          ispressed1 =
                              sub_catogry_items_list[index].id.toString();
                          sub_categoy_id =
                              sub_catogry_items_list[index].id.toString();
                              buildinglist_onclicked.clear();
                            _getinfromation_sub(sub_categoy_id);
                        });

                      },
                      child: new Card(
                          color: ispressed1 ==
                                  sub_catogry_items_list[index].id.toString()
                              ? Themes.Colors.bulecolors
                              : Colors.white,
                          child: new Center(
                            child: new Text(
                              sub_catogry_items_list[index].arabic_name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ispressed1 ==
                                          sub_catogry_items_list[index]
                                              .id
                                              .toString()
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'DroidSansArabic'),
                            ),
                          ))),
                );
              },
            )
          : Center(
              child: new Align(alignment: Alignment.center,child: CircularProgressIndicator(),
            ),)
    );
  }

  Widget _buildItem1(int index) {
    return new Container(
      width: 340,

      // color: Colors.blue,
      padding: const EdgeInsets.all(1.0),
      child: new InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/display_item');
          setState(() {
            show_details = buildinglist_onclicked[index];
       
          });
        },
        child: new Card(
            child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              width: 340,
              decoration: BoxDecoration(
                  border: new Border.all(width: 1.0),
                  borderRadius: new BorderRadius.circular(4.0)),
              child: new CachedNetworkImage(
                height: 280,
                alignment: Alignment.center,
                fit: BoxFit.fill,
                repeat: ImageRepeat.noRepeat,
                imageUrl: buildinglist_onclicked[index].image,
                placeholder: (context, url) => new Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    new Icon(Icons.question_answer),
              ),
            ),
            new SizedBox(
              height: 16,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                  ),
                ),
                new Directionality(
                  textDirection: TextDirection.rtl,
                  child: new Text(buildinglist_onclicked[index].created_at,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: 'DroidSansArabic',
                          fontSize: 14,
                          color: Colors.grey)),
                ),
                Spacer(flex: 10 ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: new Text(buildinglist[index].name.toString(), textAlign: TextAlign.start,),
                ),
                Container(
                  child: new CircleAvatar(
                    backgroundImage:NetworkImage(buildinglist_onclicked[index].avatar.toString()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 2,
                    right: 2,
                  ),
                ),
              ],
            ),Padding(
              padding: EdgeInsets.only(left: 15,right: 10),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[
                
              new Align(
                alignment: Alignment.bottomLeft,
                child: new IconButton(
                  icon: Icon(Icons.favorite),
                  iconSize: 30,
                  color: icon_fav_colors?.elementAt(index) == false ? Colors.grey : Colors.pinkAccent,
                  onPressed: () {
                    if (userEmail != null || userEmail != '') {
                      if (icon_fav_colors[index] == false) {
                        print(icon_fav_colors[index]);

                        setState(() {
                          icon_fav_colors[index] = true;
                          add_fav(buildinglist_onclicked[index].id.toString());
                        });
                      } else {
                        setState(() {
                          print(icon_fav_colors[index]);

                          icon_fav_colors[index] = false;
                          delete_fav(buildinglist_onclicked[index].id.toString());
                        });
                      }
                    } else {
                      _neverSatisfied('login to add as liked post', context);
                    }
                  },
                ),
        
        ),
          new Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(10),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: new Text(
                    buildinglist_onclicked[index].title.toString().length>20? buildinglist_onclicked[index].title.toString().substring(0,15): buildinglist_sub[index].title.toString(),
                    style: TextStyle(
                      fontFamily: 'DroidSansArabic',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
                ],
              ),
            )
              
            

          ],
          
        )),
      ),
    );
  }



  Widget _buildItem(int index) {
    
    return new Container(
      width: 340,

      // color: Colors.blue,
      padding: const EdgeInsets.all(1.0),
      child: new InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/display_item');
          setState(() {
            show_details = buildinglist_sub[index];
       
          });
        },
        child: new Card(
            child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              width: 340,
              padding: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  border: new Border.all(width: 1.0),
                  borderRadius: new BorderRadius.circular(4.0)),
              child: new CachedNetworkImage(
                height: 280,
                alignment: Alignment.center,
                fit: BoxFit.fill,
                repeat: ImageRepeat.noRepeat,
                imageUrl: buildinglist_sub[index].image,
                placeholder: (context, url) => new Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    new Icon(Icons.question_answer),
              ),
            ),
            new SizedBox(
              height: 16,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 5
                  ),
                ),
                new Directionality(
                  textDirection: TextDirection.rtl,
                  child: new Text(buildinglist_sub[index].created_at,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: 'DroidSansArabic',
                          fontSize: 14,
                          color: Colors.grey)),
                ),
                Spacer(flex: 10,),
                Container(
                  margin: EdgeInsets.only(
                    left: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: new Text(
                          buildinglist[index].name.toString(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: new CircleAvatar(
                          backgroundImage:NetworkImage(buildinglist[index].avatar.toString()),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 2,
                    right: 2,
                  ),
                ),
              ],
            ),Padding(
              padding: EdgeInsets.only(left: 15,right: 10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[

                  new Align(
                    alignment: Alignment.bottomLeft,
                    child: new IconButton(
                      icon: Icon(Icons.favorite),
                      iconSize: 30,
                      color: icon_fav_colors?.elementAt(index) == false ? Colors.grey : Colors.pinkAccent,
                      onPressed: () {
                        if (userEmail != null || userEmail != '') {
                          if (icon_fav_colors[index] == false) {
                            setState(() {
                              icon_fav_colors[index] = true;
                              add_fav(buildinglist_sub[index].id.toString());
                            });
                          } else {
                            setState(() {
                              icon_fav_colors[index] = false;
                              delete_fav(buildinglist_sub[index].id.toString());
                            });
                          }
                        } else {
                          _neverSatisfied('login to add as liked post', context);
                        }
                      },
                    ),

                  ),
                  new Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(10),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: new Text(
                        buildinglist_sub[index].title.toString().length>20? buildinglist_sub[index].title.toString().substring(0,15): buildinglist_sub[index].title.toString(),
                        style: TextStyle(
                          fontFamily: 'DroidSansArabic',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )



          ],

            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    var futurbuilder = new FutureBuilder(
      future: _sub_catgroy_items_future(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          case ConnectionState.done:
          if (snapshot.hasError)
            return Text('no internet');
            return type_sub_catergory(context, snapshot);
        }
        return Align(
            alignment: Alignment.center, child: CircularProgressIndicator());
      },
    );
    return Scaffold(
        bottomNavigationBar: new BottomAppBar(
            clipBehavior: Clip.hardEdge,
            elevation: .1,
            notchMargin: 7.0,
            color: Colors.blueAccent,
            child: new Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: new MaterialButton(
                height: 65,
                color: Themes.Colors.bulecolors,
                textColor: Colors.white,
                onPressed: () =>
                    {Navigator.of(context).pushNamed('/add_building')},
                child: new Container(
                    child: new Text(
                  'أذا كنت ترغب بأضافة عقار اضغط هنا',
                  style: TextStyle(
                      fontFamily: 'DroidSansArabic',
                      fontSize: 15,
                      color: Colors.white),
                )),
                minWidth: MediaQuery.of(context).size.width,
              ),
            )), //                 onWillPop: () async => Navigator.of(context).pop(false),

        body: WillPopScope(
            onWillPop: () async => true,
            child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                },
                child: new Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    SingleChildScrollView(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Container(
                                    padding: EdgeInsets.only(
                                        top: 1, bottom: 1, left: 3, right: 3),
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        new SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          primary: false,
                                          reverse: true,
                                          child: new Container(
                                              width:
                                              MediaQuery.of(context).size.width,
                                              height: 60,
                                              child: new Container(
                                                // color: Colors.blue,
                                                  width: MediaQuery.of(context).size.width,

                                                  padding: const EdgeInsets.only(left: 3.0, right: 3),

                                                  child: sub_catogry_items_list.length > 0
                                                      ? ListView.builder(
                                                    addAutomaticKeepAlives: true,
                                                    itemCount: sub_catogry_items_list.length,
                                                    scrollDirection: Axis.horizontal,
                                                    primary: true,
                                                    reverse: true,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return new Container(
                                                        // color: Colors.blue,
                                                        width: 100,
                                                        height: 50,

                                                        padding: const EdgeInsets.all(1.0),
                                                        child: new InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                fristload=false;
                                                                ispressed1 =
                                                                    sub_catogry_items_list[index].id.toString();
                                                                sub_categoy_id =
                                                                    sub_catogry_items_list[index].id.toString();
                                                                buildinglist_onclicked.clear();
                                                                _getinfromation_sub(sub_categoy_id);


                                                              });

                                                            },
                                                            child: new Card(
                                                                color: ispressed1 ==
                                                                    sub_catogry_items_list[index].id.toString()
                                                                    ? Themes.Colors.bulecolors
                                                                    : Colors.white,
                                                                child: new Center(
                                                                  child: new Text(
                                                                    sub_catogry_items_list[index].arabic_name,
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                        color: ispressed1 ==
                                                                            sub_catogry_items_list[index]
                                                                                .id
                                                                                .toString()
                                                                            ? Colors.white
                                                                            : Colors.black,
                                                                        fontSize: 16,
                                                                        fontFamily: 'DroidSansArabic'),
                                                                  ),
                                                                ))),
                                                      );
                                                    },
                                                  )
                                                      : Center(
                                                    child: new Align(alignment: Alignment.center,child: CircularProgressIndicator(),
                                                    ),)
                                              )),
                                        ),
                                      ],
                                    )),

                                fristload==true?

                                Flexible(
                                    child: buildinglist_sub.length > 0
                                        ? new ListView.builder(

                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: buildinglist_sub.length,
                                        // itemExtent: 10.0,
                                        // reverse: true, //makes the list appear in descending order
                                        itemBuilder: (BuildContext context, int index) {
                                          print(buildinglist_sub.elementAt(index).favorite);

                                          icon_fav_colors.add(false);

                                          if (buildinglist_sub.elementAt(index).favorite == null || buildinglist_sub.elementAt(index).favorite == 0) {
                                            icon_fav_colors[index] = false;
                                          } else {
                                            icon_fav_colors[index] = true;
                                          }
                                          return _buildItem(index);

                                        })
                                        : Center(
                                      child: new Align(alignment: Alignment.center,child: CircularProgressIndicator(),
                                      ),)):Flexible(
                                    child: buildinglist_sub.length > 0
                                        ? new ListView.builder(

                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: buildinglist_onclicked.length,
                                        // itemExtent: 10.0,
                                        // reverse: true, //makes the list appear in descending order
                                        itemBuilder: (BuildContext context, int index) {
                                          print('from API : ' + buildinglist_sub.elementAt(index).favorite.toString());
                                          icon_fav_colors.add(false);


                                          if (buildinglist_sub.elementAt(index).favorite == null || buildinglist_sub.elementAt(index).favorite == 0) {
                                            icon_fav_colors[index] = false;
                                          } else {
                                            icon_fav_colors[index] = true;
                                          }
                                          return _buildItem1(index);
                                        })
                                        : Align(
                                        alignment: Alignment.center,
                                        child: Text('no reslut'))),


                                new SizedBox(height: 130,), ],

                            ))),
                  ],
                )
            )
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        appBar: new AppBar(
          title: TitleSub(
            title: name_cat_arabic,
          ),

          bottomOpacity: 0.0,
          elevation: 3.0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue,
        ),
        /////////////////////////////////////////////////////////////////////////////
        drawer: new Drawer(child: new Drawerpage()));
  }
}

class sub_catogray_item {
  final int id;
  final String arabic_name;
  final String english_name;

  final String category_id;

  sub_catogray_item(
      this.id, this.category_id, this.arabic_name, this.english_name);
}
