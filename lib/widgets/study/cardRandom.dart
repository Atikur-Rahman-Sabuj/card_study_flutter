import 'package:card_study_flutter/db/dbCard.dart';
import 'package:card_study_flutter/models/studyCard.dart';
import 'package:card_study_flutter/utils/utils.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

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

  void _nextCard() {
    setState(() {
      currentCard = Utils.getRandomCard(cards, usedCardsIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Study Card")),
      body: currentCard == null
          ? const Placeholder()
          : Column(
              children: [
                FlipCard(
                  key: Key(currentCard!.id.toString()),
                  fill: Fill.fillBack,
                  speed: 200,
                  front: StyledCard(
                    title: currentCard!.frontTitle,
                    description: currentCard!.frontDescription,
                  ),
                  back: StyledCard(
                    title: currentCard!.backTitle,
                    description: currentCard!.backDescription,
                  ),
                ),
                ElevatedButton(
                    onPressed: () => _nextCard(), child: const Text("Next"))
              ],
            ),
    );
  }
}

class StyledCard extends StatelessWidget {
  const StyledCard({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle =
        theme.textTheme.titleLarge!.copyWith(color: theme.colorScheme.primary);
    final subtitleStyle = theme.textTheme.titleSmall;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      margin: const EdgeInsets.all(20),
      height: 500,
      decoration: BoxDecoration(
          color: Colors.teal[100],
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: subtitleStyle,
          )
        ],
      )),
    );
  }
}
