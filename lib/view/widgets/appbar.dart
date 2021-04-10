// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:share/share.dart';

// Project imports:
import '../../model/data.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "Dizzy\n",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "metropolis",
              fontWeight: FontWeight.w400,
              fontSize: 40,
              height: 1.1,
            ),
            children: [
              TextSpan(
                text: "Check",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 45,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Boxicons.bxShareAlt,
            size: 30,
          ),
          iconSize: 30,
          padding: EdgeInsets.all(12),
          color: Colors.black,
          onPressed: () {
            Share.share('My latency is $avg ms.');
          },
        ),
      ],
    );
  }
}
