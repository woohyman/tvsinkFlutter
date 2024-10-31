import 'package:get/get.dart';
import 'package:tv_sink/util/log_util.dart';

import '../../domain/download_manager.dart';

class ParseM3uLogic extends GetxController {
  final _downloadController = DownloadController();
  final _downloadInfo = "".obs;

  get downloadInfo {
    return _downloadInfo.value;
  }

  void fetchRemoteData(String url) {
    _downloadController.fetchRemoteData(url).listen(
      (data) {
        _downloadInfo.value = data;
      },
    );
  }
}
