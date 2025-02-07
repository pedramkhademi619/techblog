import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech/components/constants/api_constants.dart';
import 'package:tech/components/constants/commands.dart';
import 'package:tech/gen/assets.gen.dart';
import 'package:tech/main.dart';
import 'package:tech/services/dio_service.dart';
import 'dart:developer' as developer;
import 'package:tech/components/constants/storage_const.dart';
import 'package:tech/view/main_screen/main_screen.dart';
import 'package:tech/view/register/register_intro.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activateCodeTextEditingController =
      TextEditingController();
  var email = '';
  var userId = '';
  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      "command": Commands.register
    };
    var response =
        await DioService().postMethod(map, ApiUrlConstants.postRegister);
    email = emailTextEditingController.text;
    userId = response.data[ApiArticleKeyConstants.userId];
    developer.log(response.data.toString(), name: "register_response");
  }

  verify() async {
    Map<String, dynamic> map = {
      ApiArticleKeyConstants.email: email,
      ApiArticleKeyConstants.command: Commands.verify,
      ApiArticleKeyConstants.userId: userId,
      ApiArticleKeyConstants.code: activateCodeTextEditingController.text
    };
    developer.log(map.toString(), name: "map");
    var response =
        await DioService().postMethod(map, ApiUrlConstants.postRegister);
    developer.log(response.toString(), name: "response");
    var status = response.data["response"];

    switch (status) {
      case 'verified':
        var box = GetStorage();
        await box.write(StorageKey.token, response.data[StorageKey.token]);
        await box.write(StorageKey.userId, response.data[StorageKey.userId]);
        Get.offAll(() => MainScreen());

        break;
      case 'incorrect_code':
        Get.snackbar("خطا", "کد فعالسازی نادرست است.");

        ///
        break;
      case 'expired':
        Get.snackbar("خطا", "کد فعالسازی منقضی شده است.");

        ///
        break;
    }
  }

  toggleLogin() {
    if (GetStorage().read(StorageKey.token) == null) {
      Get.off(RegisterIntro());
    } else {
      routeToWriteBottomSheet();
    }
  }

  routeToWriteBottomSheet() {
    Get.bottomSheet(Container(
      height: Get.height / 3,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  Assets.icons.techbot.path,
                  height: 40,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text("دانسته هات رو با بقیه به اشتراک بزار"),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              """
فکر کن !!  اینجا بودنت به این معناست که یک گیک تکنولوژی هستی
دونسته هات رو با  جامعه‌ی گیک های فارسی زبان به اشتراک بذار..
""",
              style: Get.textTheme.titleMedium,
            ),
            // const SizedBox(height: 100,),
            const Expanded(child: SizedBox.shrink()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(NamedRoute.manageArticle);
                  },
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Image.asset(Assets.icons.writeArticle.path, height: 32),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text("مدیریت مقاله")
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    developer.log("go to podcast");
                  },
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Image.asset(Assets.icons.writePodcast.path, height: 32),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text("مدیریت پادکست"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    ));
  }
}
