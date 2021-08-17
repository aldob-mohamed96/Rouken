import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_apps/ui/login_and_register.dart';
import 'package:path/path.dart';
import 'package:toast/toast.dart';

class update_profile extends StatefulWidget {
  
  
  @override
  _update_profileState createState() => new _update_profileState();
}

class _update_profileState extends State<update_profile> {
  File _image;
 static String _varString;
Future getImageGallery() async{
  var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

  


  setState(() {
      _image = imageFile;
    });
}


Dio dio = new Dio();

Future _update(BuildContext context) async {

FormData formdata = new FormData(); // just like JS
_image==null? "":formdata.add('image', UploadFileInfo(_image,basename(_image.path)));
 
formdata.add('password',password_controller_reg.text);
name_reg.text.toString().isEmpty?formdata.add('name',userforall.name.toString()):formdata.add('name',name_reg.text);
phone_controller_reg.text.toString().isEmpty?formdata.add('phone',userforall.phone.toString()):formdata.add('phone',phone_controller_reg.text);

formdata.add('password_confirmation',confirm_password_controller_reg.text);
dio.post('https://rouckn.com/api/v1/user/profile', data: formdata,
options: Options(
  headers: {
    'Auth':userforall.token.toString(),
    'Content-Type':'application/x-www-form-urlencoded',
  },
method: 'POST',
contentType: ContentType.parse('application/x-www-form-urlencoded',),



responseType: ResponseType.json
 // or ResponseType.JSON
))
.then((response) {
  var data=response.data;
  if(data['message'].toString()=='تم تحديث المعلومات بنجاح!')
  {
        Navigator.pushNamed(context,'/login');
  }
   
 
  
  
}).catchError((error){
 _neverSatisfied(error.toString(), context);
      
 
     
  
  
  
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
  
  TextEditingController phone_controller_reg=new TextEditingController();
  
  TextEditingController password_controller_reg=new TextEditingController();
  TextEditingController confirm_password_controller_reg=new TextEditingController();
  TextEditingController name_reg=new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
     _varString=userforall.phone.toString(); 
    });
  }
  @override

  Widget build(BuildContext context)
  
   {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50.0,
        child:CircleAvatar(
           backgroundColor: Colors.transparent,
        radius: 50.0,
                  child: _image==null?
          
          CachedNetworkImage(
                      
                    
                      fit: BoxFit.contain,
                      repeat: ImageRepeat.noRepeat,
                      imageUrl: userforall.avatar.toString(),
                      placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                      new Icon(Icons.error),
                    ):Image.file(_image),
        ),
      ),
    );
   
   final upload_image=new FlatButton(color: Colors.black26,child: new Center(child: Text('update image',style: TextStyle(color: Colors.white),),),onPressed: (){
     getImageGallery();
   },);
     final name = TextFormField(
      textAlign:TextAlign.center,
      controller: name_reg,
      keyboardType: TextInputType.text,
    

    
      decoration: InputDecoration(
        fillColor: Colors.redAccent,
        hintStyle: TextStyle(color: Colors.white),
        labelText: "الاسم",
        
        labelStyle: TextStyle(color: Colors.white,),
          hintText: userforall.name.toString(),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
    final password = TextFormField(
       
      textAlign:TextAlign.center,
      obscureText: true,
      controller: password_controller_reg,
      decoration: InputDecoration(
        
             hintStyle: TextStyle(color: Colors.white),
        labelText: 'الرقم السري',
        hintText: 'الرقم السري',
        labelStyle: TextStyle(color: Colors.white,),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
     final phone= TextFormField(
     
       textAlign:TextAlign.center,

      obscureText: false,
    
      controller: phone_controller_reg,
      decoration: InputDecoration(

        hintStyle: TextStyle(color: Colors.white,textBaseline: TextBaseline.alphabetic),
        labelText: 'رقم الهاتف',
        
        hintText: userforall.phone.toString(),
        labelStyle: TextStyle(color: Colors.white,),
        
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
    final confirm_password = TextFormField(
       textAlign:TextAlign.center,
        
      obscureText: true,
      controller: confirm_password_controller_reg,
      decoration: InputDecoration(
             hintStyle: TextStyle(color: Colors.white),
        labelText: 'تاكيد الرقم السري ',
        hintText: 'تاكيد الرقم السري ',
        labelStyle: TextStyle(color: Colors.white,),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
         
         if(confirm_password_controller_reg.text.toString()!=password_controller_reg.text.toString())
         {
           _neverSatisfied("password and confirm password not matched", context);
         }
         else{
             _update(context);
         }
          
        },
        padding: EdgeInsets.all(5),
        color: Colors.lightBlueAccent,
        child: Text('حفظ التعديلات', style: TextStyle(color: Colors.white,fontSize: 20.0)),
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
             
              SizedBox(height: 8.0),
              phone,
              SizedBox(height: 8.0),
              password,
               SizedBox(height: 8.0),
              confirm_password,
              SizedBox(height: 24.0),
              registerButton,
            
            
             
            ],
          ),
        ),
      ),
    );
  }
}