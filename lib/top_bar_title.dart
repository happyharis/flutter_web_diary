import 'package:flutter/material.dart';

class TopBarTitle extends StatelessWidget {
  const TopBarTitle(
    this.title, {
    Key key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: EdgeInsets.only(left: 40),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
