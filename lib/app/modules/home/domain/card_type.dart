enum CardType { FAVORITE, PUBLIC, MY_CARD }

class CardTypeHelper {
  static fromString(String cardType) {
    if (cardType == null) {
      return CardType.PUBLIC;
    }

    for (var type in CardType.values) {
      if (type.toString().contains(cardType)) {
        return type;
      }

      return CardType.PUBLIC;
    }
  }
}