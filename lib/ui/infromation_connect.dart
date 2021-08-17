import 'package:flutter/material.dart';
import 'package:flutter_apps/ui/Appbar.dart';
import 'package:flutter_apps/ui/login_and_register.dart';

class info_connect extends StatefulWidget {
  @override
  _info_connectState createState() => _info_connectState();
}



class _info_connectState extends State<info_connect> {
  TextEditingController info_connection=new TextEditingController();

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
     
        body: Padding(
          padding: EdgeInsets.all(40),
                  child: new Column(
            
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[ 
              
              
                        new Text(userforall==null?'name:login to show info':'name:'+userforall.name),
                        new Padding(padding: EdgeInsets.all(5)),
                        
                        new Text(userforall==null?'email:login to show info':'email'+userforall.email),
                        new Padding(padding: EdgeInsets.all(5)),
                        new Text(userforall==null?'phone:login to show info':'phone:'+userforall.phone),
                        new Padding(padding: EdgeInsets.all(5)),
                        
                        

                   

                ],
              
            ),
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        appBar: new AppBar(
          title: new Text('معلومات الاتصال'),
          centerTitle: true,
        ));
        /////////////////////////////////////////////////////////////////////////////
        
  }
}
