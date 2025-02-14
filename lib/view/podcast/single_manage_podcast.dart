import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tech/Models/pod_cast_model.dart';
import 'package:tech/components/constants/dimens.dart';
import 'package:tech/components/constants/my_colors.dart';
import 'package:tech/components/decorations.dart';
import 'package:tech/components/my_components.dart';
import 'package:tech/controller/pod_cast.dart/single_podcast_controller.dart';
import 'package:tech/gen/assets.gen.dart';
import 'dart:developer' as developer;

class SinglePodcast extends StatelessWidget {
  SinglePodcastController? controller;
  late PodCastModel podCastModel;
  SinglePodcast({super.key}) {
    podCastModel = Get.arguments;
    controller = Get.put(SinglePodcastController(id: podCastModel.id));
    developer.log(controller!.player.toString());
  }

  @override
  Widget build(BuildContext context) {
    developer.log(controller!.id.toString(), name: "");
    return SafeArea(
        child: Scaffold(
            body: Obx(
      () => Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: Get.height / 3,
                          width: double.infinity,
                          child: CachedNetworkImage(
                              placeholder: (context, url) => loading(),
                              errorWidget: (context, url, err) => const Icon(
                                    Icons.image_not_supported,
                                    size: 60,
                                  ),
                              imageUrl: podCastModel.poster!,
                              imageBuilder: (context, imageProvider) => Image(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                  )),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors:
                                        GradiantColors.singleAppbarGradiant)),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.arrow_right,
                                      color: Colors.white,
                                    )),
                                const Expanded(child: SizedBox()),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.bookmark_outline,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(Dimens.halfBodyMargin),
                      child: Text(
                        podCastModel.title!,
                        style: Get.textTheme.titleLarge,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.halfBodyMargin),
                          child: Image.asset(
                            Assets.images.avatar.path,
                            height: Get.height / 15,
                          ),
                        ),
                        Text(
                          podCastModel.publisher!,
                          style: Get.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller!.podcastFileList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () async {
                                  await controller!.player
                                      .seek(Duration.zero, index: index);

                                  controller!.currentFileIndex.value =
                                      controller!.player.currentIndex!;
                                  if (controller!.playState.value == false) {
                                    controller!.player.play();
                                    controller!.playState.value = true;
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        Assets.icons.bluemic.provider(),
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      SizedBox(
                                          width: Get.width / 1.5,
                                          child: Obx(
                                            () => Text(
                                              controller!.podcastFileList[index]
                                                  .title!,
                                              style: controller!
                                                          .currentFileIndex
                                                          .value ==
                                                      index
                                                  ? Get.textTheme.headlineSmall
                                                  : Get.textTheme.titleSmall,
                                            ),
                                          )),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "${controller!.podcastFileList[index].length!}:00",
                                        style: Get.textTheme.titleSmall,
                                      )
                                    ],
                                  ),
                                ));
                          }),
                    )
                  ]),
            ),
          ),
          Positioned(
              bottom: 8,
              right: Dimens.bodyMargin,
              left: Dimens.bodyMargin,
              child: Container(
                height: Get.height / 7,
                decoration: MyDecoration.mainGradiant,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(() => ProgressBar(
                          timeLabelTextStyle: TextStyle(color: Colors.white),
                          thumbColor: Colors.yellow,
                          baseBarColor: Colors.white,
                          progressBarColor: Colors.orange,
                          onSeek: (position) {
                            controller!.player.seek(position);
                            controller!.player.playing
                                ? controller!.startProgress()
                                : controller!.timer!.cancel();
                          },
                          buffered: controller!.bufferedValue.value,
                          progress: controller!.progressValue.value,
                          total: controller!.player.duration ??
                              const Duration(seconds: 0))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await controller!.player.seekToNext();
                                controller!.currentFileIndex.value =
                                    controller!.player.currentIndex!;
                              },
                              icon: const Icon(
                                Icons.skip_next,
                                color: Colors.white,
                              )),
                          IconButton(
                              //TODO if back to prev page without pause the song
                              // and again navigate to this
                              // page we can play
                              // two or more song at the same time
                              onPressed: () {
                                controller!.player.playing
                                    ? controller!.timer!.cancel()
                                    : controller!.startProgress();
                                controller!.player.playing
                                    ? controller!.player.pause()
                                    : controller!.player.play();
                                controller!.playState.value =
                                    controller!.player.playing;

                                controller!.currentFileIndex.value =
                                    controller!.player.currentIndex!;
                              },
                              icon: Obx(() => Icon(
                                    controller!.playState.value
                                        ? Icons.pause_circle_filled
                                        : Icons.play_circle_filled,
                                    size: 48,
                                    color: Colors.white,
                                  ))),
                          IconButton(
                              onPressed: () async {
                                await controller!.player.seekToPrevious();
                                controller!.currentFileIndex.value =
                                    controller!.player.currentIndex!;
                              },
                              icon: const Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                              )),
                          const SizedBox(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.repeat,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    )));
  }
}
