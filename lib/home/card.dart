import 'package:bilibili/model/recommend.dart';
import 'package:flutter/material.dart';

class CardItemView extends StatelessWidget {
  final RecommendCard cardItem;

  const CardItemView({Key? key, required this.cardItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Hero(
              tag: cardItem.parameter,
              child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(cardItem.cover),
                        fit: BoxFit.fitHeight),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 2, left: 10, right: 10),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(0, 0, 0, 0.01),
                            Colors.black54
                          ]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text(
                              cardItem.playCountText,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                              textAlign: TextAlign.justify,
                            ),
                            const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text(cardItem.subStatusText,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.justify),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            cardItem.durationText,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Text(
                  cardItem.title,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  maxLines: 2,
                ),
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 5, right: 5, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      cardItem.cardArgs.publisherName,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: FractionalOffset.centerRight,
                        child: Icon(
                          Icons.more_vert,
                          size: 13,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
