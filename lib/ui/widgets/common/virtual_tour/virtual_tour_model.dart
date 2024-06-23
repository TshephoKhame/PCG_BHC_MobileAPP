import 'package:flutter/animation.dart';
import 'package:stacked/stacked.dart';
import 'package:vr_player/vr_player.dart';

class VirtualTourModel extends BaseViewModel {
//TODO: complete sample -> https://pub.dev/packages/vr_player/example
  late VrPlayerController _viewPlayerController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isShowingBar = false;
  bool _isPlaying = false;
  bool _isFullScreen = false;
  bool _isVideoFinished = false;
  bool _isLandscapeOrientation = false;
  bool _isVolumeSliderShown = false;
  bool _isVolumeEnabled = true;
  late double _playerWidth;
  late double _playerHeight;
  String? _duration;
  int? _intDuration;
  bool isVideoLoading = false;
  bool isVideoReady = false;
  String? _currentPosition;
  double _currentSliderValue = 0.1;
  double _seekPosition = 0;

  final List<String> _tours = [
    'https://www.youtube.com/watch?v=n5cOPjtj9sU',
    'https://www.youtube.com/watch?v=bxdKp9Cr-l0',
    'https://www.youtube.com/watch?v=Qps3tQLk9ZE',
    'https://www.youtube.com/watch?v=IG7Jrgl9h1o',
    'https://www.youtube.com/watch?v=iuJqV7Uf9K8',
    'https://www.youtube.com/watch?v=UFu3turh2GI'
  ];

  List<String> get tours => _tours;
}
