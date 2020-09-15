import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryEntry {
  final String emoji;
  final String title;
  final String body;
  final String id;

  DiaryEntry({
    this.emoji,
    this.title,
    this.body,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'emoji': emoji,
      'title': title,
      'body': body,
    };
  }

  factory DiaryEntry.fromDoc(QueryDocumentSnapshot doc) {
    return DiaryEntry(
      emoji: doc.data()['emoji'],
      title: doc.data()['title'],
      body: doc.data()['body'],
      id: doc.id,
    );
  }
}
