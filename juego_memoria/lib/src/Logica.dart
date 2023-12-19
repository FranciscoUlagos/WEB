// ignore_for_file: file_names, non_constant_identifier_names

class GameLogic {
  final String hiddenCard = 'images/interrogation.png';

  List<String>? cardsImg;

  final List<String> demo_card_list = [
    'images/electric-guitar.png',
    'images/piano.png',
    'images/drum-set.png',
    'images/saxophone.png',
    'images/recorder.png',
    'images/triangle.png',
    'images/accordion.png',
    'images/harp.png',
    'images/electric-guitar.png',
    'images/piano.png',
    'images/drum-set.png',
    'images/saxophone.png',
    'images/recorder.png',
    'images/triangle.png',
    'images/accordion.png',
    'images/harp.png',
  ];

  List<Map<int, String>> matchCheck = [];

  var cardCount = 16;
  void initGame() {
    demo_card_list.shuffle();
    cardsImg = List<String>.generate(cardCount, (index) {
      return hiddenCard;
    });
  }
}
