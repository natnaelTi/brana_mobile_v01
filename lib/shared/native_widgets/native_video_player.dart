import 'package:flutter/cupertino.dart';

class NativeVideoPlayer extends StatelessWidget {
  NativeVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.videoPlaybackStatusStream,
  }) : super(key: key);

  final String videoUrl;
  Stream<dynamic> videoPlaybackStatusStream;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}