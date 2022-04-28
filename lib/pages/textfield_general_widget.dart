import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app1/pages/widgets/textform_button.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class TextfieldGeneralWidget extends StatefulWidget {
  @override
  _TextfieldGeneralWidgetState createState() => _TextfieldGeneralWidgetState();

}

class _TextfieldGeneralWidgetState extends State<TextfieldGeneralWidget> {
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final serviceController = TextEditingController();
  bool isDisabled = true;
  //here
  //final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    emailController.addListener(() => setState(() {}));
    companyController.addListener(() => setState(() {}));
    serviceController.addListener(() => setState(() {}));

  }
