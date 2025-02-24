import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:tv_sink/domain/ad/ad_manager.dart';
import 'package:tv_sink/domain/data_provider/base/histroty_list_data_provider.dart';
import 'package:tv_sink/domain/data_provider/play_list_data_provider.dart';
import 'package:tv_sink/pages/scaffold/logic.dart';
import 'package:tv_sink/pages/scaffold/widget/ad/logic.dart';
import 'package:tv_sink/pages/scaffold/widget/list/logic.dart';
import 'package:universal_platform/universal_platform.dart';
import '../domain/app_lifecycle_reactor.dart';
import '../domain/data_provider/app_set_data_provider.dart';
import '../domain/data_provider/play_data_provider.dart';
import '../domain/data_provider/user_data_provider.dart';
import '../domain/play/ijk_play_manager.dart';
import '../domain/play/mediakit_play_manager.dart';
import '../domain/play/play_manager.dart';
import '../domain/upgrade/upgrade_manager.dart';
import '../domain/upgrade/upgrade_data_provider.dart';
import '../util/const.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserDataProvider());

    if(UniversalPlatform.isAndroid){
      Get.put(AdManager());
      Get.put(UpgradeManager());
    }

    Get.put(SupabaseClient(supabaseUrl, supabaseKey));
    Get.put(OptionalPlayListDataProvider());
    Get.put(CollectPlayListDataProvider());
    Get.put(HistoryListDataProvider());
    Get.put(PlayDataProvider());
    Get.put(UpgradeDataProvider());
    Get.put(AppSetDataProvider());

    Get.put(ScaffoldLogic());
    Get.put(PlayListLogic<FeaturePlayListDataProvider>());
    Get.put(PlayListLogic<OptionalPlayListDataProvider>());
    Get.put(PlayListLogic<CollectPlayListDataProvider>());
    Get.put(AdLogic());

    if (UniversalPlatform.isAndroid) {
      Get.put<PlayManager>(IjkPlayManager());
    } else {
      Get.put<PlayManager>(MediakitPlayManager());
    }

    WidgetsBinding.instance.addObserver(AppLifecycleReactor());
  }
}
