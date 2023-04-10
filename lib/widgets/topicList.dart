import 'package:card_study_flutter/db/dbTopic.dart';
import 'package:card_study_flutter/models/topic.dart';
import 'package:card_study_flutter/routes/cardListRoute.dart';
import 'package:card_study_flutter/routes/topicInputRoute.dart';
import 'package:card_study_flutter/routes/topicListRoute.dart';
import 'package:flutter/material.dart';

class TopicListWidget extends StatefulWidget {
  final int? parentId;
  TopicListWidget({super.key, this.parentId});

  @override
  State<TopicListWidget> createState() => _TopicListWidgetState();
}

class _TopicListWidgetState extends State<TopicListWidget> {
  Future<List<Topic>>? _topics;

  @override
  void initState() {
    super.initState();
    _topics = _getTopics();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics'),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, TopicInputRoute.routeName,
                  arguments: Topic(
                    parentId: widget.parentId,
                    title: "",
                    description: "",
                    favorite: false,
                    priority: 1,
                  ));
          if (result != null) {
            _refreshTopics();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Topic>>(
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
                    Navigator.pushNamed(context, TopicListRoute.routeName,
                        arguments: topic.id);
                  } else {
                    Navigator.pushNamed(context, CardListRoute.routeName,
                        arguments: topic.id);
                  }
                },
                title: Text(topic.title),
                subtitle: Text(topic.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          DBTopic.delete(topic);
                          _refreshTopics();
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text("")),
                    ElevatedButton.icon(
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                              context, TopicInputRoute.routeName,
                              arguments: topic);
                          if (result != null) {
                            _refreshTopics();
                          }
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("")),
                  ],
                ), //topic.favorite ? Icon(Icons.star) : null,
                leading: CircleAvatar(
                  child: Text(topic.priority.toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
