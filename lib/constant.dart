import 'package:flutter/material.dart';

double height(BuildContext context, double value) {
  return MediaQuery.of(context).size.height*value;
}

double width (BuildContext context,double value){
  return MediaQuery.of(context).size.width*value;
}