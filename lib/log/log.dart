// log.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class LogPage extends StatefulWidget {
  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  int _currentStep = 0;
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  double _intensityValue = 5.0; // Default intensity value
  double _sleepValue = 7.0; // Default sleep value
  TextEditingController _precedingActivitiesController = TextEditingController();

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
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            setState(() {
              if (_currentStep < 4) {
                _currentStep += 1;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (_currentStep > 0) {
                _currentStep -= 1;
              }
            });
          },
          steps: [
            Step(
              title: Text('Start Time', style: TextStyle(
                  color: Color.fromRGBO(165, 198, 162, 1),
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700)),
              content: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? selectedStartTime = await showTimePicker(
                        context: context,
                        initialTime: _startTime,
                      );
                      if (selectedStartTime != null) {
                        setState(() {
                          _startTime = selectedStartTime;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(165, 198, 162, 1)),
                    child: Text('Select Start Time',
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                  ),
                  Text('Selected Start Time: ${_startTime.format(context)}',
                      style: TextStyle(color: Color.fromRGBO(165, 198, 162, 1),
                          fontSize: 16.0)),
                ],
              ),
            ),
            Step(
              title: Text('End Time', style: TextStyle(
                  color: Color.fromRGBO(165, 198, 162, 1),
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700)),
              content: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? selectedEndTime = await showTimePicker(
                        context: context,
                        initialTime: _endTime,
                      );
                      if (selectedEndTime != null) {
                        setState(() {
                          _endTime = selectedEndTime;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(165, 198, 162, 1)),
                    child: Text(
                        'Select End Time', style: TextStyle(fontSize: 16.0)),
                  ),
                  Text('Selected End Time: ${_endTime.format(context)}',
                      style: TextStyle(color: Color.fromRGBO(165, 198, 162, 1),
                          fontSize: 16.0)),
                ],
              ),
            ),
            Step(
              title: Text('Intensity', style: TextStyle(
                  color: Color.fromRGBO(165, 198, 162, 1),
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700)),
              content: Column(
                children: [
                  Slider(
                    value: _intensityValue,
                    min: 0.0,
                    max: 10.0,
                    divisions: 10,
                    label: _intensityValue.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _intensityValue = value;
                      });
                    },
                  ),
                  Text('Selected Intensity: ${_intensityValue.round()}',
                      style: TextStyle(color: Color.fromRGBO(165, 198, 162, 1),
                          fontSize: 16.0)),
                ],
              ),
            ),
            Step(
              title: Text('Sleep Received at Night', style: TextStyle(
                  color: Color.fromRGBO(165, 198, 162, 1),
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700)),
              content: Column(
                children: [
                  Slider(
                    value: _sleepValue,
                    min: 0.0,
                    max: 10.0,
                    divisions: 10,
                    label: _sleepValue.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _sleepValue = value;
                      });
                    },
                  ),
                  Text('Selected Sleep: ${_sleepValue.round()} hours',
                      style: TextStyle(color: Color.fromRGBO(165, 198, 162, 1),
                          fontSize: 16.0)),
                ],
              ),
            ),
            Step(
              title: Text('Preceding Activities', style: TextStyle(
                  color: Color.fromRGBO(165, 198, 162, 1),
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700)),
              content: Column(
                children: [
                  TextFormField(
                    controller: _precedingActivitiesController,
                    maxLines: 3,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Describe preceding activities...',
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Process the form data as needed
          _submitForm();
        },
        child: Icon(Icons.send),
        backgroundColor: Color.fromRGBO(
            165, 198, 162, 1), // Change the color of the button
      ),
    );
  }

  void _submitForm() async {
    // Implement logic to handle form submission
    String startTime = _startTime.format(context);
    String endTime = _endTime.format(context);
    int intensity = _intensityValue.round();
    double sleepReceived = _sleepValue;
    String precedingActivities = _precedingActivitiesController.text;

    // Create a map representing the data to be stored in Firebase Realtime Database
    Map<String, dynamic> formData = {
      'startTime': startTime,
      'endTime': endTime,
      'intensity': intensity,
      'sleepReceived': sleepReceived,
      'precedingActivities': precedingActivities,
    };

    try {
      // Add the form data to Firestore
      await _firestore.collection('migraine_entries').add(formData);

      // Optionally, you can navigate back to the home screen after submission
      Navigator.pop(context);
    } catch (e) {
      // Handle errors, if any
      print('Error submitting form: $e');
    }
  }
}
