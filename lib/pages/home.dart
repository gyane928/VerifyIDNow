import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Begin'),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home'),
            SizedBox(
              height: 100.0,
            ),
            FlatButton(onPressed: () {
              Navigator.of(context).pushNamed('/info');
            },
              child: Text('Begin'),
              color: Colors.lightBlueAccent,)
          ],
        ),
      ),
    );
  }
}
