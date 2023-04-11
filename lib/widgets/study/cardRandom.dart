import 'package:card_study_flutter/db/dbCard.dart';
import 'package:card_study_flutter/models/studyCard.dart';
import 'package:card_study_flutter/utils/utils.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CardRandom extends StatefulWidget {
  final int topicId;
  const CardRandom({super.key, required this.topicId});

  @override
  State<CardRandom> createState() => _CardRandomState();
}

class _CardRandomState extends State<CardRandom> {
  late List<StudyCard> cards;
  List<int> usedCardsIds = [];
  StudyCard? currentCard;

  @override
  void initState() {
    _getCards();
    super.initState();
  }

  void _getCards() async {
    cards = await DBCard.getByTopicId(widget.topicId);
    setState(() {
      currentCard = Utils.getRandomCard(cards, usedCardsIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentCard == null
          ? const Placeholder()
          : FlipCard(
              speed: 200,
              front: Text(currentCard!.frontTitle),
              back: Text(currentCard!.backTitle),
            ),
    );
  }
}
