import 'package:bilibili/constants/global.dart';
import 'package:bilibili/log.dart';
import 'package:bilibili/model/pgcmodule.dart';
import 'package:flutter/material.dart';

import '../service/api.dart';

class CardItemView extends StatelessWidget {
  final PgcModuleItem cardItem;

  final String cursor;

  const CardItemView(
    this.cursor,
    this.cardItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            onPressed: () async {
              await PgcService.getPgcPageDetailAsync(
                PgcType.bangumi,
                cursor,
                (data) {
                  Log.i(data);
                },
              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const VideoPlayer('', ''),
              //   ),
              // );
            },
            child: Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(cardItem.cover),
                  fit: BoxFit.fitHeight,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              alignment: Alignment.bottomLeft,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cardItem.title),
              Text(cardItem.stat.viewCount.toString()),
              Text(cardItem.stat.followCount.toString()),
            ],
          ),
        ),
      ],
    );
  }
}
