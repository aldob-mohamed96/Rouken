import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apps/ui/building_to_selling.dart';
import 'dart:async';
import 'package:flutter_apps/ui/login_and_register.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class display_item extends StatefulWidget {
  @override
  _display_itemState createState() => _display_itemState();
}

class _display_itemState extends State<display_item>
    with SingleTickerProviderStateMixin {
  int catergory = int.parse(show_details.category_id.toString());

  List<sub_catogray_item> sub_catogry_items_list1 = [];

  String function_catergoty(int cat) {
    print('cat : ' + cat.toString());
    if (cat == 4) {
      return 'عقارات للبيع';
    }
    if (cat == 3) {
      return 'عقارات للايجار';
    }
    if (cat == 2) {
      return 'عقارات للاستثمار';
    }
    if (cat == 1) {
      return 'سكن مشترك';
    }
  }

  String files_image(List item) {
    if (item.length >= 1) {
      return item[0].toString();
    } else {
      return null;
    }
  }

  String files_image2(List item) {
    if (item.length >= 2) {
      return item[1].toString();
    } else {
      return null;
    }
  }

  String files_image3(List item) {
    if (item.length >= 3) {
      return item[2].toString();
    } else {
      return null;
    }
  }

  String img, img1, img2, img3, main_image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sub_catgroy_items_future();

    main_image = show_details.image.toString();
    img = show_details.image.toString();
    img1 = files_image(show_details.files);
    img2 = files_image2(show_details.files);
    img3 = files_image3(show_details.files);
  }

  Future<List<sub_catogray_item>> _sub_catgroy_items_future() async {
    var data = await http
        .get('https://rouckn.com/api/v1/category/subcategory/$catergory')
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

    print('sub_catogry_items_list1 : ${sub_catogry_items_list1.toString()}');

    return sub_catogry_items_list1;
  }

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
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height >= 500.0
                        ? MediaQuery.of(context).size.height
                        : 750.0,
                    child: new Container(
                      child: new ListView(
                        children: <Widget>[
                          new Container(
                            height: MediaQuery.of(context).size.height / 2,
                            // قياس الصورة منا عدلته كانت 500 يكسلا
                            width: MediaQuery.of(context).size.width,
                            child: imageitem(main_image.toString()),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              /////////////////////////////////////////////////1111

                              show_details.files.length >= 1
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          var swap = main_image;
                                          main_image = img1;
                                          img1 = swap;
                                        });
                                      },
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              5,
                                          height: 70,
                                          child: imageitem(
                                            img1,
                                          )),
                                    )
                                  : Container(
                                      width: 0,
                                      height: 0,
                                    ),
                              ///////////////////////////////////////////2222222
                              show_details.files.length >= 2
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          var swap = main_image;
                                          main_image = img2;
                                          img2 = swap;
                                        });
                                      },
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              5,
                                          height: 70,
                                          child: imageitem(
                                            img2,
                                          )),
                                    )
                                  : Container(
                                      width: 0,
                                      height: 0,
                                    ),
                              /////////////////////////////////////////////////////////333333
                              show_details.files.length > 2
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          var swap = main_image;
                                          main_image = img3;
                                          img3 = swap;
                                        });
                                      },
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              5,
                                          height: 70,
                                          child: imageitem(
                                            img3,
                                          )),
                                    )
                                  : Container(
                                      width: 0,
                                      height: 0,
                                    ),
                            ],
                          ),
                          ///////////////////////////////////////////////////////4444444444
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: new Container(
                              padding: EdgeInsets.all(20),
                              child: new Row(
                                children: <Widget>[
                                  new Text(
                                    function_catergoty(catergory),
                                    style: TextStyle(
                                        fontFamily: 'DroidSansArabic',
                                        fontSize: 20,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          )

                              /////////////////////////////////////////////////////
                              ,
                          new Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                new Text(
                                  show_details.region.toString().isNotEmpty
                                      ? show_details.region.toString().length <
                                              6
                                          ? ' ${show_details.region.toString()} '
                                          : '${show_details.region.toString().substring(0, 6)} '
                                      : "",
                                  style: TextStyle(
                                      fontFamily: 'DroidSansArabic',
                                      fontSize: 15,
                                      color: Colors.grey),
                                ),
                                new Text(
                                  show_details.address.toString().isNotEmpty
                                      ? show_details.address.toString().length <
                                              6
                                          ? ' -${show_details.address.toString()} '
                                          : '-${show_details.address.toString().substring(0, 6)} '
                                      : "",
                                  style: TextStyle(
                                      fontFamily: 'DroidSansArabic',
                                      fontSize: 15,
                                      color: Colors.grey),
                                ),
                                new Text(
                                  show_details.region.toString().isNotEmpty
                                      ? show_details.region.toString().length <
                                              6
                                          ? ' -${show_details.region.toString()} '
                                          : '-${show_details.region.toString().substring(0, 6)} '
                                      : "",
                                  style: TextStyle(
                                      fontFamily: 'DroidSansArabic',
                                      fontSize: 15,
                                      color: Colors.grey),
                                ),
                                new Text(
                                  show_details.country.toString().isNotEmpty
                                      ? show_details.country.toString().length <
                                              6
                                          ? ' -${show_details.country.toString()} '
                                          : '-${show_details.country.toString().substring(0, 6)} '
                                      : "",
                                  style: TextStyle(
                                      fontFamily: 'DroidSansArabic',
                                      fontSize: 15,
                                      color: Colors.grey),
                                ),
                                InkWell(
                                  child: new Icon(
                                    Icons.location_on,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                  onTap: () {},
                                  splashColor: Colors.blue,
                                )
                              ],
                            ),
                          )
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                              ,
                          new Container(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 5),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                textofdetail(
                                  hint: show_details.rooms_number
                                          .toString()
                                          .isNotEmpty
                                      ? ' عدد غرف النوم:  ${show_details.rooms_number.toString()}'
                                      : "",
                                ),
                                new Padding(
                                  padding: EdgeInsets.only(left: 2, right: 2),
                                ),
                                textofdetail(
                                  hint: show_details.area.toString().isNotEmpty
                                      ? 'المساحه:  ${show_details.area.toString()}'
                                      : "",
                                )
                              ],
                            ),
                          ),
                          new Container(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 5),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                textofdetail(
                                  hint: show_details.rooms_number
                                          .toString()
                                          .isNotEmpty
                                      ? 'عدد حمامات  : ${show_details.rooms_number.toString()}'
                                      : "",
                                ),
                                new Padding(
                                  padding: EdgeInsets.only(left: 2, right: 2),
                                ),
                                textofdetail(
                                  hint: show_details.floors_number
                                          .toString()
                                          .isNotEmpty
                                      ? ' عدد الطوابق: ${show_details.floors_number.toString()}'
                                      : "",
                                )
                              ],
                            ),
                          ),
                          new Container(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 5),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                textofdetail(
                                  hint: show_details.has_parking
                                          .toString()
                                          .isNotEmpty
                                      ? 'الكراج  يتسع: ${show_details.has_parking.toString()}سياره  '
                                      : "",
                                ),
                                new Padding(
                                  padding: EdgeInsets.only(left: 2, right: 2),
                                ),
                                textofdetail(
                                  hint: show_details.price.toString().isNotEmpty
                                      ? 'السعر : ${show_details.price.toString()}'
                                      : "",
                                )
                              ],
                            ),
                          ),

                          new Container(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 5),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                textofdetail(
                                  hint: show_details.construction_year
                                          .toString()
                                          .isNotEmpty
                                      ? '${show_details.construction_year.toString()} : سنة التاسيس '
                                      : "",
                                ),
                              ],
                            ),
                          ),

                          new Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.all(20),
                              child: Column(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: new Text(
                                          ' ${show_details.title.toString()}',
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16,
                                              fontFamily: 'DroidSansArabic'))),
                                ],
                              )),
