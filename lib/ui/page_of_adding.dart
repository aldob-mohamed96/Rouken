import 'package:flutter/material.dart';
import 'package:flutter_apps/ui/add_building.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:flutter_apps/ui/login_and_register.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter_apps/utils/lists.dart';
import 'package:flutter_apps/ui/add_building.dart';

import 'package:flutter_apps/ui/progressbar.dart';

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

String reslut = '';

Future<void> _neverSatisfied_image(String txt, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
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
        ],
      );
    },
  );
}

class pageadding extends StatefulWidget {
  @override
  _pageaddingState createState() => _pageaddingState();
}

class sub_catogray_item_id {
  final int id;
  final String arabic_name;
  final String english_name;

  final String category_id;

  sub_catogray_item_id(
      this.id, this.category_id, this.arabic_name, this.english_name);
}

class _pageaddingState extends State<pageadding>
    with SingleTickerProviderStateMixin {
  bool colors_changed = false;
  String hintnumber1 = 'نوع العقار';
  String hintnumber2 = 'محافظه';
  String hintnumber3 = 'العراق';
  String hintnumber4 = 'سنه التأسيس ';
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();
  TextEditingController t3 = new TextEditingController();
  TextEditingController t4 = new TextEditingController();

  TextEditingController t5 = new TextEditingController();
  TextEditingController t6 = new TextEditingController();
  TextEditingController t7 = new TextEditingController();
  TextEditingController t8 = new TextEditingController();
  TextEditingController t9 = new TextEditingController();
  TextEditingController controller_governet = new TextEditingController();
  TextEditingController controller_contory = new TextEditingController();
  List<sub_catogray_item_id> sub_catogry_items_list = [];
  List<String> items = [];
  bool asd = false;
  bool yearsChanged = false, typeCategoryChanged = false, cityChanged = false;

  Future<List<sub_catogray_item_id>> _sub_catgroy_items_future() async {
    var data = await http
        .get('https://rouckn.com/api/v1/category/subcategory/$typeofadd')
        .catchError((onError) {
      new Text('no sub_catogray');
    });

    var jsondata = json.decode(data.body);
    sub_catogry_items_list.clear();
    for (var u in jsondata['subcategories']) {
      sub_catogray_item_id sub = new sub_catogray_item_id(
        u['id'],
        u['category_id'].toString(),
        u['arabic_name'].toString(),
        u['english_name'].toString(),
      );

      items.add(u['arabic_name'].toString());
      sub_catogry_items_list.add(sub);
    }

    return sub_catogry_items_list;
  }

  int return_id_item(String item) {
    for (int i = 0; i < sub_catogry_items_list.length; i++) {
      if (item.toString() == sub_catogry_items_list[i].arabic_name.toString()) {
        return sub_catogry_items_list[i].id;
      }
    }
  }

  Dio dio = new Dio();

  Future<void> _create_post() async {
    int zero = 0;
    int years = 2019;
    String title = 'nothing to show';

    FormData formdata = new FormData(); // just like JS
    formdata.add('category_id', typeofadd.toString());
    formdata.add('subcategory_id', return_id_item(hintnumber1.toString()));
    formdata.add(
        'title', t8.text.toString().isEmpty ? 'not added' : t8.text.toString());

    formdata.add('area',
        t2.text.toString().isEmpty ? zero.toString() : t2.text.toString());
    formdata.add('price',
        t7.text.toString().isEmpty ? zero.toString() : t7.text.toString());

    formdata.add('address',
        t1.text.toString().isEmpty ? 'not added' : t1.text.toString());

    formdata.add('country', hintnumber3.toString());
    formdata.add(
        'governorate',
        controller_governet.text.toString().isEmpty
            ? 'not added'
            : controller_governet.text.toString());
    formdata.add('region',
        t9.text.toString().isEmpty ? 'not added' : t9.text.toString());
    formdata.add('rooms_number',
        t3.text.toString().isEmpty ? zero.toString() : t3.text.toString());
    formdata.add('floors_number',
        t5.text.toString().isEmpty ? zero.toString() : t5.text.toString());
    formdata.add('construction_year', hintnumber4.toString());
    formdata.add('has_parking',
        t6.text.toString().isEmpty ? zero.toString() : t6.text.toString());

    formdata.add('image', new UploadFileInfo(_image1, basename(_image1.path)));

    formdata.add('files[]', [
      new UploadFileInfo(_image2, basename(_image2.path)),
      new UploadFileInfo(_image3, basename(_image3.path)),
      new UploadFileInfo(_image4, basename(_image4.path)),
    ]);

    dio
        .post('https://rouckn.com/api/v1/posts/create',
            data: formdata,
            options: Options(
                headers: {
                  'ContentType': 'application/x-www-form-urlencoded',
                  'Auth': userforall.token.toString(),
                },
                contentType:
                    ContentType.parse('application/x-www-form-urlencoded'),
                method: 'post',
                receiveDataWhenStatusError: true,
                responseType: ResponseType.json

                // or ResponseType.JSON
                ))
        .then((Response response) {
      var data = response.data;

      setState(() {
        reslut = data['message'].toString();
      });
      Toast.show(reslut, this.context);
    }).catchError((onError) {
      setState(() {
        reslut = onError.toString();
        Toast.show(reslut, this.context);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      items;
      yearsChanged = false;
      typeCategoryChanged = false;
      cityChanged = false;
      _sub_catgroy_items_future();
    });
  }

  // color: Colors.blue,

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
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            repeat: ImageRepeat.noRepeat,
                            image: AssetImage(imageback))),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height >= 500.0
                        ? MediaQuery.of(context).size.height
                        : 1390.0,
                    child: new Container(
                        child: new ListView(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            scrollDirection: Axis.vertical,
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
                            text: titlepbar,
                            color: Colors.white,
                          )),
                          //////////////////////////////////////////////////////////////////////////////////////
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
                                      child: new DropdownButtonHideUnderline(
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
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
                                                cityChanged = true;
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

                              //////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new textfiled(
                            hint: 'العنوان',
                            tc: t1,
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          new textfiled_num(
                            hint: 'ادخل مساحه العقار',
                            tc: t2,
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          new textfiled(
                            hint: 'ملصق ل اعلان',
                            tc: t8,
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          ///////////////////////////////////////////////////////////////////

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
                                        items: items.map((value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (v) {
                                          setState(() {
                                            hintnumber1 = v;
                                            typeCategoryChanged = true;
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

                          SizedBox(
                            height: 10,
                          ),
                          new textfiled(
                            hint: 'منطقه',
                            tc: t9,
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          new textfiled_num(hint: 'ادخل عدد غرف النوم', tc: t3),
                          SizedBox(
                            height: 10,
                          ),
                          new textfiled_num(
                              hint: 'ادخل عدد غرف الحمامات', tc: t4),
                          SizedBox(
                            height: 10,
                          ),
                          new textfiled_num(
                              hint: 'ادخل عدد غرف الطوابق', tc: t5),
                          SizedBox(
                            height: 10,
                          ),
                          new textfiled_num(
                              hint: 'ادخل عدد السيارات ف الكراج', tc: t6),
                          SizedBox(
                            height: 10,
                          ),
                          new textfiled_num(
                            hint: 'السعر',
                            tc: t7,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ////////////////////////////////////////////////////

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
                                            yearsChanged = true;
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

                          /////////////////////////////////////////////////////////

                          fourimage(
                              '(اضافه الصور لعقار (صوره رئيسيه وثلاثه فرعيين'),

                          SizedBox(
                            height: 10,
                          ),

                          Container(
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            height: 50.0,
                            width: MediaQuery.of(context).size.width - 20,
                            decoration: new BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/img/img3.jpg'),
                                    repeat: ImageRepeat.noRepeat,
                                    fit: BoxFit.fill),
                                border: new Border.all(
                                    color: Colors.blue, width: 1.0),
                                borderRadius: new BorderRadius.circular(15.0)),
                            child: new FlatButton(
                              child: new Text(
                                  asd == false
                                      ? 'اضافه عقار'
                                      : '.... جار التحميل ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'DroidSansArabic')),
                              onPressed: () {
                                setState(() {
                                  asd = true;
                                });
                                if (userforall == null) {
                                  _neverSatisfied(
                                      'login to add items', context);
                                } else if (_image1 == null ||
                                    _image2 == null ||
                                    _image4 == null ||
                                    _image3 == null) {
                                  _neverSatisfied_image(
                                      'please add Main image and three image ',
                                      context);
                                } else {
                                  if (hintnumber1.toString() == 'نوع العقار') {
                                    _neverSatisfied_image(
                                        '  يجب اضافه ونوع العقار', context);
                                  } else if (hintnumber4.toString() ==
                                      'سنه التاسيس') {
                                    _neverSatisfied_image(
                                        '  يجب اضافه سنه التاسيس  ', context);
                                  } else if (t7.text.isEmpty) {
                                    _neverSatisfied_image(
                                        '   يجب اضافه  السعر   ', context);
                                  } else if (hintnumber3.toString() !=
                                      'العراق') {
                                    _neverSatisfied_image(
                                        '   يجب اضافه  الدوله   ', context);
                                  } else if (cityChanged == false) {
                                    _neverSatisfied_image(
                                        '   يجب اضافه  المحافظه   ', context);
                                  } else if (t2.text.isEmpty) {
                                    _neverSatisfied_image(
                                        '   يجب اضافه  المساحه   ', context);
                                  } else {
                                    setState(() {
                                      asd = true;
                                    });
                                    _create_post();

                                    Future.delayed(Duration(seconds: 3), () {
                                      setState(() {
                                        asd = false;
                                      });
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ]))))));
  }
}

File _image1, _image2, _image3, _image4;

class fourimage extends StatefulWidget {
  String hint;

  fourimage(String hint) {
    this.hint = hint;
  }

  @override
  _fourimageState createState() => _fourimageState(hint);
}

class _fourimageState extends State<fourimage> {
  Widget _buildItems(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width / 4 - 5,
      height: 60,
      padding: const EdgeInsets.all(1.0),
      child: new InkWell(
        onTap: () => getImage1(),
        child: new Card(
            child: _image1 == null
                ? new Image.asset('assets/img/up_main.png')
                : Image.file(_image1)),
      ),
    );
  }

  ////////////////////////
  Widget _buildItems2(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width / 4 - 5,
      height: 60,
      padding: const EdgeInsets.all(1.0),
      child: new InkWell(
        onTap: () => getImage2(),
        child: new Card(
            child: _image2 == null
                ? new Image.asset('assets/img/up_sub.png')
                : Image.file(_image2)),
      ),
    );
  }

///////////////////////////////////////////
  Widget _buildItems3(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width / 4 - 5,
      height: 60,
      padding: const EdgeInsets.all(1.0),
      child: new InkWell(
        onTap: () => getImage3(),
        child: new Card(
            child: _image3 == null
                ? new Image.asset('assets/img/up_sub.png')
                : Image.file(_image3)),
      ),
    );
  }

  /////////////////////////////////////
  Widget _buildItems4(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width / 4 - 5,
      height: 60,
      padding: const EdgeInsets.all(1.0),
      child: new InkWell(
        onTap: () => getImage4(),
        child: new Card(
            child: _image4 == null
                ? new Image.asset('assets/img/up_sub.png')
                : Image.file(_image4)),
      ),
    );
  }

  Future getImage1() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image1 = image;
    });
  }

  Future getImage2() async {
    var image2 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image2 = image2;
    });
  }

  Future getImage3() async {
    var image3 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image3 = image3;
    });
  }

  Future getImage4() async {
    var image4 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image4 = image4;
    });
  }

  String hint;

  _fourimageState(String hint) {
    this.hint = hint;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        height: 130.0,
        width: MediaQuery.of(context).size.width,
        child: new Stack(
          alignment: Alignment.topCenter,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            new Positioned(
              right: 2,
              child: new Text(widget.hint,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'DroidSansArabic')),
            ),
            Positioned(
              bottom: 10,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildItems4(context),
                  _buildItems3(context),
                  _buildItems2(context),
                  _buildItems(context),
                ],
              ),
            ),
          ],
        ));
  }
}

class textfiled extends StatelessWidget {
  final String hint;
  final String asd;
  final TextEditingController tc;

  const textfiled({
    this.asd,
    this.tc,
    this.hint,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      height: 50.0,
      width: MediaQuery.of(context).size.width - 20,
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Colors.white, width: 1.0),
          borderRadius: new BorderRadius.circular(15.0)),
      child: new TextField(
        controller: tc,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.end,
        decoration: InputDecoration.collapsed(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 20, fontFamily: 'DroidSansArabic')),
      ),
    );
  }
}

class textfiled_num extends StatelessWidget {
  final String hint;
  final String asd;
  final TextEditingController tc;

  const textfiled_num({
    this.asd,
    this.tc,
    this.hint,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      height: 50.0,
      width: MediaQuery.of(context).size.width - 20,
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Colors.white, width: 1.0),
          borderRadius: new BorderRadius.circular(15.0)),
      child: new TextField(
        controller: tc,
        keyboardType: TextInputType.number,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.end,
        decoration: InputDecoration.collapsed(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 20, fontFamily: 'DroidSansArabic')),
      ),
    );
  }
}
