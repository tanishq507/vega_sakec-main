import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:vega/eventsection/eventlanding.dart';
import 'package:vega/eventsection/eventsecscreen.dart';
import 'package:vega/models/myevents.dart';
import 'package:vega/services/firebase_db.dart';
import 'package:vega/sponers/setting.dart';
import 'package:vega/students/event_details.dart';

class EventListScreen extends StatelessWidget {
  final DBservEvents _db = DBservEvents();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('  events'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.70,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: _db.getEvents(),
                builder: (context, snapshot) {
                  List myEventsl = snapshot.data?.docs ?? [];
                  return ListView.builder(
                    itemCount: myEventsl.length,
                    itemBuilder: (context, index) {
                      myEvents event = myEventsl[index].data();
                      String eveniID = myEventsl[index].id;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 10.0,
                        ),
                        child: ListTile(
                          tileColor: Color.fromARGB(255, 180, 139, 139),
                          leading: Container(
                            height: 100, // Adjust height as needed
                            width: 100, // Adjust width as needed
                            child: Image.asset(
                              'assets/images/hack.jpg', // Asset path for the image
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(event.title),
                          subtitle: Text(event.description),
                          onTap: () {
                            // Navigate to the event details screen with sponsor names
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDetailsScreen(
                                  eventId: eveniID,
                                  eventName: event.title,
                                  event: myEvents(
                                      title: 'hackthon',
                                      description: '',
                                      location: '',
                                      datetime: Timestamp.now(),
                                      isLive: true,
                                      owner: ''),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottoomBar(),
    );
  }
}

class CustomBottoomBar extends StatefulWidget {
  const CustomBottoomBar({Key? key}) : super(key: key);

  @override
  _CustomBottoomBarState createState() => _CustomBottoomBarState();
}

class _CustomBottoomBarState extends State<CustomBottoomBar> {
  int _selectedItemPosition = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedItemPosition = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventListScreen()),
        );
        break;

      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
        break;
      default:
      // Handle the default case
    }
  }

  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.circle,
      padding: const EdgeInsets.all(12),
      snakeViewColor: Colors.red,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: _selectedItemPosition,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
      ],
      selectedLabelStyle: const TextStyle(fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
    );
  }
}
