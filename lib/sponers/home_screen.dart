import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:vega/models/company.dart';
import 'package:vega/services/firebase_db.dart';
import 'package:vega/sponers/document.dart';
import 'package:vega/sponers/event_screen.dart';
import 'package:vega/sponers/profile_screen.dart';
import 'package:vega/sponers/setting.dart';

class HomeScreen extends StatelessWidget {
  final DBcompany _db = DBcompany();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.70,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: _db.getCompany(),
                builder: (context, snapshot) {
                  List myComp = snapshot.data?.docs ?? [];
                  return ListView.builder(
                    itemCount: myComp.length,
                    itemBuilder: (context, index) {
                      Company event = myComp[index].data();
                      String eveniID = myComp[index].id;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 10.0,
                        ),
                        child: ListTile(
                          tileColor: Color.fromARGB(255, 174, 221, 255),
                          title: Text(event.title),
                          subtitle: Text(event.description),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle onTap event for the messages icon
          print("Messages icon tapped");
        },
        child: Icon(Icons.message), // Messages icon
        backgroundColor: Colors.grey,
      ),
      bottomNavigationBar: CustomBottomBar(), // Use the CustomBottomBar here
    );
  }
}

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedItemPosition = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedItemPosition = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventScreen()),
        );
        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeedbackScreen()),
        );
        break;
      case 4:
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
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Event'),
        BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
      ],
      selectedLabelStyle: const TextStyle(fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
    );
  }
}

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Center(
        child: Text('Feedback Screen'),
      ),
    );
  }
}
