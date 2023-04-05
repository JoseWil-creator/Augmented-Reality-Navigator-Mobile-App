
import 'package:flutter/material.dart';

class Tile extends StatelessWidget{
  final String imagePath;
  const Tile({
    super.key,
    required this.imagePath  
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
       // color: Colors.white
      ),
      height: 65,
      child: Image.asset(imagePath),
    );
    // TODO: implement build
    //throw UnimplementedError();
  }
}