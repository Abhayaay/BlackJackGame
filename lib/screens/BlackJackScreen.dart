
import 'package:blackjackgame/widgets/Custom_widget.dart';
import 'package:blackjackgame/widgets/cardgridview.dart';
import 'package:flutter/material.dart';
import 'dart:math';




class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({Key? key}) : super(key: key);

  @override
  State<BlackJackScreen> createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {


  bool _isGameStarted = false;
  //cards images
  List<Image> myCards = [];

  List<Image> dealersCards = [];
  //cards
  String? dealerFirstCard;

  String? dealerSecondCard;

  String? playersFirstCard;
  String? playersSecondCard;

  //scores
  int dealersScore = 0;
  int playersScore = 0;

  //deck of cards
  final Map<String, int> deckOfCards = {
    "cards/2.1.png": 2,
    "cards/2.2.png": 2,
    "cards/2.3.png": 2,
    "cards/2.4.png": 2,
    "cards/3.1.png": 3,
    "cards/3.2.png": 3,
    "cards/3.3.png": 3,
    "cards/3.4.png": 3,
    "cards/4.1.png": 4,
    "cards/4.2.png": 4,
    "cards/4.3.png": 4,
    "cards/4.4.png": 4,
    "cards/5.1.png": 5,
    "cards/5.2.png": 5,
    "cards/5.3.png": 5,
    "cards/5.4.png": 5,
    "cards/6.1.png": 6,
    "cards/6.2.png": 6,
    "cards/6.3.png": 6,
    "cards/6.4.png": 6,
    "cards/7.1.png": 7,
    "cards/7.2.png": 7,
    "cards/7.3.png": 7,
    "cards/7.4.png": 7,
    "cards/8.1.png": 8,
    "cards/8.2.png": 8,
    "cards/8.3.png": 8,
    "cards/8.4.png": 8,
    "cards/9.1.png": 9,
    "cards/9.2.png": 9,
    "cards/9.3.png": 9,
    "cards/9.4.png": 9,
    "cards/10.1.png": 10,
    "cards/10.2.png": 10,
    "cards/10.3.png": 10,
    "cards/10.4.png": 10,
    "cards/J1.png": 10,
    "cards/J2.png": 10,
    "cards/J3.png": 10,
    "cards/J4.png": 10,
    "cards/Q1.png": 10,
    "cards/Q2.png": 10,
    "cards/Q3.png": 10,
    "cards/Q4.png": 10,
    "cards/K1.png": 10,
    "cards/K2.png": 10,
    "cards/K3.png": 10,
    "cards/K4.png": 10,
    "cards/A1.png": 11,
    "cards/A2.png": 11,
    "cards/A3.png": 11,
    "cards/A4.png": 11,
  };
  Map<String, int> playingCards = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    playingCards.addAll(deckOfCards); //start of game playing cards == full deck of cards
  }

  //Reset the round and reset the cards
  void startNewRound(){
    _isGameStarted = true;
    //Start new round with new deckofcards
    playingCards = {};
    playingCards.addAll(deckOfCards);
    //reset card images
    //Card
    myCards = [];
    dealersCards = [];
    Random random = Random();
    // Random card for dealer
    String cardOnekey = playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));//find an element in that number
    //We will remove the repeated card i.e. same card should not come again
    playingCards.removeWhere((key, value) => key == cardOnekey);

    //Random card for dealer
    String cardTwokey = playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == cardTwokey);

    //Card one for the player
    String cardThreekey = playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == cardThreekey);

    //Random card two for the player
    String cardFourkey = playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == cardFourkey);

    //Assign cardkeys to dealers
    dealerFirstCard = cardOnekey;
    dealerSecondCard = cardTwokey;
    //Assign cardkeys to players
    playersFirstCard = cardThreekey;
    playersSecondCard = cardFourkey;

    //Adding dealers card images to display them in Grid view
    dealersCards.add(Image.asset(dealerFirstCard!)); //We add null check to add non nullable value
    dealersCards.add(Image.asset(dealerSecondCard!));
    //Score for dealer
    dealersScore = deckOfCards[dealerFirstCard]! + deckOfCards[dealerSecondCard]!;

    //Adding players card images to display them in Grid view
    myCards.add(Image.asset(playersFirstCard!));
    myCards.add(Image.asset(playersSecondCard!));

    //Score for players
    playersScore = deckOfCards[playersFirstCard]! + deckOfCards[playersSecondCard]!;

    //helps to rebuild our widget
    setState(() {});

  }
  // Add extra card to player
  void addCard() {
    Random random = Random();
    if(playingCards.length > 0){
      String cardKey = playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));

      playingCards.removeWhere((key, value) => key == cardKey);

      myCards.add(Image.asset(cardKey));

      playersScore = playersScore + deckOfCards[cardKey]!;

      setState(() {});

    }

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _isGameStarted
          ? SafeArea(

            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Column(
                children: [
                  //TODO: Add dealer's Score
                  Text("Dealer's Score: $dealersScore",style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: dealersScore <=21 ? Colors.green[600] : Colors.red[800],
                  ),),
                  Cardsgridview(Cards: dealersCards),
                ],
              ),
              Column(
                children: [
                  //TODO: Add score
                  Text("Player's Score: $playersScore", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: playersScore <=21 ? Colors.green[600] : Colors.red[800],
                  ),),
                  Cardsgridview(Cards: myCards),

                ],
              ),

              IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomButton(onPressed: (){
                      addCard();
                    }, label: "Add Card",),


                    CustomButton(onPressed: (){
                      startNewRound();
                    }, label: "Next Round",),
                  ],
                ),
              )


            ],
          )
      )
          : Center(
              child: CustomButton(onPressed: (){
                startNewRound();
              }, label: "Start game",),
      ),
    );
  }
}

