import 'package:card_study_flutter/db/dbCard.dart';
import 'package:card_study_flutter/db/dbTopic.dart';
import 'package:card_study_flutter/models/studyCard.dart';
import 'package:card_study_flutter/models/topic.dart';
import 'package:card_study_flutter/routes/cardInputRoute.dart';
import 'package:card_study_flutter/routes/topicInputRoute.dart';
import 'package:card_study_flutter/routes/topicListRoute.dart';
import 'package:flutter/material.dart';

class CardListWidget extends StatefulWidget {
  final int topicId;
  CardListWidget({super.key, required this.topicId});

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  Future<List<StudyCard>>? _cards;

  @override
  void initState() {
    super.initState();
    _cards = _getCards();
  }

  Future<List<StudyCard>> _getCards() async {
    return DBCard.getByTopicId(widget.topicId);
  }

  void _refreshCards() {
    setState(() {
      _cards = _getCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, CardInputRoute.routeName,
                  arguments: StudyCard(
                    topicId: widget.topicId,
                    frontTitle: "",
                    frontDescription: "",
                    backTitle: "",
                    backDescription: "",
                    favorite: false,
                    priority: 1,
                  ));
          if (result != null) {
            _refreshCards();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<StudyCard>>(
        future: _cards,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final cards = snapshot.data!;

          return ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              return ListTile(
                title: Text(card.frontTitle),
                subtitle: Text(card.frontDescription),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          DBCard.delete(card);
                          _refreshCards();
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text("")),
                    ElevatedButton.icon(
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                              context, CardInputRoute.routeName,
                              arguments: card);
                          if (result != null) {
                            _refreshCards();
                          }
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("")),
                  ],
                ), //topic.favorite ? Icon(Icons.star) : null,
                leading: CircleAvatar(
                  child: Text(card.priority.toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
