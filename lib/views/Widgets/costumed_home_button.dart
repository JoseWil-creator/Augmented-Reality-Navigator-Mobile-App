import 'dart:ui';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final String picPath;
  final Color buttonColor;
  final void Function()? onPressed;

  CustomButton({required this.buttonTitle, required this.buttonColor, required this.onPressed, required this.picPath});

  @override
  Widget build(BuildContext context){
    return Stack(
      children: <Widget>[
         Container(
          // margin: const EdgeInsets.all(10.0),
          //     width: MediaQuery.of(context).size.width,
          //     height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Color(0x0FFFCF7F8),
           
            //borderRadius: BorderRadiusDirectional.circular(30),
            // image: DecorationImage(
            //     image: AssetImage(picPath),
            //     //fit: BoxFit.fill,
                
            //     ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                spreadRadius: 1,
                blurRadius: 15,
                offset: const Offset(5, 5)
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-5,-5),
                blurRadius: 15,
                spreadRadius: 1
              ) ,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 28, left: 21),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Image.asset(picPath,
            fit: BoxFit.fill,
            height: 21.h,
            width: 31.w,
            ),
          ),
        ),
       //Image.asset(picPath,),
         Padding(
           padding: const EdgeInsets.only(top: 200.0, left: 24),
           child: ElevatedButton(   
              onPressed: onPressed, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                fixedSize: Size(30.w, 5.h)
                ),
              child: Text(buttonTitle, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
              ),
         ),
      ]
    
    );
  }
}