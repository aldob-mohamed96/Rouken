import 'package:flutter/material.dart';
import 'package:flutter_apps/ui/add_building.dart';

import 'package:flutter_apps/ui/RangeSliderSample2.dart';
import 'package:flutter_apps/ui/RangeSliderSample.dart';

import 'package:flutter_apps/utils/lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/utils/user.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_apps/ui/login_and_register.dart';
import 'package:http/http.dart' as http;

List<building> post_search_content = [];

Future<void> _neverSatisfied(String txt, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('search Alert'),
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

class search extends StatefulWidget {
  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> with SingleTickerProviderStateMixin {
  Future<List<building>> fetchPost() async {
    Dio dio = new Dio();

    String time = 'اقل من ساعه';
    var queryParamete = {
      'has_parking': controller_number_cars.text,
      'category_id': hintnumber_search1,
      'price_max': price_max.text,
      'price_min': price_min.text,
      'area_max': aera_max.text,
      'area_min': aera_min.text,
      'country': hintnumber_search3.toString(),
      'region': hintnumber_search2.toString(),
      'rooms_number': controller_number_room_sleeping.text,
      'floors_number': controller_number_level.text,
      'construction_year': hintnumber_search4.toString(),
    };
    Options op = new Options(headers: {
      'Auth': userforall.token.toString(),
      'ContentType': 'application/x-www-form-urlencoded',
    }, responseType: ResponseType.json);

    var response = await dio.get('https://rouckn.com/api/v1/posts/search',
        queryParameters: queryParamete, options: op);

    var datauser = response.data;

    for (var u in datauser['posts']) {
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
          u['favorite']);

      post_search_content.add(b1);
    }

    return post_search_content;
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////
  static const Color bulecolors = const Color(0xFF0f73ee);
  TextEditingController controller_number_room_sleeping =
      new TextEditingController();
  TextEditingController controller_number_room_wc = new TextEditingController();
  TextEditingController controller_number_level = new TextEditingController();
  TextEditingController controller_number_cars = new TextEditingController();
  TextEditingController controller_governet = new TextEditingController();
  TextEditingController controller_contory = new TextEditingController();
  TextEditingController price_max = new TextEditingController();
  TextEditingController price_min = new TextEditingController();
  TextEditingController aera_max = new TextEditingController();
  TextEditingController aera_min = new TextEditingController();

  String hintnumber1 = 'اختر نوع العقار';
  String hintnumber2 = 'محافظه';
  String hintnumber3 = 'العراق';
  String hintnumber4 = 'سنه التاسيس فما فوق';
  String hintnumber_search1 = '';
  String hintnumber_search2 = '';
  String hintnumber_search3 = '';
  String hintnumber_search4 = '';

  String lo, upp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        ////////////////////////////////////////////////////////////////////////////////////////////////
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: SingleChildScrollView(
                child: Container(
                    color: bulecolors,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height >= 1000.0
                        ? MediaQuery.of(context).size.height
                        : 900.0,
                    child: new Container(
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          Center(
                              child: new Container(
                            child: new IconButton(
                              onPressed: () => {Navigator.of(context).pop()},
                              icon: new Icon(Icons.close),
                              iconSize: 50,
                              color: Colors.black,
                            ),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: new Card_of_selling(
                            text: 'البحث',
                            color: Colors.white,
                          )),

                          //////////////////////////////////////////////////////////////////////
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              padding: const EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              height: 50.0,
                              width: MediaQuery.of(context).size.width - 20,
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border: new Border.all(
                                      color: Colors.white, width: 1.0),
                                  borderRadius:
                                      new BorderRadius.circular(15.0)),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Container(
                                      child: new DropdownButtonHideUnderline(
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: new DropdownButton<String>(
                                        items: new list()
                                            .typesearchbuilding
                                            .map((value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (v) {
                                          setState(() {
                                            if (v ==
                                                new list()
                                                    .typesearchbuilding
                                                    .elementAt(0)) {
                                              setState(() {
                                                hintnumber_search1 = '4';
                                                hintnumber1 = new list()
                                                    .typesearchbuilding[0];
                                              });
                                            }
                                            if (v ==
                                                new list()
                                                    .typesearchbuilding
                                                    .elementAt(1)) {
                                              setState(() {
                                                hintnumber_search1 = '3';
                                                hintnumber1 = new list()
                                                    .typesearchbuilding[1];
                                              });
                                            }
                                            if (v ==
                                                new list()
                                                    .typesearchbuilding
                                                    .elementAt(2)) {
                                              setState(() {
                                                hintnumber_search1 = '2';
                                                hintnumber1 = new list()
                                                    .typesearchbuilding[2];
                                              });
                                            }
                                            if (v ==
                                                new list()
                                                    .typesearchbuilding
                                                    .elementAt(3)) {
                                              setState(() {
                                                hintnumber_search1 = '1';
                                                hintnumber1 = new list()
                                                    .typesearchbuilding[3];
                                              });
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  )),
                                  new Container(
                                    child: new Text(hintnumber1,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                            fontFamily: 'DroidSansArabic')),
                                  )
                                ],
                              )),
//////////////////////////////////////////////////////////////////////////////////////////////////////
                          SizedBox(
                            height: 10,
                          ),

                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: new BoxDecoration(
                                    color: Colors.white,
                                    border: new Border.all(
                                        color: Colors.white, width: 1.0),
                                    borderRadius:
                                        new BorderRadius.circular(15.0)),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: new DropdownButtonHideUnderline(
                                          child: new DropdownButton<String>(
                                            items: new list().city.map((value) {
                                              return new DropdownMenuItem<
                                                  String>(
                                                value: value,
                                                child: new Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (v) {
                                              setState(() {
                                                hintnumber2 = v;
                                                hintnumber_search2 = v;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        child: new Text(hintnumber2,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 20,
                                                fontFamily:
                                                    "DroidSansArabic"))),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //////////////////////////////////////////////////////////////////////////////////////////////////////////////
                              new Padding(
                                  padding:
                                      EdgeInsets.only(right: 7.0, left: 7.0)),
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                alignment: Alignment.center,
                                height: 50.0,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: new BoxDecoration(
                                    color: Colors.white,
                                    border: new Border.all(
                                        color: Colors.white, width: 1.0),
                                    borderRadius:
                                        new BorderRadius.circular(15.0)),
                                child: new TextFormField(
                                  controller: controller_contory,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration.collapsed(
                                      hintText: hintnumber3,
                                      hintStyle: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'DroidSansArabic')),
                                ),
                              ),
                            ],
                          ),
                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: new Text('ادخل مساحه البحث',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'DroidSansArabic')),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.all(10.0),
                                  alignment: Alignment.center,
                                  height: 50.0,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: new Border.all(
                                          color: Colors.white, width: 1.0),
                                      borderRadius:
                                          new BorderRadius.circular(15.0)),
                                  child: new TextFormField(
                                    controller: aera_max,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.end,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration.collapsed(
                                        hintText: 'الي',
                                        hintStyle: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'DroidSansArabic')),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              //////////////////////////////////////////////////////////////////////////////////////////////////////////////
                              new Padding(
                                  padding:
                                      EdgeInsets.only(right: 7.0, left: 7.0)),
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                alignment: Alignment.center,
                                height: 50.0,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                decoration: new BoxDecoration(
                                    color: Colors.white,
                                    border: new Border.all(
                                        color: Colors.white, width: 1.0),
                                    borderRadius:
                                        new BorderRadius.circular(15.0)),
                                child: new TextFormField(
                                  controller: aera_min,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'من',
                                      hintStyle: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'DroidSansArabic')),
                                ),
                              ),
                            ],
                          ),

                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                          SizedBox(
                            height: 10,
                          ),

                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                          Container(
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            height: 50.0,
                            width: MediaQuery.of(context).size.width - 20,
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                border: new Border.all(
                                    color: Colors.white, width: 1.0),
                                borderRadius: new BorderRadius.circular(15.0)),
                            child: new TextFormField(
                              controller: controller_number_room_sleeping,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.end,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'ادخل عدد غرف النوم',
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'DroidSansArabic')),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                          Container(
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            height: 50.0,
                            width: MediaQuery.of(context).size.width - 20,
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                border: new Border.all(
                                    color: Colors.white, width: 1.0),
                                borderRadius: new BorderRadius.circular(15.0)),
                            child: new TextFormField(
                              controller: controller_number_room_wc,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.end,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'ادخل عدد غرف الحمامات',
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'DroidSansArabic')),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                          Container(
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            height: 50.0,
                            width: MediaQuery.of(context).size.width - 20,
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                border: new Border.all(
                                    color: Colors.white, width: 1.0),
                                borderRadius: new BorderRadius.circular(15.0)),
                            child: new TextFormField(
                              controller: controller_number_level,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.end,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'ادخل عدد غرف الطوابق',
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'DroidSansArabic')),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                          Container(
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            height: 50.0,
                            width: MediaQuery.of(context).size.width - 20,
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                border: new Border.all(
                                    color: Colors.white, width: 1.0),
                                borderRadius: new BorderRadius.circular(15.0)),
                            child: new TextFormField(
                              controller: controller_number_cars,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.end,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'ادخل عدد السيارات ف الكراج',
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'DroidSansArabic')),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: new Text('السعر',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'DroidSansArabic')),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.all(10.0),
                                  alignment: Alignment.center,
                                  height: 50.0,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: new Border.all(
                                          color: Colors.white, width: 1.0),
                                      borderRadius:
                                          new BorderRadius.circular(15.0)),
                                  child: new TextFormField(
                                    controller: price_max,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.end,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration.collapsed(
                                        hintText: 'الي',
                                        hintStyle: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'DroidSansArabic')),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              //////////////////////////////////////////////////////////////////////////////////////////////////////////////
                              new Padding(
                                  padding:
                                      EdgeInsets.only(right: 7.0, left: 7.0)),
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                alignment: Alignment.center,
                                height: 50.0,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                decoration: new BoxDecoration(
                                    color: Colors.white,
                                    border: new Border.all(
                                        color: Colors.white, width: 1.0),
                                    borderRadius:
                                        new BorderRadius.circular(15.0)),
                                child: new TextFormField(
                                  controller: price_min,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'من',
                                      hintStyle: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'DroidSansArabic')),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                          Container(
                              padding: const EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              height: 50.0,
                              width: MediaQuery.of(context).size.width - 20,
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border: new Border.all(
                                      color: Colors.white, width: 1.0),
                                  borderRadius:
                                      new BorderRadius.circular(15.0)),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Container(
                                      child: new DropdownButtonHideUnderline(
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: new DropdownButton<String>(
                                        items: new list().years.map((value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (v) {
                                          setState(() {
                                            hintnumber4 = v;
                                            hintnumber_search4 = v;
                                          });
                                        },
                                      ),
                                    ),
                                  )),
                                  new Container(
                                    child: new Text(hintnumber4,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                            fontFamily: 'DroidSansArabic')),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),

                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          ///
                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                          Container(
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            height: 50.0,
                            width: MediaQuery.of(context).size.width - 20,
                            decoration: new BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/img/img2.jpg'),
                                    repeat: ImageRepeat.noRepeat,
                                    fit: BoxFit.fill),
                                border: new Border.all(
                                    color: Colors.blue, width: 1.0),
                                borderRadius: new BorderRadius.circular(15.0)),
                            child: new FlatButton(
                              onPressed: () {
                                if (userforall == null) {
                                  _neverSatisfied(
                                      'login to able search', context);
                                } else {
                                  post_search_content.clear();
                                  fetchPost();
                                  Future.delayed(new Duration(seconds: 3), () {
                                    new CircularProgressIndicator();
                                    Navigator.pushNamed(
                                        context, '/search_content');
                                  });
                                }
                              },
                              child: new Text('بحث',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'DroidSansArabic')),
                            ),
                          ),

                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        ]))))));
  }
}
