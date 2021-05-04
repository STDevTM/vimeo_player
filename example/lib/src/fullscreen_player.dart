library vimeoplayer;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'quality_links.dart';

// ignore: must_be_immutable
class FullscreenPlayer extends StatefulWidget {
  final String id;
  final bool autoPlay;
  final bool looping;
  final VideoPlayerController controller;
  int position;
  Future<void> initFuture;
  var qualityValue;

  FullscreenPlayer({
    @required this.id,
    this.autoPlay,
    this.looping,
    this.controller,
    this.position,
    this.initFuture,
    this.qualityValue,
    Key key,
  }) : super(key: key);

  @override
  _FullscreenPlayerState createState() => _FullscreenPlayerState(
      id, autoPlay, looping, controller, position, initFuture, qualityValue);
}

class _FullscreenPlayerState extends State<FullscreenPlayer> {
  String _id;
  bool autoPlay = false;
  bool looping = false;
  bool _overlay = true;
  bool fullScreen = true;

  VideoPlayerController controller;
  VideoPlayerController _controller;

  int position;

  Future<void> initFuture;
  var qualityValue;

  _FullscreenPlayerState(this._id, this.autoPlay, this.looping, this.controller,
      this.position, this.initFuture, this.qualityValue);

// <<<<<<< HEAD
//   // Quality Class
//   late QualityLinks _quality;
//   late Map _qualityValues;
//
//   //Переменная перемотки
//   bool _seek = true;
//
//   //Переменные видео
//   double? videoHeight;
//   double? videoWidth;
//   late double videoMargin;
// =======
  QualityLinks _quality; // Quality Class
  Map _qualityValues;
  bool _seek = true;

  double videoHeight;
  double videoWidth;
  double videoMargin;
// >>>>>>> parent of d9fbbc8... 0.1.8

  double doubleTapMargin = 40;
  double doubleTapWidth = 400;
  double doubleTapHeight = 200;

  //Переменные под зоны дабл-тапа
// <<<<<<< HEAD
//   double doubleTapRMarginFS = 36;
//   double? doubleTapRWidthFS = 700;
//   double doubleTapRHeightFS = 300;
//   double doubleTapLMarginFS = 10;
//   double? doubleTapLWidthFS = 700;
//   double? doubleTapLHeightFS = 400;
// =======
  double doubleTapRMargin = 36;
  double doubleTapRWidth = 700;
  double doubleTapRHeight = 300;
  double doubleTapLMargin = 10;
  double doubleTapLWidth = 700;
  double doubleTapLHeight = 400;
// >>>>>>> parent of d9fbbc8... 0.1.8

