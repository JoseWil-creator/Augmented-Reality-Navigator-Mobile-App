import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.005),
      child: IconButton(
        //padding: EdgeInsets.all(5),
        alignment: Alignment.topLeft,
        tooltip: 'Go back',
        color: Color(0xFFA31621), 
        onPressed: (){ Navigator.of(context).pop();},
        icon: Icon(Icons.arrow_back_ios_sharp),
        iconSize: 25,
        
        
      ),
    );


    }
  
}
