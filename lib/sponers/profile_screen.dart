import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// Define a model class for sponsors
class Sponsor {
  final String image;
  final String name;
  final String description;

  Sponsor(
      {required this.image,
      required this.name,
      required this.description,
      required TextStyle descriptionTextStyle});
}

// Create a list of sponsor objects
List<Sponsor> sponsorList = [
  Sponsor(
    image: 'assets/images/coca.jpg',
    name: 'Coca-Cola',
    description:
        "Coca-Cola is a carbonated soft drink produced by The Coca-Cola Company. Originally intended as a patent medicine, it was invented in the late 19th century by John Stith Pemberton. The formula and brand were bought in 1889 by Asa Griggs Candler, who incorporated The Coca-Cola Company in 1892. Coca-Cola is one of the world's best-known brands, and it's sold in stores, restaurants, and vending machines worldwide. The beverage's name refers to two of its original ingredients: coca leaves, and kola nuts. It's typically served cold and enjoyed by people of all ages.",
    // Set the font family to Nunito Sans for the description text
    descriptionTextStyle: TextStyle(
      fontFamily: 'Nunito Sans',
      fontSize: 14.0,
      // Add more styling properties if needed
    ),
  ),

  Sponsor(
    image: 'assets/images/pepsi.jpg',
    name: 'Company B',
    description: 'Description of Company B',
    descriptionTextStyle: TextStyle(
      fontFamily: 'Nunito Sans',
      fontSize: 14.0,
    ),
  ),
  // Add more sponsors as needed
  Sponsor(
    image: 'assets/images/z.jpg',
    name: 'Company C',
    description: 'Description of Company C',
    descriptionTextStyle: TextStyle(
      fontFamily: 'Nunito Sans',
      fontSize: 14.0,
    ),
  ),
  Sponsor(
    image: 'assets/images/supra.jpg',
    name: 'Company D',
    description: 'Description of Company D',
    descriptionTextStyle: TextStyle(
      fontFamily: 'Nunito Sans',
      fontSize: 14.0,
    ),
  ),
];

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentSponsorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Profile Screen'),
            SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentSponsorIndex = index;
                  });
                },
              ),
              items: sponsorList.map((sponsor) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(sponsor.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  sponsorList[_currentSponsorIndex].name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  sponsorList[_currentSponsorIndex].description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
