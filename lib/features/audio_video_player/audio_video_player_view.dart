import 'package:berana/features/audio_video_player/audio_video_player_viewmodel.dart';
import 'package:berana/layouts/root_layout/root_layout.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AudioVideoPlayerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AudioVideoPlayerViewModel>.reactive(
        viewModelBuilder: () => AudioVideoPlayerViewModel(),
        builder: (context, viewModel, child) {
          return RootLayout(
              showBackButton: true,
              child: Column(
                children: [
                  VideoPlayer(viewModel.videoPlayerController),
                ],
              )
          );
        });
  }
}
