import 'package:flutter/material.dart';
import 'package:flutter_apps/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_apps/utils/user.dart';
import 'package:path/path.dart';
import 'package:toast/toast.dart';
import 'package:google_sign_in/google_sign_in.dart';


User userforall;
String id_verfiy;

class LoginPage extends StatefulWidget {
  
  
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 
 Future<User> _login_bygoogle(String access_token) async {
     
  final response = await http.post('https://rouckn.com/api/v1/google',headers: {

  },body: {
  'token':access_token.toString(),
  });

  var datauser = json.decode(response.body);
   
    


    
      
    User users=new User(datauser['user']['id'].toString(),datauser['user']['name'].toString(),datauser['user']['type'].toString(),
      datauser['user']['phone'].toString(),datauser['user']['email'].toString(),datauser['user']['image'].toString(),datauser['user']['email_verified_at'].toString(),
      datauser['user']['created_at'].toString(),datauser['user']['updated_at'].toString(),datauser['user']['token'].toString(),);
     
     setState(() {
      userforall=users;
     });
      Navigator.pushReplacementNamed(this.context,'/home');
     
     
     
   
     
  
  
  
  


  }


Future<void> acesstoken() async
  {
    GoogleSignIn _googleSignIn = new GoogleSignIn();
 

     try{ 
      await _googleSignIn.signIn().then((onValue){
        onValue.authentication.then((onValue){
         Toast.show(onValue.accessToken.toString(), this.context) ;
        _login_bygoogle(onValue.accessToken.toString());
      
         
         
      });
      });
     }
     catch(Error)
     {
       Toast.show(Error.toString(), this.context);
     }
    

  }

 
 Future<User> _login() async {
     
  final response = await http.post('https://rouckn.com/api/v1/login',body: {
  'email':email_controller.text,
  'password':password_controller.text,
  
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
   
    
      
    User users=new User(datauser['user']['id'].toString(),datauser['user']['name'].toString(),datauser['user']['type'].toString(),
      datauser['user']['phone'].toString(),datauser['user']['email'].toString(),datauser['user']['image'].toString(),datauser['user']['email_verified_at'].toString(),
      datauser['user']['created_at'].toString(),datauser['user']['updated_at'].toString(),datauser['user']['token'].toString(),);
     
     setState(() {
      userforall=users;
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

  TextEditingController email_controller=new TextEditingController();
  
  TextEditingController password_controller=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child:  Image.asset('assets/img/logo.png',color: Colors.white,height: 80,width: 80,),
      
    );

    final email = TextFormField(
      
      controller: email_controller,
      keyboardType: TextInputType.emailAddress,
     textAlign: TextAlign.center,

    
      decoration: InputDecoration(
        hintText: 'البريد الكتروني',
        
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),),
      ),
    );

    final password = TextFormField(
     
     textAlign: TextAlign.center,
      obscureText: true,
      
      controller: password_controller,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white),
        hintText: 'الرقم السري',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if(email_controller.text.toString().isEmpty)
          {
            _neverSatisfied('please enter the email', context);
          }
         else if(password_controller.text.toString().isEmpty)
          {
            _neverSatisfied('please enter the password', context);
          }
          else
          {
            _login();
          }
         

        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'DroidSansArabic',)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'DroidSansArabic',),
      ),
      onPressed: () {},
    );
    
    final google_sign = FlatButton(
      child: CircleAvatar(backgroundImage: AssetImage('assets/img/google-plus.png'),radius: 20,),
      onPressed: () {
        
      acesstoken();
      },
    );
    final registerLabel = FlatButton(
      child: Text(
        'Create Account !!',
        style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'DroidSansArabic',),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('/RegisterPage');
      
      },
    );
    return Scaffold(
      
      backgroundColor: Colors.blue,
      body: Container(
             decoration: BoxDecoration(
               image: DecorationImage(
                 alignment: Alignment.center,
                 fit: BoxFit.cover,
                 repeat: ImageRepeat.noRepeat,
                 image: AssetImage('assets/img/back.png'))
             ),
              child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              loginButton,
              SizedBox(height: 8.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text(
        'Login By',
        style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'DroidSansArabic',),
      ),  google_sign,],),
           
              SizedBox(height: 8.0),
              registerLabel,
              SizedBox(height: 8.0),
              
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  
  
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
formdata.add('email',email_controller_reg.text);
formdata.add('password',password_controller_reg.text);
formdata.add('name',name_reg.text);
formdata.add('phone',phone_controller_reg.text);

