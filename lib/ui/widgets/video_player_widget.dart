import 'package:flutter/material.dart';
import 'package:flutter_in_app_pip/picture_in_picture.dart';
import 'package:flutter_in_app_pip/pip_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoAsset;
  final bool isPip;

  const VideoPlayerWidget({
    required this.videoAsset,
    super.key,
    required this.isPip,
  });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VlcPlayerController _controller;
  bool _isVideoReady = false;

  @override
  void initState() {
    super.initState();

    _loadVideo();
  }

  Future<void> _loadVideo() async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      setState(() {
        _isVideoReady = true;
      });

      if (isValidVideoUrl(widget.videoAsset)) {
        _controller = VlcPlayerController.network(
          widget.videoAsset,
          autoPlay: true,
          // options: VlcPlayerOptions(),
          // hwAcc: HwAcc.full,
        );
      } else {
        _controller = VlcPlayerController.asset(
          'assets/sample_video.mp4',
          autoPlay: true,
          // options: VlcPlayerOptions(),
          // hwAcc: HwAcc.full,
        );
      }
    } catch (e) {
      print("Error loading video: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
          children: [
            if (!_isVideoReady)
              Center(
                child: Lottie.asset(
                  'assets/camera-loading.json',
                  width: 200,
                  height: 200,
                ),
              )
            else
              Positioned.fill(
                child: VlcPlayer(
                  controller: _controller,
                  virtualDisplay: true,
                  aspectRatio: _controller.value.aspectRatio,
                ),
              ),
            Positioned(
              top: 10.0,
              right: 10.0,
              child: IconButton(
                onPressed: () {
                  if (!widget.isPip) {
                    PictureInPicture.startPiP(
                      pipWidget: PiPWidget(
                        onPiPClose: () {},
                        elevation: 10,
                        pipBorderRadius: 10,
                        child: VideoPlayerWidget(
                          videoAsset: widget.videoAsset,
                          isPip: true,
                        ),
                      ),
                    );
                  } else {
                    PictureInPicture.stopPiP();
                  }
                },
                icon: !widget.isPip
                    ? const Icon(
                        Icons.picture_in_picture,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ),
          ],
        ),
    );
  }

  bool isValidVideoUrl(String url) {
    final Uri? uri = Uri.tryParse(url);

    if (uri != null && uri.scheme.startsWith('http') && url.toLowerCase().endsWith('.mp4')) {
      return true;
    }
    return false;
  }
}
