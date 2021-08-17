import 'package:flutter/material.dart';

import 'package:flutter_apps/ui/login_and_register.dart';
import 'package:flutter_apps/ui/home.dart';
import 'package:flutter_apps/utils/verfiy.dart';
import 'package:flutter_apps/ui/add_building.dart';
import 'package:flutter_apps/ui/page_of_adding.dart';
import 'package:flutter_apps/ui/search.dart';
import 'package:flutter_apps/ui/building_to_selling.dart';
import 'package:flutter_apps/ui/building_ready.dart';
import 'package:flutter_apps/ui/Building_rent.dart';
import 'package:flutter_apps/ui/building_investment.dart';
import 'package:flutter_apps/ui/display_item.dart';
import 'package:flutter_apps/ui/webview.dart';
import 'package:flutter_apps/ui/change_password.dart';
import 'package:flutter_apps/ui/about_app.dart';
import 'package:flutter_apps/ui/infromation_connect.dart';
import 'package:flutter_apps/ui/my_posts.dart';
import 'package:flutter_apps/ui/fav_posts.dart';
import 'package:flutter_apps/ui/contact_us.dart';
import 'package:flutter_apps/ui/sub_cat.dart'; 
import 'package:flutter_apps/ui/search_content.dart'; 
import 'package:flutter_apps/ui/update_profile.dart'; 


 


void main() => runApp(new MaterialApp(
  title: 'Rouckn',
  debugShowCheckedModeBanner: false,

 home: new home(),
 routes: <String,WidgetBuilder>{
       '/login':(BuildContext context)=>new LoginPage(),
        '/home':(BuildContext context)=>new home(),
        '/add_building':(BuildContext context)=>new add_building(),
        '/page_of_adding':(BuildContext context)=>new pageadding(),
         '/search':(BuildContext context)=>new search(),
         '/building_to_selling':(BuildContext context)=>new building_to_selling(),
          '/building_ready':(BuildContext context)=>new building_ready(),
          '/building_rent':(BuildContext context)=>new building_rent(),
          '/building_investment':(BuildContext context)=>new building_investment(),
        '/display_item':(BuildContext context)=>new display_item(),
        '/verfiy':(BuildContext context)=>new verfiy(),
         '/webview':(BuildContext context)=>new webview(),
         '/change_password':(BuildContext context)=>new change_password(),
         '/about_app':(BuildContext context)=>new about_app(),
          '/info_connect':(BuildContext context)=>new info_connect(),
           '/my_posts':(BuildContext context)=>new MyPosts(),
           '/fav_posts':(BuildContext context)=>new fav_posts(),
           '/contact_us':(BuildContext context)=>new contact_us(),
            '/sub_cat':(BuildContext context)=>new sub_cat(),
            '/search_content':(BuildContext context)=>new search_content(),
              '/RegisterPage':(BuildContext context)=>new RegisterPage(),
              '/update_profile':(BuildContext context)=>new update_profile(),
              
            
            
           

         
      },
));