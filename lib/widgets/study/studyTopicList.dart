import 'package:card_study_flutter/db/dbTopic.dart';
import 'package:card_study_flutter/models/topic.dart';
import 'package:card_study_flutter/routes/cardListRoute.dart';
import 'package:card_study_flutter/routes/studyCardRandomRoute.dart';
import 'package:card_study_flutter/routes/studyCardsInGridRoute.dart';
import 'package:card_study_flutter/routes/studyTopicListRoute.dart';
import 'package:card_study_flutter/routes/topicInputRoute.dart';
import 'package:card_study_flutter/routes/topicListRoute.dart';
import 'package:flutter/material.dart';

class StudyTopicListWidget extends StatefulWidget {
  final int? parentId;
  StudyTopicListWidget({super.key, this.parentId});

  @override
  State<StudyTopicListWidget> createState() => _StudyTopicListWidgetState();
}

class _StudyTopicListWidgetState extends State<StudyTopicListWidget> {
  Future<List<Topic>>? _topics;
  Topic? _parent;

  @override
  void initState() {
    super.initState();
    if (widget.parentId != null) {
      _setParent();
    }
    _topics = _getTopics();
  }

  _setParent() async {
    final parent = await DBTopic.getById(widget.parentId!);
    setState(() {
      _parent = parent;
    });
  }

  Future<List<Topic>> _getTopics() async {
    return DBTopic.getByParentId(widget.parentId);
  }

  void _refreshTopics() {
    setState(() {
      _topics = _getTopics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: _topics,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final topics = snapshot.data!;

        return ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final topic = topics[index];
            return ListTile(
              onTap: () {
                if (widget.parentId == null) {
                  Navigator.pushNamed(context, StudyTopicListRoute.routeName,
                      arguments: topic.id);
                } else {
                  Navigator.pushNamed(context, StudyCardRandomRoute.routeName,
                      arguments: topic.id);
                }
              },
              title: Text(topic.title),
              subtitle: Text(topic.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.parentId != null)
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, StudyCardsInGridRoute.routeName,
                              arguments: topic.id);
                        },
                        child: const Text("Cards")),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     final result = await Navigator.pushNamed(
                  //         context, TopicInputRoute.routeName,
                  //         arguments: topic);
                  //     if (result != null) {
                  //       _refreshTopics();
                  //     }
                  //   },
                  //   child: const Icon(Icons.edit),
                  // ),
                ],
              ), //topic.favorite ? Icon(Icons.star) : null,
              leading: CircleAvatar(
                child: Text(topic.priority.toString()),
              ),
            );
          },
        );
      },
    );
  }
}
