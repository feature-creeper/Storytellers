// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:storytellers/main.dart';
import 'package:storytellers/services/firestore_services.dart';

void main() {
  setUp() {
    Firebase.initializeApp();
  }

  test('Fetch featured book ids', () async {
    FirestoreServices fs = FirestoreServices();
    List<String> ids = await fs.getFeatured('featured');
  });
}
