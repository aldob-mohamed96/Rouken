import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_apps/theme/theme.dart' as Theme;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_apps/utils/bubble_indication_painter.dart';
import 'package:flutter_apps/utils/user.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

User userforall;
String id_verfiy;
class LoginPage extends StatefulWidget {
  
 
 

  @override
  _LoginPageState createState() => new _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
   
File _image;
Future getImageGallery() async{
  var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

  


  setState(() {
      _image = imageFile;
    });
}

Dio dio = new Dio();

Future _register(BuildContext context) async {

FormData formdata = new FormData(); // just like JS
formdata.add('avatar', new UploadFileInfo(_image,basename(_image.path)));
formdata.add('email',signupEmailController.text);
formdata.add('password',signupPasswordController.text);
formdata.add('name',signupNameController.text);
formdata.add('password_confirmation',signupConfirmPasswordController.text);
dio.post('https://rouckn.com/api/v1/register', data: formdata,
options: Options(
  
method: 'POST',
contentType: ContentType.parse('application/x-www-form-urlencoded',),



responseType: ResponseType.json
 // or ResponseType.JSON
))
.then((response) {
  var data=response.data;
  String messgae='we send verification code on your email please verify first';

  if(data['user']['id']!=null&&data['message'].toString()==messgae.toString())
  {
    setState(() {
     id_verfiy=data['user']['id'].toString();
      (id_verfiy.toString()); 
    });
    _neverSatisfied(id_verfiy+''+data['message'].toString(), context);
      Navigator.pushReplacementNamed(context,'/verfiy');
  }
  
}).catchError((error){
  
 
  if(error.response.data['errors'][0].toString()=='The email has already been taken.')
  {
    _neverSatisfied(error.response.data['errors'][0].toString(), context);
   
  }
  else
  {
     _neverSatisfied('error registerion opertion', context);
  }
  
  
});
 


 
  

}
    
 Future<User> _login() async {
     
  final response = await http.post('https://rouckn.com/api/v1/login',body: {
  'email':loginEmailController.text,
  'password':loginPasswordController.text,
  
  });

  var datauser = json.decode(response.body);
   (datauser.toString());

  
    if(datauser['message'].toString()=='we already send you verification code on your email please verify first')
    {
      _neverSatisfied('this not verfiy please verfiy first',this.context);
     setState(() {
      id_verfiy=datauser['user']['id'].toString();
      

     });
     Navigator.pushReplacementNamed(this.context,'/home');

    }


  
  if(datauser.length==1){
    if(datauser['message'].toString().length>=23)
    {
     _neverSatisfied('البرديد الكتروني خطا او الرقم السري',this.context);
    }
   
    else if(datauser['user'].toString().length>30){

      SharedPreferences prefs = await SharedPreferences.getInstance();

      User users=new User(datauser['user']['id'].toString(),datauser['user']['name'].toString(),datauser['user']['type'].toString(),
      datauser['user']['phone'].toString(),datauser['user']['email'].toString(),datauser['user']['image'].toString(),datauser['user']['email_verified_at'].toString(),
      datauser['user']['created_at'].toString(),datauser['user']['updated_at'].toString(),datauser['user']['token'].toString(),);
     
     setState(() {
      userforall=users;
      prefs.setString('user_email', users.email.toString());
     });
      Navigator.pushReplacementNamed(this.context,'/home');
     
     
     
    }
     else 
    {
      
      _neverSatisfied('الرقم السري خطا',this.context);
    }
     
  }
  
  
  


  }
  Future<void> _neverSatisfied(String txt,BuildContext context) async {
   return showDialog<void>(
      context: context ,
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
          ],
        );
      },
    );
  }
  bool leftright=false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

 final TextEditingController loginEmailController = new TextEditingController();
  final TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  PageController _pageController;
  
  Color left = Colors.black;
  Color right = Colors.white;
 Image h=Image.asset('assets/img/user.png');  
  @override
  Widget build(BuildContext context) 
  {
   

    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 600.0
                ? MediaQuery.of(context).size.height
                : leftright==false?840:850,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Theme.Colors.loginGradientStart,
                    Theme.Colors.loginGradientEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 75.0),
                  child:  Container(

                  padding: EdgeInsets.all(7),
                  child: _image==null? new Image.asset('assets/img/user.png'):Image.file(_image),
                  height: 120.0,
                   
                ),
                ),
                 new Padding(
                   
                   padding: EdgeInsets.only(right: 80.0,left: 80.0)
                 ,child:leftright==false?new Text(''): new FlatButton(
                   
                   color: Theme.Colors.bulecolors,onPressed: (){
                     getImageGallery();
                   },
                 child: new Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                   new Icon(Icons.camera_alt,color: Colors.white,),
                   new Padding(padding: EdgeInsets.only(right: 10),),
                   new Text('Upload image',style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'DroidSansArabic'),)
                 ],),
                 
                 )),
               
                Expanded(
                  flex: 2,
                  child:_buildSignIn(context)
                      
                   
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

 
  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: 'DroidSansArabic',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: 'البريد الالكتروني',
                            hintStyle: TextStyle(
                                fontFamily: 'DroidSansArabic', fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: 'DroidSansArabic',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: 'الرقم السري',
                            hintStyle: TextStyle(
                                fontFamily: 'DroidSansArabic', fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                FontAwesomeIcons.eye,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 170.0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Theme.Colors.loginGradientStart,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                      BoxShadow(
                        color: Theme.Colors.loginGradientEnd,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                    ],
                    gradient: new LinearGradient(
                        colors: [
                          Theme.Colors.loginGradientEnd,
                          Theme.Colors.loginGradientStart
                        ],
                        begin: const FractionalOffset(0.2, 0.2),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: MaterialButton(
                    onPressed: (){
                      if(loginEmailController.text==''||loginPasswordController.text=='')
                      {
                         _neverSatisfied('رجاء ادخل البريد الكتروني او الرقم السري',context);
                      }
                      else
                      {
                        _login();
                      }
                    
                   },
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        'تسجيل دخول',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: 'DroidSansArabic'),
                      ),
                    ),
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: (){
                  
                    },
                child: Text(
                  'هل نسيت الرقم السري؟؟',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'DroidSansArabic'),
                )),
          ),
        ],
      ),
    );
  }
  
  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }
    }