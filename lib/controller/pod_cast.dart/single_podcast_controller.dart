import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tech/Models/podcast_file_model.dart';
import 'package:tech/components/constants/api_constants.dart';
import 'package:tech/services/dio_service.dart';
import "dart:developer" as developer;

class SinglePodcastController extends GetxController {
  var id;
  SinglePodcastController({this.id});
  RxBool loading = false.obs;
  RxBool playState = false.obs;
  RxList<PodcastFileModel> podcastFileList = RxList();
  late ConcatenatingAudioSource playList;
  final player = AudioPlayer();
  RxInt currentFileIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();

    playList = ConcatenatingAudioSource(children: [], useLazyPreparation: true);
    await getPodcastFiles();

    await player.setAudioSource(playList,
        initialIndex: 0, initialPosition: Duration.zero);
  }

  getPodcastFiles() async {
    loading.value = true;
    var response =
        await DioService().getMethod(ApiUrlConstants.podcastFiles + id);
    developer.log(response.toString(),
        name: "response|singlePodcastController");
    if (response.statusCode == 200) {
      for (var element in response.data["files"]) {
        var podcastFileModel = PodcastFileModel.fromJson(element);
        podcastFileList.add(podcastFileModel);
        await playList.add(AudioSource.uri(Uri.parse(podcastFileModel.file!)));
      }

      loading.value = false;
    }
  }

  Rx<Duration> progressValue = const Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = const Duration(seconds: 0).obs;
  Timer? timer;
  startProgress() {
    const tick = Duration(seconds: 1);
    int duration = player.duration!.inSeconds - player.position.inSeconds;

    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
        timer = null;
      }
    }

    timer = Timer.periodic(tick, (timer) {
      duration--;
      progressValue.value = player.position;
      bufferedValue.value = player.bufferedPosition;
      if (duration <= 0) {
        timer.cancel();

        progressValue.value = const Duration(seconds: 0);
        bufferedValue.value = const Duration(seconds: 0);
        currentFileIndex.value += 1;
        if (currentFileIndex.value == playList.length) {
          currentFileIndex.value = 0;
        }
        player.seek(const Duration(seconds: 0), index: currentFileIndex.value);
        startProgress();
      }
    });
  }
}
