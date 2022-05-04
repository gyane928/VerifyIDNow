import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/pages/widgets/textform_button.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_app1/pages/widgets/rounded_button_widget.dart';

class TextfieldGeneralWidget extends StatefulWidget {
  @override
  _TextfieldGeneralWidgetState createState() => _TextfieldGeneralWidgetState();

}

class _TextfieldGeneralWidgetState extends State<TextfieldGeneralWidget> {
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final serviceController = TextEditingController();
  bool isDisabled = true;
  bool isVerified = true;

  final int triesAllowed = 3;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() => setState(() {}));
    companyController.addListener(() => setState(() {}));
    serviceController.addListener(() => setState(() {}));

  }


  void _printLatestValue() {

    print('Name: ${emailController.text}');
    print('Company: ${companyController.text}');
    print('Service: ${serviceController.text}');

  }

  bool _isButtonDisabled() {

    if ((emailController.text == "") || (companyController.text == "") || (serviceController.text == "")) {
      //RegistrationUser();
      return true;
    }
    else {
      return false;
    }
  }
  Future RegistrationUser() async{
    var APIURL = "http://localhost/vid/registration.php";
    Map mapeddate ={
      //'employeeId':1,
      'firstName' : emailController.text,
      'lastName': companyController.text,
      'email' : serviceController.text,

    };

    try {
      http.Response response = await http.post(Uri.parse(APIURL),body:mapeddate);
      var data = json.decode(response.body);

    } catch (e) {
      print(e);
      String mess = "error";
      String message = e.toString();
      if (e.toString().contains(mess)) {
        isVerified = false;
        print(isVerified);
      }
    }

    return isVerified;
  }
  @override
  void dispose() {
    emailController.dispose();
    companyController.dispose();
    serviceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
    child: ListView(
      padding: EdgeInsets.all(32),
      children: [
        buildFirstName(),
        const SizedBox(height: 24),
        buildCompany(),
        const SizedBox(height: 24),
        buildService(),
        const SizedBox(height: 24),

        SizedBox(height: 10,),
        DisabledButton(
            key: Key('submitInfo'),
            //key:_formkey
            isDisabled: _isButtonDisabled(),
            child: RaisedButton (
              child: Text('Next'),

              onPressed: () {
                //print(isVerified);
                RegistrationUser();
                print(isVerified);
                showDialog(
                  context: context,
                  builder: (context) {

                    Timer _timer = Timer(Duration(seconds: 3), () {
                      Navigator.of(context).pop();
                    });

                    return SimpleDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        elevation: 16,
                        children: [
                          if (isVerified== true)...[
                            Center(
                                child: Column(
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(height: 10,),
                                      Text("Verifying appointment...",
                                        style: TextStyle(
                                            color: Colors.blueAccent),)
                                    ]
                                )
                            ),

                          ]
                          else ...[

                            Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text('We were unable to verify your appointment.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CupertinoColors.black,
                                        fontSize: 35))),
                            RoundedButton(
                              text: 'RETURN HOME',
                              color: 0xFF1DDE7D,
                              onClicked: () {
                                int count = 0;
                                Navigator.of(context).popUntil((route) {
                                  return count++ == 2;
                                });
                              },
                            )
                          ]
                        ]
                    );
                  },
                );

                //the timer and the delayed push to next to screen are meant to simulate
                //a connection to the database
                //when a real connection is made, you can remove these timers
                //and pop the dialog box based on the connection response
                Future.delayed(const Duration(milliseconds: 4000), () {
                  setState(() {

                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/take_photo');
                  });
                });

              },
              textColor: Colors.white,
              color: Color(0xFF1DDE7D),
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              shape: StadiumBorder(),
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0, right: 45.0, left: 45.0),

            )
        ),
        SizedBox(height: 20,),
        FlatButton(
          onPressed: () {
            _printLatestValue();
            Navigator.of(context, rootNavigator: true)
                .pushNamed('/take_photo');
          },
          child: Text("Skip"),
          color: Colors.lightBlueAccent,
          shape: StadiumBorder(),
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0, right: 45.0, left: 45.0),
        ),
      ],
    ),
  );

  Widget buildFirstName() => TextField(
    controller: emailController,
    decoration: InputDecoration(
      labelText: 'First Name',
      prefixIcon: Icon(Icons.account_circle),
      // icon: Icon(Icons.mail),
      suffixIcon: emailController.text.isEmpty
          ? Container(width: 0)
          : IconButton(
        icon: Icon(Icons.close),
        onPressed: () => emailController.clear(),
      ),
      border: UnderlineInputBorder(),
    ),
    keyboardType: TextInputType.name,

    textInputAction: TextInputAction.done,
    // autofocus: true,
  );

  Widget buildCompany() => TextField(
    controller: companyController,
    decoration: InputDecoration(
      labelText: 'Last Name',
      prefixIcon: Icon(Icons.account_balance_rounded),
      // icon: Icon(Icons.mail),
      suffixIcon: companyController.text.isEmpty
          ? Container(width: 0)
          : IconButton(
        icon: Icon(Icons.close),
        onPressed: () => companyController.clear(),
      ),
      border: UnderlineInputBorder(),
    ),
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.done,
    // autofocus: true,
  );

  Widget buildService() => TextField(
    controller: serviceController,
    decoration: InputDecoration(
      labelText: 'email',
      prefixIcon: Icon(Icons.account_balance_rounded),
      // icon: Icon(Icons.mail),
      suffixIcon: serviceController.text.isEmpty
          ? Container(width: 0)
          : IconButton(
        icon: Icon(Icons.close),
        onPressed: () => serviceController.clear(),
      ),
      border: UnderlineInputBorder(),
    ),
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.done,
    // autofocus: true,
  );

  void _showAlertDialog(String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
