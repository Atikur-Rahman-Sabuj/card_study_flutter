import 'package:card_study_flutter/models/studyCard.dart';
import 'package:card_study_flutter/models/topic.dart';
import 'package:card_study_flutter/widgets/cardInput.dart';
import 'package:card_study_flutter/widgets/topicInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CardInputRoute extends StatelessWidget {
  const CardInputRoute({super.key});
  static String routeName = "input-card-route";

  @override
  Widget build(BuildContext context) {
    final card = ModalRoute.of(context)!.settings.arguments as StudyCard;
    return CardInputWidget(
      card: card,
    );
  }
}
