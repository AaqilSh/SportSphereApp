import 'package:flutter/material.dart';
import 'package:sportsphere/models/venue.dart';
import 'package:url_launcher/url_launcher.dart';

class VenueDetailsScreen extends StatelessWidget {
  final Venue venue;

  const VenueDetailsScreen({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    bool hasImages = venue.strThumb.isNotEmpty ||
        venue.strFanart1.isNotEmpty ||
        venue.strFanart2.isNotEmpty ||
        venue.strFanart3.isNotEmpty ||
        venue.strFanart4.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(venue.strVenue),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImages)
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    if (venue.strThumb.isNotEmpty)
                      Image.network(venue.strThumb,
                          width: 300, height: 200, fit: BoxFit.cover),
                    if (venue.strFanart1.isNotEmpty)
                      Image.network(venue.strFanart1,
                          width: 300, height: 200, fit: BoxFit.cover),
                    if (venue.strFanart2.isNotEmpty)
                      Image.network(venue.strFanart2,
                          width: 300, height: 200, fit: BoxFit.cover),
                    if (venue.strFanart3.isNotEmpty)
                      Image.network(venue.strFanart3,
                          width: 300, height: 200, fit: BoxFit.cover),
                    if (venue.strFanart4.isNotEmpty)
                      Image.network(venue.strFanart4,
                          width: 300, height: 200, fit: BoxFit.cover),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    venue.strVenue,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  if (venue.strVenueAlternate.isNotEmpty)
                    Text(
                      'Also Known As: ${venue.strVenueAlternate}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red),
                      SizedBox(width: 5),
                      Text(
                        venue.strLocation,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.people, color: Colors.green),
                      SizedBox(width: 5),
                      Text(
                        'Capacity: ${venue.intCapacity}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.public, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(
                        'Country: ${venue.strCountry}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    venue.strDescriptionEN.isNotEmpty
                        ? venue.strDescriptionEN
                        : 'No description available.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  if (venue.strWebsite.isNotEmpty)
                    ElevatedButton.icon(
                      icon: Icon(Icons.language),
                      label: Text('Visit Website'),
                      onPressed: () async {
                        final Uri url =
                            Uri.parse('https://${venue.strWebsite}');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Could not open website')),
                          );
                        }
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