  @override
  void initState() {
    //Инициализация контроллеров видео при получении данных из Vimeo
    _controller = controller;
    if (autoPlay) _controller.play();

    // Подгрузка списка качеств видео
    _quality = QualityLinks(_id); //Create class
    _quality.getQualitiesSync().then((value) {
      _qualityValues = value;
    });

    setState(() {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    });

    super.initState();
  }

// <<<<<<< HEAD
//   //Ослеживаем пользовательского нажатие назад и переводим
//   // на экран с плеером не в режиме фуллскрин, возвращаем ориентацию
//   Future<bool> _onWillPop() {
//     setState(() {
//       _controller!.pause();
//       SystemChrome.setPreferredOrientations(
//           [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
//       SystemChrome.setEnabledSystemUIOverlays(
//           [SystemUiOverlay.top, SystemUiOverlay.bottom]);
//     });
//     Navigator.pop(context, _controller!.value.position.inSeconds);
//     return Future.value(true);
//   }
//
// =======
// >>>>>>> parent of d9fbbc8... 0.1.8
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        GestureDetector(
          child: FutureBuilder(
              future: initFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  //Управление шириной и высотой видео
                  double delta = MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.height *
                          _controller.value.aspectRatio;
                  if (MediaQuery.of(context).orientation ==
                          Orientation.portrait ||
                      delta < 0) {
                    videoHeight = MediaQuery.of(context).size.width /
                        _controller.value.aspectRatio;
                    videoWidth = MediaQuery.of(context).size.width;
                    videoMargin = 0;
                  } else {
                    videoHeight = MediaQuery.of(context).size.height;
// <<<<<<< HEAD
//                         videoWidth =
//                             videoHeight! * _controller!.value.aspectRatio;
//                         videoMargin =
//                             (MediaQuery.of(context).size.width - videoWidth!) /
//                                 2;
//                       }
//                       //Переменные дабл тапа, зависимые от размеров видео
//                       doubleTapRWidthFS = videoWidth;
//                       doubleTapRHeightFS = videoHeight! - 36;
//                       doubleTapLWidthFS = videoWidth;
//                       doubleTapLHeightFS = videoHeight;
//
//                       //Сразу при входе в режим фуллскрин перематываем
//                       // на нужное место
//                       if (_seek && fullScreen) {
//                         _controller!.seekTo(Duration(seconds: position!));
//                         _seek = false;
//                       }
//
//                       //Переходи на нужное место при смене качества
//                       if (_seek && _controller!.value.duration.inSeconds > 2) {
//                         _controller!.seekTo(Duration(seconds: position!));
// =======
                    videoWidth = videoHeight * _controller.value.aspectRatio;
                    videoMargin =
                        (MediaQuery.of(context).size.width - videoWidth) / 2;
                  }

                  doubleTapRWidth = videoWidth;
                  doubleTapRHeight = videoHeight - 36;
                  doubleTapLWidth = videoWidth;
                  doubleTapLHeight = videoHeight;

                  if (_seek && fullScreen) {
                    _controller.seekTo(Duration(seconds: position));
                    _seek = false;
                  }
                  if (_seek && _controller.value.duration.inSeconds > 2) {
                    _controller.seekTo(Duration(seconds: position));
// >>>>>>> parent of d9fbbc8... 0.1.8
                    _seek = false;
                  }
                  SystemChrome.setEnabledSystemUIOverlays(
                      [SystemUiOverlay.bottom]);
                  //Отрисовка элементов плеера
                  return Stack(
                    children: <Widget>[
                      Container(
                        height: videoHeight,
                        width: videoWidth,
                        margin: EdgeInsets.only(left: videoMargin),
                        child: VideoPlayer(_controller),
                      ),
                      _videoOverlay(),
                    ],
                  );
                } else {
                  return Center(
                      heightFactor: 6,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF22A3D2)),
                      ));
                }
              }),
          onTap: () {
            setState(() {
              _overlay = !_overlay;
// <<<<<<< HEAD
//                   if (_overlay) {
//                     doubleTapRHeightFS = videoHeight! - 36;
//                     doubleTapLHeightFS = videoHeight! - 10;
//                     doubleTapRMarginFS = 36;
//                     doubleTapLMarginFS = 10;
//                   } else if (!_overlay) {
//                     doubleTapRHeightFS = videoHeight! + 36;
//                     doubleTapLHeightFS = videoHeight;
//                     doubleTapRMarginFS = 0;
//                     doubleTapLMarginFS = 0;
// =======
              if (_overlay) {
                doubleTapRHeight = videoHeight - 36;
                doubleTapLHeight = videoHeight - 10;
                doubleTapRMargin = 36;
                doubleTapLMargin = 10;
              } else if (!_overlay) {
                doubleTapRHeight = videoHeight + 36;
                doubleTapLHeight = videoHeight;
                doubleTapRMargin = 0;
                doubleTapLMargin = 0;
// >>>>>>> parent of d9fbbc8... 0.1.8
              }
            });
          },
        ),
        GestureDetector(
            child: Container(
// <<<<<<< HEAD
//                   width: doubleTapLWidthFS! / 2 - 30,
//                   height: doubleTapLHeightFS! - 44,
//                   margin:
//                       EdgeInsets.fromLTRB(0, 0, doubleTapLWidthFS! / 2 + 30, 40),
// =======
              width: doubleTapLWidth / 2 - 30,
              height: doubleTapLHeight - 44,
              margin: EdgeInsets.fromLTRB(0, 0, doubleTapLWidth / 2 + 30, 40),
// >>>>>>> parent of d9fbbc8... 0.1.8
              decoration: BoxDecoration(
                  //color: Colors.red,
                  ),
            ),
            onTap: () {
              setState(() {
                _overlay = !_overlay;
// <<<<<<< HEAD
//                     if (_overlay) {
//                       doubleTapRHeightFS = videoHeight! - 36;
//                       doubleTapLHeightFS = videoHeight! - 10;
//                       doubleTapRMarginFS = 36;
//                       doubleTapLMarginFS = 10;
//                     } else if (!_overlay) {
//                       doubleTapRHeightFS = videoHeight! + 36;
//                       doubleTapLHeightFS = videoHeight;
//                       doubleTapRMarginFS = 0;
//                       doubleTapLMarginFS = 0;
// =======
                if (_overlay) {
                  doubleTapRHeight = videoHeight - 36;
                  doubleTapLHeight = videoHeight - 10;
                  doubleTapRMargin = 36;
                  doubleTapLMargin = 10;
                } else if (!_overlay) {
                  doubleTapRHeight = videoHeight + 36;
                  doubleTapLHeight = videoHeight;
                  doubleTapRMargin = 0;
                  doubleTapLMargin = 0;
// >>>>>>> parent of d9fbbc8... 0.1.8
                }
              });
            },
            onDoubleTap: () {
              setState(() {
// <<<<<<< HEAD
//                     _controller!.seekTo(Duration(
//                         seconds: _controller!.value.position.inSeconds - 10));
// =======
                _controller.seekTo(Duration(
                    seconds: _controller.value.position.inSeconds - 10));
// >>>>>>> parent of d9fbbc8... 0.1.8
              });
            }),
        GestureDetector(
            child: Container(
// <<<<<<< HEAD
//                   width: doubleTapRWidthFS! / 2 - 45,
//                   height: doubleTapRHeightFS - 80,
//                   margin: EdgeInsets.fromLTRB(doubleTapRWidthFS! / 2 + 45, 0, 0,
//                       doubleTapLMarginFS + 20),
// =======
              width: doubleTapRWidth / 2 - 45,
              height: doubleTapRHeight - 80,
              margin: EdgeInsets.fromLTRB(
                  doubleTapRWidth / 2 + 45, 0, 0, doubleTapLMargin + 20),
// >>>>>>> parent of d9fbbc8... 0.1.8
              decoration: BoxDecoration(
                  //color: Colors.red,
                  ),
            ),
            onTap: () {
              setState(() {
                _overlay = !_overlay;
// <<<<<<< HEAD
//                     if (_overlay) {
//                       doubleTapRHeightFS = videoHeight! - 36;
//                       doubleTapLHeightFS = videoHeight! - 10;
//                       doubleTapRMarginFS = 36;
//                       doubleTapLMarginFS = 10;
//                     } else if (!_overlay) {
//                       doubleTapRHeightFS = videoHeight! + 36;
//                       doubleTapLHeightFS = videoHeight;
//                       doubleTapRMarginFS = 0;
//                       doubleTapLMarginFS = 0;
// =======
                if (_overlay) {
                  doubleTapRHeight = videoHeight - 36;
                  doubleTapLHeight = videoHeight - 10;
                  doubleTapRMargin = 36;
                  doubleTapLMargin = 10;
                } else if (!_overlay) {
                  doubleTapRHeight = videoHeight + 36;
                  doubleTapLHeight = videoHeight;
                  doubleTapRMargin = 0;
                  doubleTapLMargin = 0;
// >>>>>>> parent of d9fbbc8... 0.1.8
                }
              });
            },
            onDoubleTap: () {
              setState(() {
// <<<<<<< HEAD
//                     _controller!.seekTo(Duration(
//                         seconds: _controller!.value.position.inSeconds + 10));
// =======
                _controller.seekTo(Duration(
                    seconds: _controller.value.position.inSeconds + 10));
// >>>>>>> parent of d9fbbc8... 0.1.8
              });
            }),
      ],
    )));
  }

  //================================ Quality ================================//
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          final children = <Widget>[];
          _qualityValues.forEach((elem, value) => (children.add(new ListTile(
              title: new Text(" ${elem.toString()} fps"),
              onTap: () => {
// <<<<<<< HEAD
//                     //Обновление состояние приложения и перерисовка
//                     setState(() {
//                       _controller!.pause();
//                       _controller = VideoPlayerController.network(value);
//                       _controller!.setLooping(true);
//                       _seek = true;
//                       initFuture = _controller!.initialize();
//                       _controller!.play();
//                     }),
//                   }))));
// =======
                    //Обновление состояние приложения и перерисовка
                    setState(() {
                      _controller.pause();
                      _controller = VideoPlayerController.network(value);
                      _controller.setLooping(true);
                      _seek = true;
                      initFuture = _controller.initialize();
                      _controller.play();
                    }),
                  }))));
