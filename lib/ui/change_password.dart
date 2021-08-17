import 'package:flutter/material.dart';
import 'package:flutter_apps/ui/Appbar.dart';
import 'package:flutter_apps/ui/drawer.dart';


class change_password extends StatefulWidget {
  @override
  _change_passwordState createState() => _change_passwordState();
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
      width:MediaQuery.of(context).size.width-20 ,
      decoration: new BoxDecoration(
          
          color: Colors.cyan,
          border: new Border.all(color: Colors.black, width: 1.0),
          borderRadius: new BorderRadius.circular(15.0)),
           child: new TextFormField(
             controller: tc,
             textDirection: TextDirection.rtl, 
             textAlign:TextAlign.center ,
             
             
        decoration: InputDecoration.collapsed(hintText: hint,hintStyle: TextStyle(fontSize: 20,fontFamily: 'DroidSansArabic',color: Colors.white)),
      ),
    );
  }
}

class _change_passwordState extends State<change_password> {
  TextEditingController old_pass=new TextEditingController();
  TextEditingController new_pass=new TextEditingController();
  TextEditingController confirm_new_pass=new TextEditingController();

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
     
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[ 
            
            
                      new textfiled(hint: 'ادخل كلمه السر الحاليه',tc: old_pass,),
                      new Padding(padding: EdgeInsets.all(15)),
                     new textfiled(hint: 'ادخل كلمه السر الجديده',tc: new_pass,),
                     new Padding(padding: EdgeInsets.all(15)),
                     new textfiled(hint: 'تاكيد كلمه السر الجديده',tc:confirm_new_pass),
                     new Padding(padding: EdgeInsets.all(15)),
                     button_change()

              ],
            
          ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        appBar: new AppBar(
          title: new Text('تغيير كلمه السر'),
          centerTitle: true,
        ));
        /////////////////////////////////////////////////////////////////////////////
        
  }
}
class button_change extends StatelessWidget {



  const button_change({


    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      height: 50.0,


      width:MediaQuery.of(context).size.width-20 ,
      decoration: new BoxDecoration(

          image: DecorationImage(image: AssetImage('assets/img/img3.jpg'),repeat: ImageRepeat.noRepeat,fit: BoxFit.fill),
          border: new Border.all(color: Colors.blue, width: 1.0),
          borderRadius: new BorderRadius.circular(15.0)),
      child: new FlatButton(
        onPressed: (){
        
        },

        child: new Text('تغيير كلمه السر',style:TextStyle(color:Colors.white,fontSize: 25,fontFamily: 'DroidSansArabic')),


      ),
    );
  }
}
