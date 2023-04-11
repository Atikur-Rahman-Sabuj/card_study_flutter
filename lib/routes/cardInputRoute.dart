import 'package:card_study_flutter/models/studyCard.dart';
import 'package:card_study_flutter/widgets/management/card/cardInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
