import 'package:flutter/material.dart';
import 'package:flutter_apps/theme/theme.dart' as Themes;

import 'package:flutter_apps/ui/drawer.dart';
import 'package:flutter_apps/ui/Appbar.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_apps/utils/user.dart';
import 'package:flutter_apps/ui/building_to_selling.dart';
import 'dart:convert';

class building_rent extends StatefulWidget {
  @override
  _building_rentState createState() => _building_rentState();
}

class _building_rentState extends State<building_rent>
    with SingleTickerProviderStateMixin {
  String time = 'اقل من ساعه';
  List<building> buildinglist = [];
  List<building> building_subcategory_id_1 = [];
  List<building> building_subcategory_id_2 = [];
  List<building> building_subcategory_id_3 = [];
  List<building> building_subcategory_id_4 = [];
  List<building> building_subcategory_id_5 = [];
  List<building> building_subcategory_id_6 = [];
  List<building> building_subcategory_id_7 = [];

  List<building> building_subcategory_id_8 = [];

  Future<List<building>> _getinfromation() async {
    final response = await http.get('https://rouckn.com/api/v1/category/2');

    var datauser = json.decode(response.body);

    for (var u in datauser['posts']['data']) {
       String avatar;
        String name;
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

                time = ' من ' + (hourcurrent-hour<0?(-1*(hourcurrent-hour)):(hourcurrent-hour)).toString() + ' ساعه ';
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

      int number_catergory = int.parse(u['subcategory_id'].toString());
       (u['subcategory_id'].toString());
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
          files,u['phone'].toString() ,       
      u['user']['avatar'].toString()
      ,
      u['user']['name'].toString() , 0);

      if (number_catergory == 1) {
        setState(() {
          building_subcategory_id_1.add(b1);
        });
      } else if (number_catergory == 2) {
        setState(() {
          building_subcategory_id_2.add(b1);
        });
      } else if (number_catergory == 3) {
        setState(() {
          building_subcategory_id_3.add(b1);
        });
      } else if (number_catergory == 4) {
        setState(() {
          building_subcategory_id_4.add(b1);
        });
      } else if (number_catergory == 5) {
        setState(() {
          building_subcategory_id_5.add(b1);
        });
      } else if (number_catergory == 6) {
        setState(() {
          building_subcategory_id_6.add(b1);
        });
      } else if (number_catergory == 7) {
        setState(() {
          building_subcategory_id_7.add(b1);
        });
      } else if (number_catergory == 8) {
        setState(() {
          building_subcategory_id_8.add(b1);
        });
      }
    }

    return building_subcategory_id_1;
  }

  void initState() {
    super.initState();
    _getinfromation();
    setState(() {
      buildinglist = building_subcategory_id_1;
      int ispressed = 1;
    });
  }

  int ispressed = 1;

  Widget _buildItem(int index) {
    return new Container(
      width: 340,

      // color: Colors.blue,
      padding: const EdgeInsets.all(1.0),
      child: new InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/display_item');
          setState(() {
           show_details=buildinglist[index]; 
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
                child: new Image.network(buildinglist[index].image)),
            new SizedBox(
              height: 8,
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
                  child: new Text(buildinglist[index].created_at,
                      style: TextStyle(
                          fontFamily: 'DroidSansArabic',
                          fontSize: 14,
                          color: Colors.grey)),
                ),
                new Padding(
                  padding: EdgeInsets.only(left: 5, right: 120),
                ),
                new Text('مصطفي هادي'),
                new CircleAvatar(
                  backgroundImage: AssetImage('assets/img/jobs.png'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 2,
                    right: 2,
                  ),
                ),
              ],
            ),
            new Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(30),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: new Text(buildinglist[index].title.toString(),
                  style: TextStyle(
                    fontFamily: 'DroidSansArabic',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  'ميوو',
                  style: TextStyle(
                      fontFamily: 'DroidSansArabic',
                      fontSize: 15,
                      color: Colors.white),
                )),
                minWidth: MediaQuery.of(context).size.width,
              ),
            )),
        body: NotificationListener<OverscrollIndicatorNotification>(
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
                        height: MediaQuery.of(context).size.height >= 600.0
                            ? MediaQuery.of(context).size.height
                            : 600.0,
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
                                            MediaQuery.of(context).size.width ,
                                        height: 60,
                                        child: new ListView(
                                          scrollDirection: Axis.horizontal,
                                          primary: false,
                                          
                                          reverse: true,
                                          children: <Widget>[
                                            /////////////////////////////////
                                            new Container(
                                              // color: Colors.blue,
                                              width: 100,
                                              height: 50,

                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: new InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      buildinglist =
                                                          building_subcategory_id_8;
                                                      ispressed = 8;
                                                    });
                                                  },
                                                  child: new Card(
                                                      color: ispressed == 8
                                                          ? Themes
                                                              .Colors.bulecolors
                                                          : Colors.white,
                                                      child: new Center(
                                                        child: new Text(
                                                          'بنايه ',
                                                          style: TextStyle(
                                                              color: ispressed ==
                                                                      8
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  'DroidSansArabic'),
                                                        ),
                                                      ))),
                                            ),

                                            ///

                                            ///

                                            ///
                                            new Container(
                                              // color: Colors.blue,
                                              width: 100,
                                              height: 50,

                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: new InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      buildinglist =
                                                          building_subcategory_id_7;
                                                      ispressed = 7;
                                                    });
                                                  },
                                                  child: new Card(
                                                      color: ispressed == 7
                                                          ? Themes
                                                              .Colors.bulecolors
                                                          : Colors.white,
                                                      child: new Center(
                                                        child: new Text(
                                                          'محل',
                                                          style: TextStyle(
                                                              color: ispressed ==
                                                                      7
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  'DroidSansArabic'),
                                                        ),
                                                      ))),
                                            ),

                                            ///
                                            new Container(
                                              // color: Colors.blue,
                                              width: 100,
                                              height: 50,

                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: new InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      buildinglist =
                                                          building_subcategory_id_6;
                                                      ispressed = 6;
                                                    });
                                                  },
                                                  child: new Card(
                                                      color: ispressed == 6
                                                          ? Themes
                                                              .Colors.bulecolors
                                                          : Colors.white,
                                                      child: new Center(
                                                        child: new Text(
                                                          'مخازن',
                                                          style: TextStyle(
                                                              color: ispressed ==
                                                                      6
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  'DroidSansArabic'),
                                                        ),
                                                      ))),
                                            ),

                                            ///
                                            new Container(
                                              // color: Colors.blue,
                                              width: 100,
                                              height: 50,

                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: new InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      ispressed = 5;
                                                      buildinglist =
                                                          building_subcategory_id_5;
                                                    });
                                                  },
                                                  child: new Card(
                                                      color: ispressed == 5
                                                          ? Themes
                                                              .Colors.bulecolors
                                                          : Colors.white,
                                                      child: new Center(
                                                        child: new Text(
                                                          'ارض',
                                                          style: TextStyle(
                                                              color: ispressed ==
                                                                      5
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  'DroidSansArabic'),
                                                        ),
                                                      ))),
                                            ),

                                            ///
                                            ///
                                            new Container(
                                              // color: Colors.blue,
                                              width: 100,
                                              height: 50,

                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: new InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      ispressed = 4;
                                                      buildinglist =
                                                          building_subcategory_id_4;
                                                    });
                                                  },
                                                  child: new Card(
                                                      color: ispressed == 4
                                                          ? Themes
                                                              .Colors.bulecolors
                                                          : Colors.white,
                                                      child: new Center(
                                                        child: new Text(
                                                          'معمل',
                                                          style: TextStyle(
                                                              color: ispressed ==
                                                                      4
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  'DroidSansArabic'),
                                                        ),
                                                      ))),
                                            ),

                                            ///
                                            /////////////////////////////////

                                            ///

                                            new Container(
                                              // color: Colors.blue,
                                              width: 100,
                                              height: 50,

                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: new InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      ispressed = 3;
                                                      buildinglist =
                                                          building_subcategory_id_3;
                                                    });
                                                  },
                                                  child: new Card(
                                                      color: ispressed == 3
                                                          ? Themes
                                                              .Colors.bulecolors
                                                          : Colors.white,
                                                      child: new Center(
                                                        child: new Text(
                                                          'بيت',
                                                          style: TextStyle(
                                                              color: ispressed ==
                                                                      3
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  'DroidSansArabic'),
                                                        ),
                                                      ))),
                                            ),

                                            new Container(
                                              // color: Colors.blue,
                                              width: 100,
                                              height: 50,

                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: new InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      ispressed = 2;
                                                      buildinglist =
                                                          building_subcategory_id_2;
                                                    });
                                                  },
                                                  child: new Card(
                                                      color: ispressed == 2
                                                          ? Themes
                                                              .Colors.bulecolors
                                                          : Colors.white,
                                                      child: new Center(
                                                        child: new Text(
                                                          'شقه',
                                                          style: TextStyle(
                                                              color: ispressed ==
                                                                      2
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  'DroidSansArabic'),
                                                        ),
                                                      ))),
                                            ),
                                            new Container(
                                              // color: Colors.blue,
                                              width: 100,
                                              height: 50,

                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: new InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      ispressed = 1;
                                                      buildinglist =
                                                          building_subcategory_id_1;
                                                    });
                                                  },
                                                  child: new Card(
                                                      color: ispressed == 1
                                                          ? Themes
                                                              .Colors.bulecolors
                                                          : Colors.white,
                                                      child: new Center(
                                                        child: new Text(
                                                          'مشمل',
                                                          style: TextStyle(
                                                              color: ispressed ==
                                                                      1
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  'DroidSansArabic'),
                                                        ),
                                                      ))),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Flexible(
                              child: new ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: buildinglist.length,
                                  // itemExtent: 10.0,
                                  // reverse: true, //makes the list appear in descending order
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _buildItem(index);
                                  }),
                            ),
                          ],
                        ))),
              ],
            )),
        ///////////////////////////////////////////////////////////////////////////////////////////
         appBar: new AppBar(
          title: title5(),
          
          bottomOpacity: 0.0,
          elevation: 0.0,
          iconTheme: IconThemeData(color:Colors.white 
          ),
          backgroundColor: Colors.blue,
        ),
        /////////////////////////////////////////////////////////////////////////////
        drawer: new Drawer(child: new Drawerpage()));
  }
}
