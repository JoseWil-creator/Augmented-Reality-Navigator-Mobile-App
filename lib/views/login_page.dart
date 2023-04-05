import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unitrail/main.dart';
import 'package:unitrail/views/Components/base_app_bar.dart';
import 'package:unitrail/views/Components/text_field.dart';
import 'package:unitrail/views/Widgets/my_button.dart';
import 'package:unitrail/views/Widgets/utils.dart';
import 'package:unitrail/views/home.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'Components/tile.dart';
import 'Widgets/back_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // hold the input email and password from register
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/Tiv.jpg'),
              fit: BoxFit.cover,
              //colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              opacity: 0.15
              //colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
              ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Textfield(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                icon: Icon(Icons.email)),
            Textfield(
              controller: passwordController,
              hintText: 'Enter Password',
              obscureText: true,
              icon: Icon(Icons.password),
            ),
            SizedBox(
              height: 10,
            ),
            MyButton(title: "login", color: Colors.white, 
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }));
            },)
            //     title: 'Login',
            //     color: Colors.white,
            //     onPressed: () async {
            //       try {
            //         await FirebaseAuth.instance
            //             .signInWithEmailAndPassword(
            //                 email: emailController.text,
            //                 password: passwordController.text)
            //             .then((value) {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) {
            //                 return MaterialApp(
            //                     home: HomeScreen());
            //               },
            //             ),
            //           );
            //         });
            //       } on FirebaseAuthException catch (e) {
            //         print(e);
            //         Utils().showSnackBar(e.message);
            //       }
            //       // ignore: use_build_context_synchronously
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) {
            //             return MaterialApp(
            //                 home:  HomeScreen());
            //           },
            //         ),
            //       );
            //     }),
          ],
        ),
      ),
    );
  }
}
