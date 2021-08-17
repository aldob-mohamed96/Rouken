import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_apps/ui/login_and_register.dart';
import 'package:flutter_apps/ui/login_and_register.dart';

class verfiy extends StatefulWidget {
  @override
  _verfiyState createState() => _verfiyState();
}

class _verfiyState extends State<verfiy> {
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
  TextEditingController code=TextEditingController();
   Future<void> _resend() async {
    
  final response = await http.post('http://104.200.24.140/api/v1/email/resend', body: {
  'user_id':id_verfiy.toString(),
  
 
  });
   var datauserverify=json.decode(response.body);
  print(datauserverify.toString());
 if(datauserverify['message'].toString()=='we send verification code on your email please verify first')
    {
     _neverSatisfied('we send verification code on your email please verify first',this.context);
   
    }
   else if(datauserverify['message'].toString()=='email already verified you can login now!')
    {
     _neverSatisfied('email already verified you can login now!',this.context);
      Navigator.of(context).pushNamed('/login'); 
   
    }
    
   else if(datauserverify['error'].toString()!=null)
    {
     _neverSatisfied('this email not registered',this.context);
   
    }
    
  
  else  {
     _neverSatisfied('try again in ',this.context);
   
    }
   }

 
   Future<void> _verify() async {
   
  final response = await http.post('http://104.200.24.140/api/v1/email/verify',
   body: {
  'user_id':id_verfiy.toString(),
  'code':code.text
 
  });
   var datauserverify=json.decode(response.body);
   print(datauserverify);

    if(datauserverify['message'].toString()=='Email Has been Verified, thanks!')
    {
     _neverSatisfied('Email Has been Verified, thanks!',this.context);
      Navigator.pushReplacementNamed(context, '/login');
    }
    else if(datauserverify['message'].toString()=='no verification not found in our database')
   {
      _neverSatisfied('no verification not found in our database',this.context);
   }
    else if(datauserverify['message'].toString()=='invalid verification code, try again!')
   {
      _neverSatisfied('invalid verification code, try again!',this.context);
   }
   else 
   {
      _neverSatisfied('error in verification'+response.statusCode.toString(),this.context);
   }
   

   
   }
  TextEditingController verfiy=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: new AppBar(title: new Text('verfiy'),),
      body:new Center(child:
        new Container(
          child: new Column(
            children: <Widget>[

        Container(
          
          margin: const EdgeInsets.all(22),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,

      height: 50.0,
      width:200 ,
      decoration: new BoxDecoration(
        
          
          color: Colors.blueAccent,
          border: new Border.all(color: Colors.white, width: 1.0),
          borderRadius: new BorderRadius.circular(15.0)),
           child: new TextField(
             controller: code,
             textDirection: TextDirection.rtl, 
             textAlign:TextAlign.end ,
             
             
        decoration: InputDecoration.collapsed(
          
          hintText: 'enter verfiy code ',
        hintStyle: TextStyle(fontSize: 20,fontFamily: 'DroidSansArabic')),
      ),
    ),
              new Padding(padding: EdgeInsets.all(10)),
           MaterialButton(
                    onPressed: (){
                    _verify();
                    
                   },
                   color: Colors.blueAccent,
                    highlightColor: Colors.transparent,
                    splashColor:Colors.blueAccent,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        ' ارسال الكود',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontFamily: 'DroidSansArabic'),
                      ),
                    ),
                  ),
                   new Padding(padding: EdgeInsets.all(10)),
           MaterialButton(
                    onPressed: (){
                    
                    _resend();
                   },
                   color: Colors.blueAccent,
                    highlightColor: Colors.transparent,
                    splashColor:Colors.blueAccent,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        'اعاده ارسال الكود ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontFamily: 'DroidSansArabic'),
                      ),
                    ),
                  ),
            ],
          ),
        )
      ),     
    );
  }

}
