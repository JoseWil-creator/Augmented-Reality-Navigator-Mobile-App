import 'package:flutter/material.dart';
import 'package:unitrail/views/Components/text_field.dart';
import 'package:unitrail/views/Widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unitrail/views/login_page.dart';
import 'Components/text_field_email.dart';
import 'Components/text_field_password.dart';
import 'Components/tile.dart';
import 'Widgets/utils.dart';
import 'Widgets/back_button.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void saveInformation() {
    print(firstNameController.text);
    print(lastNameController.text);
    print(passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Tiv.jpg'),
            fit: BoxFit.cover,
            opacity: 0.15
            //colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
            ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          
        children: [
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 8),
              MyBackButton(),
              SizedBox(width: 50),
              Tile(imagePath: 'assets/images/Logo1.png'),
              ],
            ),
            SizedBox(height: 100,),
            Textfield(
                controller: firstNameController,
                hintText: 'First Name',
                obscureText: false,
                icon: Icon(Icons.person)),
            //Divider(height: 2),
            Textfield(
                controller: lastNameController,
                hintText: 'Last Name',
                obscureText: false,
                icon: Icon(Icons.person)),
            //Divider(height: 2),
            TextfieldEmail(
                controller: emailController,
                hintText: 'Enter email',
                obscureText: false,
                icon: Icon(Icons.email)),
            TextfieldPassword(
              controller: passwordController,
              hintText: 'Enter Password',
              obscureText: true,
              icon: Icon(Icons.password),
            ),
            SizedBox(height: 10,),
          MyButton(
                title: 'Sign Up',
                color: Colors.white,
                onPressed: () async {
                  final isValid = formKey.currentState!.validate();
                  if (!isValid) return;
                  try {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) {
                      FirebaseFirestore.instance
                          .collection('Users')
                          .doc(value.user?.uid)
                          .set({
                        "email": value.user?.email,
                        "firstName": firstNameController.text,
                        "lastName": lastNameController.text,
                        "studentID": "",
                        "classes": {},
                        "navigations": {},
                      });
                    });
                  } on FirebaseAuthException catch (e) {
                    print(e);

                    Utils().showSnackBar(e.message);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                  );
                })
          ],
        ),
      ),
      ));
  }
}
