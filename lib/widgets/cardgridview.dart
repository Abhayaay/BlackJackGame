import 'package:flutter/material.dart';

class Cardsgridview extends StatelessWidget {
  const Cardsgridview({
    super.key,
    required this.Cards,
  });

  final List<Image> Cards;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: Cards.length,
          itemBuilder: (context, index){
            //TODO: Return dealers cards here
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Cards[index],
            );

          }),
    );
  }
}
