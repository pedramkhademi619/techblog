import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tech/controller/register_controller.dart';

import '../../gen/assets.gen.dart';
import '../../components/constants/strings.dart';
import 'package:validators/validators.dart';

class RegisterIntro extends StatelessWidget {
  RegisterIntro({super.key});
  final registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    var texttheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.icons.techbot.path,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: MyStrings.welcome, style: texttheme.titleSmall),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _showEmailBottomSheet(context, size, texttheme);
            },
            child: const Text(
              "بزن بریم",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      )),
    ));
  }

  Future<dynamic> _showEmailBottomSheet(
      BuildContext context, Size size, TextTheme texttheme) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                width: double.infinity,
                height: size.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      MyStrings.insertEmail,
                      style: texttheme.titleSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller:
                            registerController.emailTextEditingController,
                        onChanged: (value) {
                          isEmail(value);
                        },
                        style: texttheme.titleMedium,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: "techblog@gmail.com",
                            hintStyle: texttheme.titleMedium),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          registerController.register();

                          Get.back();
                          _activateCodeBottomSheet(context, size, texttheme);
                        },
                        child: const Text(
                          "ادامه",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ));
  }

  Future<dynamic> _activateCodeBottomSheet(
      BuildContext context, Size size, TextTheme texttheme) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                width: double.infinity,
                height: size.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      MyStrings.activateCode,
                      style: texttheme.titleSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: registerController
                            .activateCodeTextEditingController,
                        onChanged: (value) {},
                        style: texttheme.titleMedium,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          
                            hintText: "******",
                            hintStyle: texttheme.titleMedium),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          registerController.verify();
                        },
                        child: const Text(
                          "ادامه",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ));
  }
}