formdata.add('password_confirmation',confirm_password_controller_reg.text);
dio.post('https://rouckn.com/api/v1/register', data: formdata,
options: Options(
  
method: 'POST',
contentType: ContentType.parse('application/x-www-form-urlencoded',),



responseType: ResponseType.json
 // or ResponseType.JSON
))
.then((response) {
  var data=response.data;
   (response.toString().length);
  String messgae='we send verification code on your email please verify first';

  if(data['user']['id']!=null)
  {
    Toast.show('${data['user']['name'].toString()}'+'تم التسجيل بنجاح مرحبا ',context,duration: Toast.LENGTH_LONG,gravity: 2);
    Navigator.of(context).pushNamed('/home');
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

  TextEditingController email_controller_reg=new TextEditingController();
   TextEditingController phone_controller_reg=new TextEditingController();
  
  TextEditingController password_controller_reg=new TextEditingController();
  TextEditingController confirm_password_controller_reg=new TextEditingController();
  TextEditingController name_reg=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50.0,
        child:_image==null?Image.asset('assets/img/logo.png',color: Colors.white,):Image.file(_image),
      ),
    );
   final upload_image=new FlatButton(color: Colors.black26,child: new Center(child: Text('upload image',style: TextStyle(color: Colors.white),),),onPressed: (){
     getImageGallery();
   },);
   final registerLabel = FlatButton(
      child: Text(
        'تسجيل الدخول',
        
        style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'DroidSansArabic',),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('/login');
      
      },
    );
    final email = TextFormField(
      
      controller: email_controller_reg,
      keyboardType: TextInputType.emailAddress,
    
  textAlign:TextAlign.center,
    
      decoration: InputDecoration(
             hintStyle: TextStyle(color: Colors.white),
        hintText: 'البريد الكتروني',
        
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
     final name = TextFormField(
         textAlign:TextAlign.center,
      controller: name_reg,
      keyboardType: TextInputType.text,
    

    
      decoration: InputDecoration(
             hintStyle: TextStyle(color: Colors.white),
        hintText: 'الاسم',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = TextFormField(
     
       textAlign:TextAlign.center,
      obscureText: true,
      controller: password_controller_reg,
      decoration: InputDecoration(
             hintStyle: TextStyle(color: Colors.white),
        hintText: 'الرقم السري',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
     final phone= TextFormField(
     
       textAlign:TextAlign.center,
      obscureText: false,
      controller: phone_controller_reg,
      decoration: InputDecoration(
             hintStyle: TextStyle(color: Colors.white),
        hintText: 'رقم الهاتف',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final confirm_password = TextFormField(
       textAlign:TextAlign.center,
     
      obscureText: true,
      controller: confirm_password_controller_reg,
      decoration: InputDecoration(
             hintStyle: TextStyle(color: Colors.white),
        hintText: 'تاكيد الرقم السري ',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
           if(email_controller_reg.text.toString().isEmpty||password_controller_reg.text.toString().isEmpty
           ||confirm_password_controller_reg.text.toString().isEmpty||name_reg.text.toString().isEmpty)
          {
            _neverSatisfied('رجاء ادخل جميع البيانات', context);
          }
          else if(_image==null)
          {
            _neverSatisfied('رجاء يجب رفع الصوره الحساب', context);
          }
           else if(phone_controller_reg.text.toString().isEmpty)
          {
            _neverSatisfied('رجاء يجب رقم الهاتف', context);
          }
        else if(password_controller_reg.text.toString()!=confirm_password_controller_reg.text.toString())
          {
            
            _neverSatisfied('password and confirm password not match', context);
          }
         else if(password_controller_reg.text.toString().length<6)
          {
            
            _neverSatisfied('يجب ان يكون الرقم السري عدده اكبر من 6 ', context);
          }
          else
          {
            _register(context);
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('تسجيل ', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
             decoration: BoxDecoration(
               image: DecorationImage(
                 alignment: Alignment.center,
                 fit: BoxFit.cover,
                 repeat: ImageRepeat.noRepeat,
                 image: AssetImage('assets/img/back.png'))
             ),
              child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
               SizedBox(height: 40.0), 
              logo,
                SizedBox(height: 4.0), 
              upload_image,

              SizedBox(height: 38.0),
              name,
              SizedBox(height: 8.0), 
              email,
              SizedBox(height: 8.0),
              phone,
              SizedBox(height: 8.0),
              password,
               SizedBox(height: 8.0),
              confirm_password,
              SizedBox(height: 24.0),
              registerButton,
               SizedBox(height: 8.0),
               registerLabel,
            
             
            ],
          ),
        ),
      ),
    );
  }
}