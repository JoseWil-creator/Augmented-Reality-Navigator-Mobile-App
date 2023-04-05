import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  
  @override
  Widget build(BuildContext context){
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget> [
              Image.asset('./assets/images/Logo1.png', fit: BoxFit.contain, height: 5.h),
              TextButton(onPressed: (){}, child: Text("Hi, Will", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), )),
              SizedBox(width: 12.w,),
               ElevatedButton(onPressed: (){}, 
                
                style: ElevatedButton.styleFrom(shape: CircleBorder(), minimumSize: Size(35, 35)),
                child: Text("JG", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), ),
                
                  
              )
          ]
         ),
        //title: Image.asset('./assets/images/Logo1.png'),
        //title: Image.asset('./assets/images/team_logo.png'),
        actions: [],
        toolbarHeight: 7.h,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        
      ),
    ),
  );
  }
  @override
  Size get preferredSize => Size.fromHeight(60);
}