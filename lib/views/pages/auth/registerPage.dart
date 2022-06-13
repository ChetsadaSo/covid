import 'package:covid/views/NavBar/navbar.dart';
import 'package:covid/views/pages/auth/loginPage.dart';
import 'package:covid/views/pages/homePage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/covid-19.png',
                    ),
                    scale: 0.5,
                    fit: BoxFit.cover,
                  ),
                  // borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(221, 45, 45, 45),
                    Color.fromARGB(255, 133, 135, 130)
                  ])),
              // margin: EdgeInsets.all(32),
              padding: EdgeInsets.all(56),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildTextFieldEmail(),
                  buildTextFieldPassword(),
                  buildTextFieldPasswordConfirm(),
                  buildButtonSignUp(context),
                  SizedBox(
                    child: Container(
                      padding: EdgeInsets.only(top: 30),
                    ),
                  ),
                  buildButtonToSignIn(),
                ],
              )),
        ));
  }

  Widget buildButtonToSignIn() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
          constraints: BoxConstraints.expand(height: 50),
          child: Text("เป็นสมาชิกอยู่แล้ว",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.yellow[200]),
          margin: EdgeInsets.only(top: 36),
          padding: EdgeInsets.all(12)),
    );
  }

  Widget buildButtonSignUp(BuildContext context) {
    return InkWell(
        onTap: () {
          signUp();
        },
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("Sign up",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.green),
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(12)));
  }

  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration.collapsed(hintText: "Email"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Password"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldPasswordConfirm() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: confirmController,
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Re-password"),
            style: TextStyle(fontSize: 18)));
  }

  signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmController.text.trim();
    if (password == confirmPassword && password.length >= 6) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        print("Sign up user successful.");
        checkAuth(context);
      }).catchError((error) {
        print(error.message);
      });
    } else {
      print("Password and Confirm-password is not match.");
    }
  }

  Future checkAuth(BuildContext context) async {
    User? user = await _auth.currentUser;
    if (user != null) {
      print("Already singed-in with");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => navBar(user, 0)),
          ModalRoute.withName('/'));
    }
  }
}
