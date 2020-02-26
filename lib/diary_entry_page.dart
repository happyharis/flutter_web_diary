import 'package:flutter/material.dart';
import 'package:flutter_web_diary/emoji_helpers.dart';

class DiaryEntryPage extends StatefulWidget {
  const DiaryEntryPage({
    Key key,
    this.emoji,
    this.title,
    this.bodyText,
    this.diaryAction,
  }) : super(key: key);

  const DiaryEntryPage.edit(
      {Key key,
      this.emoji,
      this.title,
      this.bodyText,
      this.diaryAction = DiaryAction.edit})
      : super(key: key);

  const DiaryEntryPage.add(
      {Key key,
      this.emoji,
      this.title,
      this.bodyText,
      this.diaryAction = DiaryAction.add})
      : super(key: key);

  const DiaryEntryPage.read(
      {Key key,
      this.emoji,
      this.title,
      this.bodyText,
      this.diaryAction = DiaryAction.read})
      : super(key: key);

  final Emoji emoji;
  final String title;
  final String bodyText;
  final DiaryAction diaryAction;
  @override
  _DiaryEntryPageState createState() => _DiaryEntryPageState();
}

class _DiaryEntryPageState extends State<DiaryEntryPage> {
  Emoji _emoji;
  TextEditingController titleController;
  TextEditingController bodyTextController;
  bool isReadOnly;
  @override
  void initState() {
    _emoji = widget.emoji;
    titleController = TextEditingController(text: widget.title);
    bodyTextController = TextEditingController(text: widget.bodyText);
    isReadOnly = widget.diaryAction == DiaryAction.read;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 3 / 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text('😄 Happy'),
                        value: Emoji.happy,
                      ),
                      PopupMenuItem(
                        child: Text('😭 Sad'),
                        value: Emoji.sad,
                      ),
                      PopupMenuItem(
                        child: Text('😡 Angry'),
                        value: Emoji.angry,
                      ),
                    ];
                  },
                  child: _emoji == null
                      ? Text('Add Emoji')
                      : Text(
                          emojiSelected(_emoji),
                          style: TextStyle(
                            fontSize: 65,
                          ),
                        ),
                  onSelected: (selectedEmoji) =>
                      setState(() => _emoji = selectedEmoji),
                ),
                // Title
                TextField(
                  readOnly: isReadOnly,
                  controller: titleController,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.black87),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Title',
                  ),
                ),
                // Body text
                TextField(
                  readOnly: isReadOnly,
                  controller: bodyTextController,
                  maxLines: null,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.black87, height: 1.7),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Tell your diary what happened',
                    border: InputBorder.none,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.grey.shade400),
                  ),
                ),
                SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 2,
        onPressed: () {
          // TODO: If diary action is edit, then insert firestore add with the current text.
          // TODO: If diary action is add, then insert firestore edit with new text.
          Navigator.of(context).popUntil(ModalRoute.withName('/'));
        },
        label: Text('Submit'),
        icon: Icon(Icons.book),
      ),
    );
  }

  @override
  void dispose() {
    _emoji = null;
    titleController.dispose();
    bodyTextController.dispose();
    super.dispose();
  }
}

enum DiaryAction { edit, add, read }
