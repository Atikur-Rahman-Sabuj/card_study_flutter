import 'package:card_study_flutter/widgets/topicList.dart';
import 'package:card_study_flutter/widgets/topicInput.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});
  static String routeName = "home-route";

  @override
  Widget build(BuildContext context) {
    return const TopicListWidget();
  }
}
