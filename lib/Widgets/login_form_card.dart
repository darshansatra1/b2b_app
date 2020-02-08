import 'dart:async';

import 'package:b2b_app/Models/User.dart';
import 'package:b2b_app/Shared/app_style.dart';
import 'package:b2b_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FormCard extends StatefulWidget {
  FormCard(this.isSignIn, {
    Key key,
  }) : super(key: key);
  bool isSignIn;

  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  bool isDoneEditing1 = false;
  bool isDoneEditing2 = false;
  bool isDoneEditing3 = false;
  bool isDoneEditing4 = false;
  bool isDoneEditing5 = false;

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    User user = Provider.of<User>(context);

    print(widget.isSignIn);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Card(

//        elevation: 0.5,
        child: AnimatedSwitcher(
          transitionBuilder: (child, animation) {
            final offsetAnimation =
            Tween<Offset>(begin: Offset(0.0, -0.3), end: Offset(0.0, 0.02))
                .animate(animation);
            return ClipRect(
              clipBehavior: Clip.antiAlias,
              child: SlideTransition(
                position: offsetAnimation,
                child: child,
              ),
            );
          },
          duration: Duration(milliseconds: 400),
          child: widget.isSignIn
              ? Form(
            key: formKey,
            child: Column(
              key: UniqueKey(),
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                    left: 10,
                  ),
                  child: Text('Username', style: AppStyle.loginPageStyle),
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                    validator: (v) {
                      if (user.userName != null && user.userName == v)
                        user.setUserStat(true);
                      print(v.toString());
                      if (v.isEmpty) return 'Username cannot be Empty!';
                      if (!user.isValidUser) return 'Wrong Username';
                      return null;
                    },
//                      onSaved: (v) {
//                        user.setUserName(v);
//                        setState(() {
//                          isDoneEditing1 = !isDoneEditing1;
//                        });
//                      },
//              suffix: Icon(
//                Icons.check_circle_outline,
//                color: isDoneEditing ? Colors.green : Colors.red,
//              ),
//              suffixMode: OverlayVisibilityMode.always,
                    decoration: InputDecoration(
                        labelText: 'Enter your Username',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        )),
//              clearButtonMode: isDoneEditing
//                  ? OverlayVisibilityMode.never
//                  : OverlayVisibilityMode.editing,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      bottom: 10,
                      left: 10,
                    ),
                    child: Text(
                      'Password',
                      style: AppStyle.loginPageStyle,
                    )),
                Container(
                  height: 40,
                  child: TextFormField(
                      validator: (v) {
                        if (user.password != null && user.password == v)
                          user.setPassStat(true);

                        if (v.isEmpty) return 'Password cannot be Empty!';
                        if (!user.isValidPass) return 'Wrong Password';
                        if (!user.isValidPass && !user.isValidUser)
                          return 'Wrong Username and Password combination!';
                        return null;
                      },
//                        onSaved: (v) {},
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Enter your Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              )))),
                ),
                InkWell(
                    child: Container(
                        margin: EdgeInsets.only(left: 200, top: 20),

                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  final form = formKey.currentState;
                                  if (form.validate()) {
                                    form.save();
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('Logging in')));
                                    loadMainPage(context);
                                  }
                                },
                                child: Center(
                                    child: Text('Log in',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 18,
                                            letterSpacing: 1.0))))))),
              ],
            ),
          )
              : Form(
            key: formKey,
            child: Column(
              key: UniqueKey(),
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 10,
                  ),
                  child: Text(
                    'Email-ID',
                    style: AppStyle.loginPageStyle,
                  ),
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                      validator: (v) {
                        if (v.isEmpty) return 'E-mail cannot be Empty!';
                        return null;
                      },
                      onSaved: (v) {
                        user.setEmail(v);
                      },
                      decoration: InputDecoration(
                          labelText: 'Enter an E-mail',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              )))),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 15,
                    bottom: 10,
                    left: 10,
                  ),
                  child: Text(
                    'Username',
                    style: AppStyle.loginPageStyle,
                  ),
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                      validator: (v) {
                        if (v.isEmpty) return 'Username cannot be Empty!';
                        return null;
                      },
                      onSaved: (v) {
                        user.setUserName(v);
                      },
                      decoration: InputDecoration(
                          labelText: 'Enter an Username',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              )))),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 15,
                    bottom: 10,
                    left: 10,
                  ),
                  child: Text(
                    'Password',
                    style: AppStyle.loginPageStyle,
                  ),
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                      validator: (v) {
                        if (v.isEmpty) return 'Password cannot be Empty!';
                        return null;
                      },
                      onSaved: (v) {
                        user.setPassword(v);
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Enter an Password (Alphanumeric)',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              )))),
                ),
                InkWell(
                    child: Container(
                        margin: EdgeInsets.only(left: 200, top: 10),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  final form = formKey.currentState;
                                  if (form.validate()) {
                                    form.save();
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('Registering..')));
                                  }
                                },
                                child: Center(
                                    child: Text('Sign Up',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 18,
                                            letterSpacing: 1.0)))))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}


loadMainPage(BuildContext context) {
  Navigator.pushNamed(context, '/loading');
  Timer(
      Duration(seconds: 4),
          () =>
          Navigator.popAndPushNamed(
              context, '/scaffold'));
}