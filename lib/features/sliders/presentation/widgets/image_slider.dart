import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  Future<List<String>> _fetchImageUrls() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('sliders').get();

    final List<String> allUrls = [];
    for (final doc in querySnapshot.docs) {
      final data = doc.data();
      if (data['images'] != null && data['images']['source'] is List<dynamic>) {
        final List<dynamic> sources = data['images']['source'];
        for (final source in sources) {
          if (source is String) {
            allUrls.add(source);
          }
        }
      }
    }
    return allUrls;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _fetchImageUrls(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final imageUrls = snapshot.data!;
        if (imageUrls.isEmpty) {
          return const Center(child: Text('No images found.'));
        }

        return CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            aspectRatio: 16 / 9,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
          ),
          items: imageUrls.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}