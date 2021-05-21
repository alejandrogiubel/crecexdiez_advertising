import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Crecex10Advertising extends StatefulWidget {
  final int id;
  final int width;
  final int height;
  final BoxDecoration? boxDecoration;
  final double borderRadius;
  final TextStyle? textStyle;
  final Duration adsIntervals;

  ///Recomended size 300x250, 728x90, 320x100, 300x300
  Crecex10Advertising({
    required this.id,
    this.width = 320,
    this.height = 100,
    this.boxDecoration,
    this.borderRadius = 0,
    this.textStyle,
    this.adsIntervals = const Duration(seconds: 5)
  });

  @override
  _Crecex10AdvertisingState createState() => _Crecex10AdvertisingState();
}

class _Crecex10AdvertisingState extends State<Crecex10Advertising> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    Timer.periodic(widget.adsIntervals, (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getImageFromCrecex10(),
        builder: (BuildContext _, AsyncSnapshot<List<int>?> snapShot) {
          if (snapShot.hasData) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: widget.boxDecoration,
                  width: widget.width.toDouble(),
                  height: widget.height.toDouble(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: Stack(
                      children: [
                        FadeInImage(
                          image: Image.memory(snapShot.data as Uint8List).image,
                          placeholder: Image.network('').image,
                          placeholderErrorBuilder: (BuildContext _, Object object, StackTrace? stackTrace) {
                            return CircularProgressIndicator();
                          },
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              await launch(
                                  'https://crecexdiez.com/s/l/${widget.id}/${widget.width}x${widget.height}');
                            },
                          ),
                        )
                      ],
                    ),
                  )),
                InkWell(
                  borderRadius: BorderRadius.circular(1000),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text('Promocionado por CreceXDiez',
                      style: widget.textStyle,
                    ),
                  ),
                  onTap: () async {
                    await launch('https://crecexdiez.com');
                  },
                )
              ],
            );
          } else {
            return Container(
                width: 50, height: 50, child: CircularProgressIndicator());
          }
        });
  }

  ///Return a byte list from crecexdiez platform with the generated ads image.
  Future<List<int>?> getImageFromCrecex10() async {
    Response<List<int>> rs;
    rs = await Dio().get<List<int>>(
      'https://crecexdiez.com/s/i/${widget.id}/${widget.width}x${widget.height}',
      options: Options(
          responseType: ResponseType.bytes), // set responseType to `bytes`
    );
    return rs.data;
  }

}
