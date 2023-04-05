import 'package:flutter/material.dart';
import 'package:unitrail/views/home.dart';
import 'package:unitrail/views/login_page.dart';
import 'package:unitrail/views/sign_up_page.dart';
import 'package:unitrail/views/Widgets/my_button.dart';
import 'Components/tile.dart';
import 'package:unitrail/views/navigate.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox (
      
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Tiv.jpg'),
            fit: BoxFit.cover,
            opacity: 0.15
            //colorFilter: ColorFilter.mode(Colors.white, BlendMode.d)
            ),
      ),
        child: Column(
          children: [
            SizedBox(height: 300,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tile(imagePath: 'assets/images/Logo1.png'),
              ],
            ),
            SizedBox(height: 100),
            MyButton(
              title: 'Login',
              color: Colors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
            ),

            SizedBox(height: 20),
            MyButton(
              title: 'Guest',
              color: Colors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NavigateScreen();
                }));
              },
            ),
            SizedBox(height: 60),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)
              ),
              label: const Text("Don't have an account? Register!"),
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUpPage();
                  }));

              }, 
            
            ),
          ],
        ),
      )
    );
  }
}
