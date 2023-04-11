import 'package:card_study_flutter/routes/topicInputRoute.dart';
import 'package:card_study_flutter/routes/topicListRoute.dart';
import 'package:card_study_flutter/widgets/study/studyTopicList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Card Study")),
      floatingActionButton: FloatingActionButton.small(
          child: const Icon(Icons.edit_document),
          onPressed: () =>
              Navigator.pushNamed(context, TopicListRoute.routeName)),
      body: StudyTopicListWidget(),
    );
  }
}
