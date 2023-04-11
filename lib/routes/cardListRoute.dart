import 'package:card_study_flutter/widgets/management/card/cardList.dart';
import 'package:flutter/material.dart';

class CardListRoute extends StatelessWidget {
  const CardListRoute({super.key});
  static String routeName = "card-list-route";

  @override
  Widget build(BuildContext context) {
    final int topicId = ModalRoute.of(context)!.settings.arguments as int;
    return CardListWidget(
      topicId: topicId,
    );
  }
}
