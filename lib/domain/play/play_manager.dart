import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:flutter/material.dart';
import 'package:tv_sink/domain/model/transform.dart';
import '../../data/db/channel_type_enum.dart';
import '../../data/db/tv_channels_repository.dart';
import '../data_provider/base/histroty_list_data_provider.dart';
import '../data_provider/play_data_provider.dart';
import '../model/tv_channel_info_model.dart';
import '../ad/ad_manager.dart';
import '../data_provider/app_set_data_provider.dart';

abstract class PlayManager {
  factory PlayManager.fromGet() {
    return Get.find<PlayManager>();
  }

  PlayManager();

  final appDataProvider = AppSetDataProvider.fromGet();
  late VideoController controller;
  final adManager = AdManager.fromGet();
  String curDataSource = "";

  @mustCallSuper
  void playSource(String tvgUrl) {
    PlayDataProvider.fromGet().setUrl(tvgUrl);
  }

  Future<void> playEntry(MapEntry<String, TvChannelInfoModel> entry);

  Future<void> innerPlaySource(
      MapEntry<String, TvChannelInfoModel> entry, String url) async {
    PlayDataProvider.fromGet().setUser(entry);
    PlayDataProvider.fromGet().setUrl(url);

    await adManager?.showInterstitialAd();
    HistoryListDataProvider.fromGet().setList(entry);
  }

  void pause();

  void stop();

  void play();

  void release();

  Widget getPlayerWidget();
}
