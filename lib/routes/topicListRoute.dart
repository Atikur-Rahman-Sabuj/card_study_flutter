import 'package:card_study_flutter/widgets/topicList.dart';
import 'package:card_study_flutter/widgets/topicInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
