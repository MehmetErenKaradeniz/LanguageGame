import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Font Awesome icons
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  ContactPage({super.key});

  // URL'leri tanımla
  final Uri _emailUrl = Uri.parse('mailto:m.erenkaradenizbusiness@gmail.com');
  final Uri _githubUrl = Uri.parse('https://github.com/MehmetErenKaradeniz'); // GitHub URL'sini buraya ekleyin
  final Uri _instagramUrl = Uri.parse('https://instagram.com/yourprofile'); // Instagram URL'sini buraya ekleyin
  final Uri _twitterUrl = Uri.parse('https://twitter.com/yourprofile'); // Twitter URL'sini buraya ekleyin

  // URL'yi başlat
  Future<void> _launchUrl(Uri url) async {
    try {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.deepPurple, // Deep purple
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get in Touch with Us',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16.0),
            Text(
              'For any questions, advice, comments, or sponsorship inquiries, please use the information below to contact us.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.envelope,
                    size: 50,
                  ),
                  onPressed: () {
                    _launchUrl(_emailUrl);
                  },
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.github,
                    size: 50,
                  ),
                  onPressed: () {
                    _launchUrl(_githubUrl);
                  },
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.instagram,
                    size: 50,
                  ),
                  onPressed: () {
                    _launchUrl(_instagramUrl);
                  },
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.xTwitter,
                    size: 50,
                  ),
                  onPressed: () {
                    _launchUrl(_twitterUrl);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

