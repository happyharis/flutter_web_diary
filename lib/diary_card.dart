import 'package:flutter/material.dart';
import 'package:flutter_web_diary/pop_up_menu.dart';

import 'main.dart';

class DiaryCard extends StatelessWidget {
  const DiaryCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightGreen.shade100,
                ),
                child: Center(
                  child: Text(
                    '😞',
                    style: TextStyle(fontSize: 100),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 30, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Today wasn\'t a great day',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            PopUpMenu()
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Text(
                            diaryEntry,
                            maxLines: 3,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(height: 1.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 40,
                    ),
                    child: InkWell(
                      onTap: () {
                        //TODO: Redirect to diary entry in read mode
                      },
                      child: Text(
                        'Read more',
                        style: TextStyle(
                          color: Colors.lightBlue.shade300,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
