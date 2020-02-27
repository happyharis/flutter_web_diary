import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_diary/diary_entry_model.dart';
import 'package:flutter_web_diary/diary_entry_page.dart';

class DiaryEntryButton extends StatelessWidget {
  const DiaryEntryButton({
    Key key,
    @required this.titleController,
    @required this.bodyTextController,
    @required String emoji,
    @required this.widget,
  })  : _emoji = emoji,
        super(key: key);

  final TextEditingController titleController;
  final TextEditingController bodyTextController;
  final String _emoji;
  final DiaryEntryPage widget;

  @override
  Widget build(BuildContext context) {
    final isAddAction = widget.diaryAction == DiaryAction.add;
    return FloatingActionButton.extended(
      elevation: 2,
      onPressed: () {
        final data = DiaryEntry(
          emoji: _emoji,
          title: titleController.text,
          body: bodyTextController.text,
        ).toMap();

        if (isAddAction) {
          // TODO: 1. Answer to add firestore document
          Firestore.instance.collection('diaries').add(data);
        } else if (widget.diaryAction == DiaryAction.edit) {
          // TODO: 4. Answer to update firestore document
          final documentId = widget.diaryEntry.documentId;
          Firestore.instance
              .collection('diaries')
              .document(documentId)
              .updateData(data);
        }
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      },
      label: Text(isAddAction ? 'Submit' : 'Update'),
      icon: Icon(isAddAction ? Icons.book : Icons.bookmark_border),
    );
  }
}