///////////////////////////////////////////////////////////
                          Padding(
                            padding: EdgeInsets.only(right: 15, left: 15),
                            child: Container(
                              alignment: Alignment.center,
                              width: 300,
                              height: 50.0,
                              decoration: new BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/img/img2.jpg'),
                                      repeat: ImageRepeat.noRepeat,
                                      fit: BoxFit.fill),
                                  border: new Border.all(
                                      color: Colors.blue, width: 1.0),
                                  borderRadius:
                                      new BorderRadius.circular(15.0)),
                              child: new FlatButton(
                                onPressed: () {
                                  print(show_details.phone.toString());
                                  if (userforall == null) {
                                    _neverSatisfied(
                                        'login to show details', context);
                                  } else if (userforall.phone
                                      .toString()
                                      .isNotEmpty) {
                                    print('weeee' +
                                        show_details.phone.toString());

                                    _neverSatisfied_connection(
                                        'phone  :' +
                                            show_details.phone.toString(),
                                        context);
                                  }
                                },
                                child: new Text('اظهار معلومات الاتصال',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'DroidSansArabic')),
                              ),
                            ),
                          ),
                          ////////////////////////////////////////////
                          new SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                    ///////////////////////////////////////////////////////////////////////////////////////////
                    )))
        /////////////////////////////////////////////////////////////////////////////
        );
  }

  Widget imageitem(String img1) {
    return new Container(
      child: new Card(
        child: new CachedNetworkImage(
          alignment: Alignment.center,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          repeat: ImageRepeat.noRepeat,
          imageUrl: img1,
          placeholder: (context, url) => new CircularProgressIndicator(),
          errorWidget: (context, url, error) => new Icon(Icons.question_answer),
        ),
      ),
    );
  }
}

Future<void> _neverSatisfied_connection(
    String phone, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('connection tools'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(phone),
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
            highlightColor: Colors.green,
            child: Text('copy'),
            onPressed: () {
              Clipboard.setData(
                  new ClipboardData(text: show_details.phone.toString()));
            },
          ),
          FlatButton(
            highlightColor: Colors.green,
            child: Text('call'),
            onPressed: () {
              launchURL(show_details.phone.toString());
            },
          ),
        ],
      );
    },
  );
}

launchURL(String t) async {
  var url = 'tel:+964${t.toString()}';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
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

class textofdetail extends StatelessWidget {
  final String hint;

  const textofdetail({
    this.hint,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        height: 50.0,
        width: MediaQuery.of(context).size.width / 2 - 25,
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border.all(color: Colors.grey, width: 1.0),
            borderRadius: new BorderRadius.circular(15.0)),
        child: new Text(hint,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
                fontFamily: 'DroidSansArabic')));
  }
}
