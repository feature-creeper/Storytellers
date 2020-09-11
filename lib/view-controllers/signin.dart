import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:storytellers/view-model/signin_view-model.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  _tappedEmail() {
    context.read<SigninViewModel>().tappedEmailLogin();
  }

  _tappedFacebook() {
    context.read<SigninViewModel>().tappedFacebookLogin();
  }

  _tappedGoogle() {
    context.read<SigninViewModel>().tappedGoogleLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          "assets/images/girl_reading1.png",
          fit: BoxFit.fitHeight,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  // color: Colors.blue,
                  child: SafeArea(
                      child: Column(
                    children: [
                      Spacer(),
                      Text("Storytellers",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Spacer(flex: 3)
                    ],
                  )),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                padding: EdgeInsets.all(15),
                //color: Colors.green,
                child: SafeArea(
                  top: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _LoginButton("Email login (Register)", _tappedEmail),
                      SizedBox(height: 15),
                      _LoginButton("Facebook login (Signin)", _tappedFacebook),
                      SizedBox(height: 15),
                      _LoginButton("Google login", _tappedGoogle),
                      SizedBox(height: 25),
                      Container(
                          child: Text("WELCOME", textAlign: TextAlign.center)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  const _LoginButton(this.title, this.callback);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(17),
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.grey[300], width: 2, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(40))),
      onPressed: callback,
      child: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      color: Colors.white,
    );
  }
}
