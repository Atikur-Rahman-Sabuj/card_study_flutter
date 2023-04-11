import 'package:card_study_flutter/models/topic.dart';
import 'package:card_study_flutter/widgets/management/topic/topicInput.dart';
import 'package:flutter/cupertino.dart';

class TopicInputRoute extends StatelessWidget {
  const TopicInputRoute({super.key});
  static String routeName = "input-topic-route";

  @override
  Widget build(BuildContext context) {
    final topic = ModalRoute.of(context)!.settings.arguments as Topic;
    return TopicInputWidget(
      topic: topic,
    );
  }
}
