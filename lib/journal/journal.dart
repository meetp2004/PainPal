import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JournalEntryPage extends StatefulWidget {
  @override
  _JournalEntryPageState createState() => _JournalEntryPageState();
}

class _JournalEntryPageState extends State<JournalEntryPage> {
  final CollectionReference _entriesCollection = FirebaseFirestore.instance.collection('migraine_entries');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal Entries'),
      ),
      body: StreamBuilder(
        stream: _entriesCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No entries available.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var entry = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              // Customize the appearance based on your entry data structure
              return ListTile(
                title: Text('Start Time: ${entry['startTime']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('End Time: ${entry['endTime']}'),
                    Text('Intensity: ${entry['intensity']}'),
                    Text('Sleep Received: ${entry['sleepReceived']} hours'),
                    Text('Preceding Activities: ${entry['precedingActivities']}'),
                  ],
                ),
                // Add more fields as needed
              );
            },
          );
        },
      ),
    );
  }
}
