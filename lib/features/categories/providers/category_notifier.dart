import 'package:zephyr_flutter/features/categories/data/models/categories.dart' as custom;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final categoriesFetchProvider = FutureProvider<List<custom.Category>>((ref) async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('categories').get();

  final categories = querySnapshot.docs
      .map((doc) => custom.Category.fromFirestore(doc.data()))
      .toList();

  return categories;
});