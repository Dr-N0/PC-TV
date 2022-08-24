import 'package:flutter/material.dart';
import 'package:pc_tv_phone/provider/AuthProvider.dart';
import 'package:pc_tv_phone/screens/App.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  Widget _entryEmailField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        // padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          controller: emailController,
          // style: TextStyle(color: Color(0xFFF67E7D)),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: new TextStyle(color: Color.fromARGB(255, 80, 80, 80)),
            hintText: 'Enter valid email',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            // Focused Border
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFA06CD5), width: 5),
            ),
            // Error Border
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow, width: 5),
            ),
            // Focused Error Border
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _entryPasswordField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
        //padding: EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          obscureText: true,
          controller: passController,
          // style: TextStyle(color: Color(0xFFF67E7D)),
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: new TextStyle(color: Color.fromARGB(255, 80, 80, 80)),
            hintText: 'Enter secure password',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            // Focused Border
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFA06CD5), width: 5),
            ),
            // Error Border
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow, width: 5),
            ),
            // Focused Error Border
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFF67E7D),
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          AuthProvider().login(emailController.text, passController.text);
        },
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryEmailField("Email"),
        _entryPasswordField("Password", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFFA06CD5),
              Color(0xFF6247AA),
            ],
            stops: [0.0, 0.5],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome!",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(75, 246, 126, 125),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20),
                              _emailPasswordWidget(),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(primary: Colors.grey),
                          child: Text("Forgot Password?"),
                          onPressed: () => Navigator.of(context)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => App()),
                                  (route) => true),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        _submitButton(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
