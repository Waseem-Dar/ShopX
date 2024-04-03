import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constant{
  
  // static Color pink =  const Color.fromARGB(170,243, 124, 151 );
  static Color pink =  const Color.fromARGB(199, 161, 0, 117);

  static showToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


  static void showProgressBar(BuildContext context,Color color){
    showDialog(context: context, builder: (_)=> Center(child: CircularProgressIndicator(color: color,),));
  }

}


