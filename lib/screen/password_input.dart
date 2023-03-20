import 'package:clocklify/screen/mainpage_bar.dart';
import 'package:clocklify/utils/component.dart';
import 'package:flutter/material.dart';
import '../model/boxes.dart';
import '../model/user.dart';
import '../style/styles.dart';
import 'home_timer.dart';

class PasswordInputPage extends StatefulWidget {
  var _email;

  PasswordInputPage(this._email);

  @override
  State<PasswordInputPage> createState() => _PasswordInputPageState(_email);
}

class _PasswordInputPageState extends State<PasswordInputPage> {
  var _email;

  _PasswordInputPageState(this._email);

  bool passwordVisible = false;
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Style.bgColor,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              "Password",
              style: TextStyle(
                color: Style.bgColor,
                fontSize: 25.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
            child: TextFormField(
              controller: _passwordController,
              obscureText: !passwordVisible,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Style.bgColor)),
                suffixIcon: IconButton(
                  icon: passwordVisible
                      ? Icon(Icons.visibility_outlined)
                      : Icon(Icons.visibility_off_outlined),
                  iconSize: 25.0,
                  onPressed: () {
                    passwordVisible = !passwordVisible;
                    setState(() {});
                  },
                ),
                label: Text(
                  'Input Your Password',
                  style: TextStyle(color: Colors.black38),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Component.blueButton('OK', () {
                  if (checkLoginCredentials(_email, _passwordController)) {
                    // kalau berhasil
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MainPageBar()));
                  } else {
                    // kalau gagal
                    Navigator.pop(context);
                  }
                })
              ],
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Forgot password?',
                style: TextStyle(color: Color.fromARGB(255, 167, 166, 197)),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  bool checkLoginCredentials(email, TextEditingController passwordController) {
    bool res = false;
    final box = Boxes.getUsersBox();
    Map users = box.toMap();
    for (var element in users.values) {
      if (element.name == email &&
          element.password == passwordController.text) {
        return true;
      }
    }
    return res;
  }
}
