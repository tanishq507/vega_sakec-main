import 'package:flutter/material.dart';
import 'package:vega/models/myevents.dart';

class EventDetailsScreen extends StatelessWidget {
  final myEvents event;

  EventDetailsScreen({
    required this.event,
    required String eventId,
    required String eventName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // Add functionality for scan button
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Event Details:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      title: Text(
                        'Title:',
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        event.title,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Description:',
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        event.description,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Location:',
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        event.location,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Date & Time:',
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        event.datetime
                            .toString(), // Assuming datetime is a DateTime object
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Is Live:',
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        event.isLive ? 'Yes' : 'No',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Owner:',
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        event.owner,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: Icon(Icons.qr_code_scanner),
              onPressed: () {
                // Add functionality for scan button
              },
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: IconButton(
              icon: Icon(Icons.credit_card),
              onPressed: () {
                // Add functionality for card button
              },
            ),
          ),
        ],
      ),
    );
  }
}
