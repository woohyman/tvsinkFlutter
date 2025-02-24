import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:flutter/material.dart';
import 'package:tv_sink/domain/play/play_manager.dart';
import '../model/tv_channel_info_model.dart';
import '../data_provider/play_data_provider.dart';

class MediakitPlayManager extends PlayManager {
  late Player player;

  MediakitPlayManager() {
    player = Player();
    controller = VideoController(player);
    if (appDataProvider.autoSourceSwitch == true) {
      player.stream.error.listen(
        (event) {
          final provider = PlayDataProvider.fromGet();
          try {
            final entry = provider.playUrlMap.entries.firstWhere((value) {
              return !value.value.isConnected;
            });
            playSource(entry.key);
          } catch (_) {}
        },
      );
    }
  }

  @override
  Future<void> playSource(String tvgUrl) async {
    super.playSource(tvgUrl);
    _setResourceAndPlay(tvgUrl);
  }

  @override
  Future<void> playEntry(MapEntry<String, TvChannelInfoModel> entry) async {
    var url = entry.value.tvgUrlList.first;
    if (!appDataProvider.allowPlayback) {
      pause();
      return;
    }

    await innerPlaySource(entry, url);
    _setResourceAndPlay(url);
  }

  void _setResourceAndPlay(String source) async {
    await player.stop();
    await player.open(Media(source), play: false);
    player.play();
  }

  @override
  void pause() async {
    await player.pause();
  }

  @override
  void stop() async {
    await player.stop();
  }

  @override
  void play() async {
    await player.play();
  }

  @override
  void release() async {
    await player.stop();
  }

  @override
  Widget getPlayerWidget() {
    return Video(
      controller: controller,
      height: 250,
    );
  }
}
