import 'package:card_study_flutter/widgets/management/topic/topicList.dart';
import 'package:card_study_flutter/widgets/study/studyTopicList.dart';
import 'package:flutter/material.dart';

class StudyTopicListRoute extends StatelessWidget {
  const StudyTopicListRoute({super.key});
  static String routeName = "study-topic-list-route";

  @override
  Widget build(BuildContext context) {
    final int? parentId = ModalRoute.of(context)!.settings.arguments as int?;
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: StudyTopicListWidget(parentId: parentId),
    );
  }
}
