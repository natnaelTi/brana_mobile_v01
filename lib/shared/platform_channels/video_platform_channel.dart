import 'dart:async';

import 'package:berana/shared/native_widgets/native_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VideoPlatformChannel extends StatefulWidget {
  final String videoUrl;
  VideoPlatformChannel(
      {
        required this.videoUrl,
        super.key
      }
  );

  @override
  State<VideoPlatformChannel> createState() => _VideoPlatformChannelState();
}

class _VideoPlatformChannelState extends State<VideoPlatformChannel> {
  static const MethodChannel videoPlaybackStatusMethodChannel =
  MethodChannel('berana.app/method/playback/status/video');
  static const EventChannel videoPlaybackStatusEventChannel =
  EventChannel('berana.app/event/playback/status/video');
  //
  static const MethodChannel videoStreamMethodChannel =
  MethodChannel('berana.app/method/stream/video');
  static const EventChannel videoStreamEventChannel =
  EventChannel('berana.app/event/stream/video');

  String _videoPlaybackStatus = 'Playback Status Unknown.';
  late Stream _videoPlaybackStream;

  Future<void> _getVideoPlaybackStatus() async {
    String videoPlaybackstatus;
    try {
      final int? result = await videoPlaybackStatusMethodChannel.invokeMethod('getVideoPlaybackStatus');
      videoPlaybackstatus = ':$result%.:';
    } on PlatformException catch (e) {
      if (e.code == 'NO_VIDEO_PLAYING') {
        videoPlaybackstatus = 'Video is not playing';
        // :TODO handle more errors
      } else {
        videoPlaybackstatus = 'Failed to get video playback status.';
      }
    }
    setState(() {
      _videoPlaybackStatus = videoPlaybackstatus;
    });
  }

  Future<Stream?> _getVideoPlayback() async {
    Stream? videoPlayback;
    try {
      final int? result = await videoStreamMethodChannel.invokeMethod('getVideoPlaybackStatus');
    } on PlatformException catch (e) {
      if (e.code == 'NO_VIDEO_STREAM_RECEIVED') {
        print('No Video Stream Found');
        return null;
        // :TODO handle more errors
      } else {
        print('Failed to get video playback');
      }
    }
    setState(() {
      _videoPlaybackStream = videoPlayback ?? Stream.fromIterable([
        //  :TODO Pass Sample Byte Stream
        //  :TODO Figure out where to store it
      ]);
    });
  }

  @override
  void initState() {
    super.initState();
    videoPlaybackStatusEventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
    videoStreamEventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  void _onEvent(Object? event) {
    //:TODO Make this enum: Pause Play Buffering Error
    setState(() {
      _videoPlaybackStatus =
      ":$event:";
    });
  }

  void _onError(Object error) {
    setState(() {
      _videoPlaybackStatus = 'Unknown error: $error';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_videoPlaybackStatus, key: const Key('Video Playback Status')),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _getVideoPlaybackStatus,
                  child: const Text('Refresh'),
                ),
              ),
            ],
          ),
          Text(_videoPlaybackStatus),
          NativeVideoPlayer(
              videoUrl: widget.videoUrl,
              videoPlaybackStatusStream: _videoPlaybackStream
          )
        ],
      ),
    );
  }
}