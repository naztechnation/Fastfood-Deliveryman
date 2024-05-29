

import 'dart:async';
import 'package:flutter/material.dart';
 
enum MessageType { success, error, progress }


class Modals {
   

 

  static Future<bool?> showAlertOptionDialog(context,
      {required String title,
      required String message,
      required Function onTap,
      String buttonYesText = 'Yes',
      String buttonNoText = 'No'}) async {
    final data = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), 
                  ),
            title: Column(
              children: [
                Text(title,
                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600), ),
                const SizedBox(height: 10,),
                Divider()
              ],
            ),
            content: Text(message),
            actions: [
              TextButton(
                child: Text(buttonNoText,  style: TextStyle( fontWeight: FontWeight.w600, color: Colors.red),),
                onPressed: () => Navigator.pop(context, false),
              ),
              TextButton(
                child: Text(buttonYesText, style: TextStyle( fontWeight: FontWeight.w600, color: Colors.black),),
                onPressed: (){
                  onTap();
                  Navigator.pop(context, false);
                },
              )
            ],
          );
        });
    return data;
  }

  static Future<dynamic> showBottomSheetModal(BuildContext context,
      {required Widget page,
      double? heightFactor = 0.5,
        bool isDissmissible = false,

      bool isScrollControlled = false,
      double borderRadius = 20.0}) async {
    final data = await showModalBottomSheet<dynamic>(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadius))),
        backgroundColor: Colors.white,
        isDismissible: isDissmissible,
        useSafeArea: true,

        isScrollControlled: isScrollControlled,
        builder: (BuildContext bc) {
          return FractionallySizedBox(heightFactor: heightFactor, child: page);
        });
    return data;
  }

  static Future<dynamic> showDialogModal(BuildContext context,
      {required Widget page, double borderRadius = 20.0}) async {
    final data = await showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(borderRadius)), //this right here
              child: page);
        });
    return data;
  }
}