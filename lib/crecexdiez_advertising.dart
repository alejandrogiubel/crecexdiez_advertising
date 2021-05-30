import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Crecex10Advertising extends StatefulWidget {
  ///Your CreceXDiez user id
  final int id;

  /// Width of the ad
  final int width;

  /// Height of the ad
  final int height;

  /// Define the box decoration of the ad
  final BoxDecoration? boxDecoration;

  /// Define the radius of the image ad
  final double borderRadius;

  /// Define the style of the bottom text of the ad
  final TextStyle? textStyle;

  /// Define the intervals durations between ads. Change intervals need hot restart.
  final Duration adsIntervals;

  /// Show close button for dispose the ad
  final bool showCloseButton;

  /// Displays a tag to indicate that it is an ad
  final bool showAdLabel;

  ///Recomended size 300x250, 728x90, 320x100, 300x300
  Crecex10Advertising(
      {required this.id,
      this.width = 320,
      this.height = 100,
      this.boxDecoration,
      this.borderRadius = 0,
      this.textStyle,
      this.showCloseButton = false,
      this.showAdLabel = true,
      this.adsIntervals = const Duration(seconds: 10)})
      : assert(adsIntervals >= Duration(seconds: 3));

  @override
  _Crecex10AdvertisingState createState() => _Crecex10AdvertisingState();
}

class _Crecex10AdvertisingState extends State<Crecex10Advertising>
    with TickerProviderStateMixin {
  bool _closed = false;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.adsIntervals, (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_closed
        ? FutureBuilder(
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
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          child: Stack(
                            children: [
                              FadeInImage(
                                image: Image.memory(snapShot.data as Uint8List)
                                    .image,
                                placeholder: Image.network('').image,
                                placeholderErrorBuilder: (BuildContext _,
                                    Object object, StackTrace? stackTrace) {
                                  return CircularProgressIndicator();
                                },
                              ),
                              adLabel(),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    await launch(
                                        'https://crecexdiez.com/s/l/${widget.id}/${widget.width}x${widget.height}');
                                  },
                                ),
                              ),
                              closeButton()
                            ],
                          ),
                        )),
                    InkWell(
                      borderRadius: BorderRadius.circular(1000),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(
                          'Promocionado por CreceXDiez',
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
                return SizedBox.shrink();
              }
            })
        : const SizedBox.shrink();
  }

  /// Return the ad tag to indicate that it is an ad
  Widget adLabel() {
    return Container(
      margin: EdgeInsets.all(5),
      width: 35,
      height: 20,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Text(
          'AD',
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  /// Return the close button
  Widget closeButton() {
    return Visibility(
      visible: widget.showCloseButton,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(1000)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(1000),
                onTap: () {
                  setState(() {
                    _closed = true;
                  });
                },
                child: Center(
                    child: Icon(
                  Icons.close,
                  size: 15,
                  color: Colors.white,
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///Return a byte list from crecexdiez platform with the generated ads image.
  Future<List<int>?> getImageFromCrecex10() async {
    Response<List<int>> rs;
    rs = await Dio().get<List<int>>(
      'https://crecexdiez.com/s/i/${widget.id}/${widget.width}x${widget.height}',
      options: Options(responseType: ResponseType.bytes),
    );
    return rs.data;
  }
}