// >>>>>>> parent of d9fbbc8... 0.1.8

          return Container(
            height: videoHeight,
            child: ListView(
              children: children,
            ),
          );
        });
  }

  //================================ OVERLAY ================================//
  Widget _videoOverlay() {
    return _overlay
        ? Stack(
            children: <Widget>[
              GestureDetector(
                child: Center(
                  child: Container(
                    width: videoWidth,
                    height: videoHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          const Color(0x662F2C47),
                          const Color(0x662F2C47)
                        ],
                      ),
                    ),
// <<<<<<< HEAD
//               Center(
//                 child: IconButton(
//                     padding: EdgeInsets.only(
//                       top: videoHeight! / 2 - 50,
//                       bottom: videoHeight! / 2 - 30,
//                     ),
//                     icon: _controller!.value.isPlaying
//                         ? Icon(Icons.pause, size: 60.0)
//                         : Icon(Icons.play_arrow, size: 60.0),
//                     onPressed: () {
//                       setState(() {
//                         _controller!.value.isPlaying
//                             ? _controller!.pause()
//                             : _controller!.play();
//                       });
//                     }),
//               ),
//               Container(
//                 margin: EdgeInsets.only(
//                     top: videoHeight! - 80, left: videoWidth! + videoMargin - 50),
//                 child: IconButton(
//                     alignment: AlignmentDirectional.center,
//                     icon: Icon(Icons.fullscreen, size: 30.0),
//                     onPressed: () {
//                       setState(() {
//                         _controller!.pause();
//                         SystemChrome.setPreferredOrientations([
//                           DeviceOrientation.portraitDown,
//                           DeviceOrientation.portraitUp
//                         ]);
//                         SystemChrome.setEnabledSystemUIOverlays(
//                             [SystemUiOverlay.top, SystemUiOverlay.bottom]);
//                       });
//                       Navigator.pop(
//                           context, _controller!.value.position.inSeconds);
//                     }),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: videoWidth! + videoMargin - 48),
//                 child: IconButton(
//                     icon: Icon(Icons.settings, size: 26.0),
//                     onPressed: () {
//                       position = _controller!.value.position.inSeconds;
//                       _seek = true;
//                       _settingModalBottomSheet(context);
//                       setState(() {});
//                     }),
//               ),
//               Container(
//                 //===== Ползунок =====//
//                 margin: EdgeInsets.only(
//                     top: videoHeight! - 40, left: videoMargin), //CHECK IT
//                 child: _videoOverlaySlider(),
//               )
//             ],
//           )
//         : Center();
// =======
                  ),
                ),
              ),
              Center(
                child: IconButton(
                    padding: EdgeInsets.only(
                      top: videoHeight / 2 - 50,
                      bottom: videoHeight / 2 - 30,
                    ),
                    icon: _controller.value.isPlaying
                        ? Icon(Icons.pause, size: 60.0)
                        : Icon(Icons.play_arrow, size: 60.0),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    }),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: videoHeight - 80, left: videoWidth + videoMargin - 50),
                child: IconButton(
                    alignment: AlignmentDirectional.center,
                    icon: Icon(Icons.fullscreen, size: 30.0),
                    onPressed: () {
                      setState(() {
                        _controller.pause();
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitDown,
                          DeviceOrientation.portraitUp
                        ]);
                        SystemChrome.setEnabledSystemUIOverlays(
                            [SystemUiOverlay.top, SystemUiOverlay.bottom]);
                      });
                      Navigator.pop(
                          context, _controller.value.position.inSeconds);
                    }),
              ),
              Container(
                margin: EdgeInsets.only(left: videoWidth + videoMargin - 48),
                child: IconButton(
                    icon: Icon(Icons.settings, size: 26.0),
                    onPressed: () {
                      position = _controller.value.position.inSeconds;
                      _seek = true;
                      _settingModalBottomSheet(context);
                      setState(() {});
                    }),
              ),
              Container(
                //===== Ползунок =====//
                margin: EdgeInsets.only(
                    top: videoHeight - 40, left: videoMargin), //CHECK IT
                child: _videoOverlaySlider(),
              )
            ],
          )
        : Center(
            child: Container(
              height: 5,
              width: videoWidth,
              margin: EdgeInsets.only(top: videoHeight - 5),
              child: VideoProgressIndicator(
                _controller,
                allowScrubbing: true,
                colors: VideoProgressColors(
                  playedColor: Color(0xFF22A3D2),
                  backgroundColor: Color(0x5515162B),
                  bufferedColor: Color(0x5583D8F7),
                ),
                padding: EdgeInsets.only(top: 2),
              ),
            ),
          );
// >>>>>>> parent of d9fbbc8... 0.1.8
  }

  //=================== ПОЛЗУНОК ===================//
  Widget _videoOverlaySlider() {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, VideoPlayerValue value, child) {
        if (!value.hasError && value.initialized) {
          return Row(
            children: <Widget>[
              Container(
                width: 46,
                alignment: Alignment(0, 0),
                child: Text(value.position.inMinutes.toString() +
                    ':' +
                    (value.position.inSeconds - value.position.inMinutes * 60)
                        .toString()),
              ),
              Container(
                height: 20,
                width: videoWidth - 92,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Color(0xFF22A3D2),
                    backgroundColor: Color(0x5515162B),
                    bufferedColor: Color(0x5583D8F7),
                  ),
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                ),
              ),
              Container(
                width: 46,
                alignment: Alignment(0, 0),
                child: Text(value.duration.inMinutes.toString() +
                    ':' +
                    (value.duration.inSeconds - value.duration.inMinutes * 60)
                        .toString()),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
