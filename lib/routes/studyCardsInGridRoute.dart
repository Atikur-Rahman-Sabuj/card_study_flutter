import 'package:card_study_flutter/widgets/study/cardRandom.dart';
import 'package:card_study_flutter/widgets/study/cardsInGrid.dart';
import 'package:flutter/material.dart';

class StudyCardsInGridRoute extends StatelessWidget {
  const StudyCardsInGridRoute({super.key});
  static String routeName = "study-cards-in-grid-route";

  @override
  Widget build(BuildContext context) {
    final int topicId = ModalRoute.of(context)!.settings.arguments as int;
    return CardsInGrid(topicId: topicId);
  }
}
