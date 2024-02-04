// home.dart

import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          Positioned(
            top: 175.0,  // Adjust this value to move the button up or down
            left: MediaQuery.of(context).size.width / 2 - 100.0,  // Adjust the width / 2
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/breathe');
              },
              child: Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(165, 198, 162, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 7.5,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Go to \nBreathe',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w700,
                        fontSize: 27.0
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 450.0,
            left: MediaQuery.of(context).size.width / 2 - 100.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/log');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),


                ),
                padding: EdgeInsets.symmetric(horizontal: 65.0, vertical: 15.0),
                textStyle: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.normal,
                  fontSize: 18.0,
                ),
              ),
              child: Text('Go to Log', style: TextStyle(color: Color.fromRGBO(165, 198, 162, 1))),
            ),
          ),
          Positioned(
            top: 530.0,
            left: MediaQuery.of(context).size.width / 2 - 100.0,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the view journal page when the button is pressed
                // Replace 'ViewJournalPage' with the actual route or page you want to navigate to
                Navigator.pushNamed(context, '/view_journal');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                textStyle: TextStyle(
                  color: Colors.grey[900],
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                ),
              ),
              child: Text('View Journal', style: TextStyle(color: Color.fromRGBO(165, 198, 162, 1))),
            ),
          ),
        ],
      ),
    );
  }
}
