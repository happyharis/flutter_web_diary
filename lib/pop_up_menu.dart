import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Action>(
      elevation: 2,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: Action.delete,
            child: Text('Delete'),
          ),
          PopupMenuItem(
            value: Action.edit,
            child: Text('Edit'),
          ),
        ];
      },
      onSelected: (action) {
        switch (action) {
          case Action.delete:
          // TODO: open a dialog to delete, with a firestore function to delete
          case Action.edit:
          // TODO: redirect to the diary entry page (edit mode), with the data
          default:
        }
      },
    );
  }
}

enum Action { delete, edit, none }
