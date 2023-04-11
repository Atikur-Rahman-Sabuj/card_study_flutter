import 'package:card_study_flutter/widgets/home.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});
  static String routeName = "home-route";

  @override
  Widget build(BuildContext context) {
    return const HomeWidget();
  }
}
