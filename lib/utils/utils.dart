import 'dart:math';

import 'package:card_study_flutter/models/studyCard.dart';

class Utils {
  static getRandomCard(List<StudyCard> cards, List<int> usedCards) {
    // Remove used cards from the list
    List<StudyCard> remainingCards =
        cards.where((card) => !usedCards.contains(card.id)).toList();

    // If all cards have been used, reset the used cards list
    if (remainingCards.isEmpty) {
      usedCards.clear();
      remainingCards = cards;
    }

    // Sort the remaining cards by priority
    remainingCards.sort((a, b) => b.priority.compareTo(a.priority));

    // Calculate total priority
    int totalPriority =
        remainingCards.fold(0, (sum, card) => sum + card.priority);

    // Generate a random number between 0 and total priority
    Random random = Random();
    int randomNumber = random.nextInt(totalPriority);

    // Iterate through the sorted list and subtract priority until we reach the selected card
    StudyCard selectedCard = remainingCards.first;
    for (int i = 0; i < remainingCards.length; i++) {
      StudyCard currentCard = remainingCards[i];
      if (randomNumber < currentCard.priority) {
        selectedCard = currentCard;
        break;
      } else {
        randomNumber -= currentCard.priority;
      }
    }

    // Add the selected card to the used cards list and return it
    usedCards.add(selectedCard.id!);
    return selectedCard;
  }
}
