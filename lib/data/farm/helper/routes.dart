import 'package:flutter/material.dart';
import 'package:farmassist/ui/farm/news/news_home.dart';
import 'package:farmassist/ui/farm/news_details/newsDetailPage.dart';

class Routes{
  static Map<String,WidgetBuilder> getRoute(){
    return  <String, WidgetBuilder>{
      '/home': (_) => HomePage(),
      '/detail': (_) => NewsDetailPage(),
    };
  }
}