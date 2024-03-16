import 'package:flutter/material.dart';
import 'package:vega/eventsection/eventlanding.dart';
import 'package:vega/sponers/home_screen.dart';
import 'package:vega/students/homee_screen.dart';

enum UserType { sponsor, eventOrganizer, student }

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  final PageController _pageController2 = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose User Type'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: const [
                    UserTypeCard(
                      userType: UserType.sponsor,
                      assetName: 'assets/images/teacher.png',
                    ),
                    UserTypeCard(
                      userType: UserType.eventOrganizer,
                      assetName: 'assets/images/student.png',
                    ),
                    UserTypeCard(
                      userType: UserType.student,
                      assetName: 'assets/images/student.png',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomIndicator(
            controller: _pageController2,
            dotsLength: 3,
          ),
        ],
      ),
    );
  }
}

class UserTypeCard extends StatelessWidget {
  final UserType userType;
  final String assetName;
  const UserTypeCard({
    required this.userType,
    required this.assetName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userTypeName = '';
    switch (userType) {
      case UserType.sponsor:
        userTypeName = 'Sponsor';
        break;
      case UserType.eventOrganizer:
        userTypeName = 'Event Organizer';
        break;
      case UserType.student:
        userTypeName = 'Student';
        break;
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blueGrey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              assetName,
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            Text(
              userTypeName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                switch (userType) {
                  case UserType.sponsor:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                    break;
                  case UserType.eventOrganizer:
                    // Navigate to event organizer screen
                    break;
                  case UserType.student:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventListScreen()),
                    ); // Navigate to student screen
                    break;
                }
                switch (userType) {
                  case UserType.sponsor:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                    break;
                  case UserType.eventOrganizer:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventLanding()),
                    ); // Navigate to event organizer screen
                    break;
                  case UserType.student:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventListScreen()),
                    ); // Navigate to student screen
                    break;
                }
              },
              child: const Text('Select'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomIndicator extends StatelessWidget {
  final PageController controller;
  final int dotsLength;
  const CustomIndicator({required this.controller, required this.dotsLength});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: PageViewIndicator(
        controller: controller,
        dotsCount: dotsLength,
        onPageSelected: (int page) {
          controller.animateToPage(
            page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}

class PageViewIndicator extends StatelessWidget {
  final PageController controller;
  final int dotsCount;
  final ValueChanged<int> onPageSelected;
  const PageViewIndicator(
      {required this.controller,
      required this.dotsCount,
      required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: dotsCount,
      onPageChanged: onPageSelected,
      itemBuilder: (BuildContext context, int index) {
        return IndicatorDot(
          isSelected: index == controller.page!.round(),
        );
      },
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final bool isSelected;
  const IndicatorDot({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: isSelected ? 10 : 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.blue : Colors.grey,
      ),
    );
  }
}
