import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<GoogleSignInAccount> signin(BuildContext context) async {
  GoogleSignInAccount acc;
  var s = GoogleSignIn(scopes: ["email"]);
  try {
    acc = await s.signIn();
  } catch (e) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: SizedBox(
                //height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("An error aoccured: $e"),
                ),

              ),
            ));
  }
  return acc;
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        child: SizedBox(
            height: 60,
            child: SignInButton(
              Buttons.Google,
              onPressed: () async {
                GoogleSignInAccount acc = await signin(context);

                Navigator.of(context).pushReplacementNamed("home",
                    arguments: {"email": acc.email});
              },
            )),
      ),
    );
  }
}
