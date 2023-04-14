import 'package:card_study_flutter/db/dbCard.dart';
import 'package:card_study_flutter/models/studyCard.dart';
import 'package:card_study_flutter/utils/utils.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class CardsInGrid extends StatefulWidget {
  final int topicId;
  const CardsInGrid({super.key, required this.topicId});

  @override
  State<CardsInGrid> createState() => _CardsInGridState();
}

class _CardsInGridState extends State<CardsInGrid> {
  late Future<List<StudyCard>> _cards;

  @override
  void initState() {
    _getCards();
    super.initState();
  }

  void _getCards() {
    _cards = DBCard.getByTopicId(widget.topicId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Study Card")),
      body: FutureBuilder<List<StudyCard>>(
        future: _cards,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final cards = snapshot.data!;
          return GridView.count(
            crossAxisCount: 2,
            children: List.generate(
                cards.length,
                (index) => FlipCard(
                    front: StyledCard(
                      title: cards[index].frontTitle,
                      description: cards[index].frontDescription,
                    ),
                    back: StyledCard(
                      title: cards[index].backTitle,
                      description: cards[index].backDescription,
                    ))),
          );
        },
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
      margin: const EdgeInsets.all(10),
      height: 250,
      decoration: BoxDecoration(
          color: Colors.teal[100],
          borderRadius: const BorderRadius.all(Radius.circular(5))),
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
