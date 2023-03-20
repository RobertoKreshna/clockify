import 'package:clocklify/screen/create_account.dart';
import 'package:clocklify/utils/component.dart';
import 'package:flutter/material.dart';
import '../style/styles.dart';
import 'password_input.dart';

class LoginPage extends StatelessWidget {
  var _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 54, 123),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Spacer(),
            Container(
              child: Image.asset("assets/images/Logo.png"),
            ),
            Spacer(
              flex: 3,
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        icon: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        label: Text(
                          'E-mail',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    children: [
                      Component.blueButton("SIGN IN", () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PasswordInputPage(_emailController.text)));
                      })
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAccountPage()));
                      },
                      child: Text(
                        'Create new account?',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
