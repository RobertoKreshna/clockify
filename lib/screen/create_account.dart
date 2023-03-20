import 'dart:async';

import 'package:clocklify/model/boxes.dart';
import 'package:clocklify/model/user.dart';
import 'package:clocklify/screen/mainpage_bar.dart';
import 'package:clocklify/utils/component.dart';
import 'package:flutter/material.dart';
import 'home_timer.dart';
import 'login.dart';
import '../style/styles.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  State<CreateAccountPage> createState() => _CreateAccountPage();
}

class _CreateAccountPage extends State<CreateAccountPage> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
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
              "Create New Account",
              style: TextStyle(
                color: Style.bgColor,
                fontSize: 25.0,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Style.bgColor)),
                  label: Text(
                    "Input Your E-mail",
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
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
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextFormField(
              controller: _confirmPasswordController,
              obscureText: !confirmPasswordVisible,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Style.bgColor)),
                suffixIcon: IconButton(
                  icon: confirmPasswordVisible
                      ? Icon(Icons.visibility_outlined)
                      : Icon(Icons.visibility_off_outlined),
                  iconSize: 25.0,
                  onPressed: () {
                    setState(() {
                      confirmPasswordVisible = !confirmPasswordVisible;
                    });
                  },
                ),
                label: Text(
                  'Confirm Your Password',
                  style: TextStyle(color: Colors.black38),
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Component.blueButton('CREATE', () {
                  //cek add
                  bool addResult = addUser(
                      _emailController.text,
                      _passwordController.text,
                      _confirmPasswordController.text);
                  //kalau gagal
                  if (!addResult) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()));
                  } else {
                    //kalau berhasil
                    showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildSuccessPopUp())
                        // .then((value) => Navigator.pop(context));
                        .then((value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MainPageBar())));
                  }
                })
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

bool addUser(String email, String password, String passwordConfirmation) {
  if (password == passwordConfirmation) {
    final newUser = User(email, password);
    final box = Boxes.getUsersBox();
    box.add(newUser);
    return true;
  } else {
    print('User cannot be made');
    return false;
  }
}

Widget _buildSuccessPopUp() {
  return AlertDialog(
    contentPadding: EdgeInsets.zero,
    backgroundColor: Colors.transparent,
    content: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 5.0),
              child: Container(
                child: Image.asset(
                  "assets/images/success.png",
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 7.5, 8.0, 7.5),
              child: Text(
                'Success',
                style: TextStyle(color: Style.bgColor, fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 50.0),
              child: Text(
                'Your account has been successed created',
                maxLines: 1,
                style: TextStyle(color: Colors.black38, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
