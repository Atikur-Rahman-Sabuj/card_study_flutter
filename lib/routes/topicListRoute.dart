import 'package:card_study_flutter/widgets/management/topic/topicList.dart';
import 'package:flutter/material.dart';

class TopicListRoute extends StatelessWidget {
  const TopicListRoute({super.key});
  static String routeName = "topic-list-route";

  @override
  Widget build(BuildContext context) {
    final int? parentId = ModalRoute.of(context)!.settings.arguments as int?;
    return TopicListWidget(
      parentId: parentId,
    );
  }
}
