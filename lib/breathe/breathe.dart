import 'package:flutter/material.dart';

class BreatheScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BreathingCircle(),
    );
  }
}

class BreathingCircle extends StatefulWidget {
  @override
  _BreathingCircleState createState() => _BreathingCircleState();
}

class _BreathingCircleState extends State<BreathingCircle>
    with TickerProviderStateMixin {
  late AnimationController _breatheController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _breatheController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 16), // Total duration of the breathing cycle
    );

    _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(_breatheController);

    _breatheController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breatheController.reset();
        _breatheController.forward();
      }
    });

    _breatheController.addListener(() {
      if (_breatheController.value < 0.25) {
        // Fades in from 30 to 100 during breathing in for 4 seconds
        _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
          CurvedAnimation(
            parent: _breatheController,
            curve: Interval(0.0, 0.25),
          ),
        );
      } else if (_breatheController.value >= 0.25 && _breatheController.value < 0.5) {
        // Holds at 100 opacity for 4 seconds
        _fadeAnimation = Tween<double>(begin: 1.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _breatheController,
            curve: Interval(0.25, 0.5),
          ),
        );
      } else if (_breatheController.value >= 0.5 && _breatheController.value < 0.75) {
        // Fades out from 100 to 30 during breathing out for 4 seconds
        _fadeAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
          CurvedAnimation(
            parent: _breatheController,
            curve: Interval(0.5, 0.75),
          ),
        );
      } else {
        // Holds at 30 opacity for 4 seconds
        _fadeAnimation = Tween<double>(begin: 0.5, end: 0.5).animate(
          CurvedAnimation(
            parent: _breatheController,
            curve: Interval(0.75, 1.0),
          ),
        );
      }
    });

    _breatheController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.grey[900],
        child: Center(
          child: AnimatedBuilder(
            animation: _breatheController,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.translate(
                  offset: Offset(0.0, -100.0),
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white70,
                    ),
                    child: Center(
                      child: Transform.translate(
                        offset: Offset(0.0, 245.0),
                        child: Text(
                          _getBreathingText(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24.0, color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _getBreathingText() {
    if (_breatheController.value < 0.25) {
      return ' Breathe in through your nose slowly, feeling the air enter into your lungs';
    } else if (_breatheController.value < 0.5) {
      return ' Hold your breath ';
    } else if (_breatheController.value < 0.75) {
      return 'Breathe out through your mouth slowly';
    } else {
      return 'Hold your breath';
    }
  }

  @override
  void dispose() {
    _breatheController.dispose();
    super.dispose();
  }
}
