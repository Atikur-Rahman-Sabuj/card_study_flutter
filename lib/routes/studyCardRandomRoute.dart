import 'package:card_study_flutter/widgets/study/cardRandom.dart';
import 'package:flutter/material.dart';

class StudyCardRandomRoute extends StatelessWidget {
  const StudyCardRandomRoute({super.key});
  static String routeName = "study-card-random-route";

  @override
  Widget build(BuildContext context) {
    final int topicId = ModalRoute.of(context)!.settings.arguments as int;
    return CardRandom(topicId: topicId);
  }
}
