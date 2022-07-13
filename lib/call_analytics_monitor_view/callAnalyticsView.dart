import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'tabDesign.dart';
import 'cardRowOne.dart';
import 'cardRowTwo.dart';

class CallAnalyticsView extends StatelessWidget {
  const CallAnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GetPlatform.isAndroid ? 570 : 600,
      width: GetPlatform.isAndroid ? 500 : 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // tabs here
            Container(
              height: 100,
              width: 500,
              child: TabDesign(false, false),
            ),

            Expanded(child: CardRowOne()),
            // Row 1 for 2 cards
            Expanded(child: CardRowTwo()),
            // row 2 for another set of 2 cards
          ],
        ),
      ),
    );
  }
}