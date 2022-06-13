import 'package:covid/views/navBar/navbar.dart';
import 'package:covid/views/pages/auth/registerPage.dart';
import 'package:covid/views/pages/homePage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    checkAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/covid-19.png',
                  ),
                  scale: 0.1,
                  fit: BoxFit.cover,
                ),
                // borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(221, 45, 45, 45),
                    Color.fromARGB(255, 133, 135, 130)
                  ],
                ),
              ),
              // margin: EdgeInsets.all(32),
              padding: EdgeInsets.all(56),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildTextFieldEmail(),
                  buildTextFieldPassword(),
                  buildButtonSignIn(),
                  buildOtherLine(),
                  buildButtonRegister(),
                  buildButtonGoogle(context),
                ],
              )),
        ));
  }

  Widget buildButtonSignIn() {
    return InkWell(
      onTap: () {
        signIn();
      },
      child: Container(
        constraints: BoxConstraints.expand(height: 50),
        child: Text("เข้าสู่ระบบ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.green),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12),
      ),
    );
  }

  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: emailController,
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

  Widget buildOtherLine() {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Padding(
            padding: EdgeInsets.all(6),
            child: Text("Or",
                style: TextStyle(color: Colors.white, fontSize: 20))));
  }

  InkWell buildButtonRegister() {
    return InkWell(
      onTap: () {
        Get.to(RegisterPage());
      },
      child: Container(
          constraints: BoxConstraints.expand(height: 50),
          child: Text("สร้างบัญชีผู้ใช้",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.orange),
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(12)),
    );
  }

  Widget buildButtonGoogle(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("Login with Google ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.blue[600])),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.white),
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.all(12)),
        onTap: () => loginWithGoogle(context));
  }

  Future loginWithGoogle(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount? user = await _googleSignIn.signIn();
    GoogleSignInAuthentication? userAuth = await user!.authentication;

    await _auth.signInWithCredential(GoogleAuthProvider.credential(
        idToken: userAuth.idToken, accessToken: userAuth.accessToken));
    checkAuth(context);
    bool isSigned = false;
    isSigned = await _googleSignIn.isSignedIn();
    if (isSigned) {
      await _googleSignIn.signOut();
    } // after success route to home.
  }

  signIn() async {
    await _auth
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((user) {
      checkAuth(context);
    }).catchError((error) {
      print(error);
      scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: Text(error.message, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red));
    });
  }

  Future checkAuth(BuildContext context) async {
    User? user = await _auth.currentUser;
    if (user != null) {
      CircularProgressIndicator();
      print("Already singed-in with");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => navBar(user, 0)));
    }
  }
}
