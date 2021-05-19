import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CrecexdiezAdvertising extends StatelessWidget {
  final int id;
  final int width;
  final int height;

  CrecexdiezAdvertising({required this.id, this.width = 300, this.height = 300});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getImageFromCrecexdiez(),
        builder: (BuildContext _, AsyncSnapshot<List<int>?> snapShot) {
          if (snapShot.hasData) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: width.toDouble(),
                  height: height.toDouble(),
                  child: Stack(
                    children: [
                      Image.memory(snapShot.data as Uint8List),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            await launch('https://crecexdiez.com/s/l/$id/${width}x$height');
                          },
                        ),
                      )
                    ],
                  )
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(1000),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text('Promocionado por CreceXDiez'),
                  ),
                  onTap: () async {
                    await launch('https://crecexdiez.com');
                  },
                )
              ],
            );
          } else {
            return Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator()
            );
          }
        }
    );
  }

  Future<List<int>?>getImageFromCrecexdiez() async {
    Response<List<int>> rs;
    rs = await Dio().get<List<int>>('https://crecexdiez.com/s/i/$id/${width}x$height',
      options: Options(responseType: ResponseType.bytes), // set responseType to `bytes`
    );
    return rs.data;
  }
}
