import 'package:card_study_flutter/widgets/cardList.dart';
import 'package:card_study_flutter/widgets/topicList.dart';
import 'package:card_study_flutter/widgets/topicInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
