import 'package:flutter/material.dart';
import 'package:stella/ui/common.dart';
import 'package:stella/ui/discuss.dart';
import 'package:stella/ui/neumorph.dart';
import 'package:video_player/video_player.dart';

/// ffmpeg -i audio.m4a -i video.mp4 -c:v h264_nvenc -c:a aac -map 0:a:0
/// -map 1:v:0 -b:v 32k -filter:v fps=0.1667 -b:a 24k -ss 00:00:00 -t
/// 00:10:00 out.mp4
class PlayerViewRoute extends StatefulWidget {
  final String title;
  final String subtitle;

  PlayerViewRoute({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  _PlayerViewRouteState createState() => _PlayerViewRouteState(title, subtitle);
}

class _PlayerViewRouteState extends State<PlayerViewRoute> {
  final String title;
  final String subtitle;

  _PlayerViewRouteState(this.title, this.subtitle);

  bool _paused = true;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/video.mp4');
    () async {
      await _videoController.initialize();
      setState(() {});
    }();
  }

  @override
  void dispose() {
    () async {
      await _videoController.pause();
      await _videoController.dispose();
      super.dispose();
    }();
  }

  @override
  Widget build(BuildContext context) {
    return StellaPageScaffold(
      background: _background(),
      body: Column(
        children: [
          _player(),
          Container(height: 10),
          _controlRow(),
          Container(height: 40),
          DiscussBoard(),
        ],
      ),
      topExtent: 120.0,
    );
  }

  Widget _background() {
    StellaThemeData sTheme = StellaThemeData.defaultLight();
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: sTheme.foregroundColor,
                ),
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: sTheme.hintColor,
                  fontWeight: FontWeight.normal,
                ),
            textScaleFactor: 0.92,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: sTheme.padding.left,
        vertical: sTheme.padding.top,
      ),
      alignment: Alignment.topLeft,
    );
  }

  Widget _player() {
    double width = MediaQuery.of(context).size.width;
    if (!_videoController.value.isInitialized)
      return Container(
        width: width,
        height: width / 854 * 400,
      );
    return InkWell(
      child: AspectRatio(
        aspectRatio: _videoController.value.aspectRatio,
        child: VideoPlayer(_videoController),
      ),
      onTap: () async {
        if (_paused)
          await _videoController.play();
        else
          await _videoController.pause();
        _paused = !_paused;
      },
    );
  }

  Widget _controlRow() {
    List<IconData> buttons = [
      Icons.play_arrow,
      Icons.pause,
      Icons.fast_rewind,
      Icons.fast_forward,
      Icons.subtitles,
      Icons.language,
    ];
    return Container(
      child: Row(
        children: buttons
            .map((icon) => Expanded(
                  child: Container(
                    child: neuIconButton(context, icon),
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                  ),
                  flex: 1,
                ))
            .toList(),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: StellaThemeData.defaultLight().padding.left - 6.0),
    );
  }
}
