import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tech/Models/fake_data.dart';
import 'package:tech/gen/assets.gen.dart';
import 'package:tech/components/my_colors.dart';
import 'package:tech/components/my_components.dart';
import 'package:tech/components/strings.dart';
import 'package:tech/view/main_screen.dart';

class MyCats extends StatefulWidget {
  const MyCats({super.key});

  @override
  State<MyCats> createState() => _MyCatsState();
}

class _MyCatsState extends State<MyCats> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width * 0.1;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: bodyMargin),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.icons.techbot.path,
                height: 100,
              ),
              Text(MyStrings.successfulRegistration,
                  style: textTheme.titleSmall),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: bodyMargin),
                child: TextField(
                  onSubmitted: (value) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (builder) => const MainScreen()));
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: "نام و نام خانوادگی",
                    hintStyle: textTheme.titleSmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                MyStrings.chooseCats,
                style: textTheme.titleSmall,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 85,
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tagList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              crossAxisCount: 2,
                              childAspectRatio: .3),
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains(tagList[index])){
                                  selectedTags.add(tagList[index]);
                                }
                              });
                            },
                            child:
                                MainTags(index: index, textTheme: textTheme));
                      }),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Image.asset(
                Assets.icons.downCatArrow.path,
                scale: 3,
              ),

              //selected tags
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 85,
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: selectedTags.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              crossAxisCount: 2,
                              childAspectRatio: .2),
                      itemBuilder: (context, index) {
                        return Container(
                                decoration: const BoxDecoration(
                                    color: SolidColors.surface,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24))),
                                height: 60,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 8, 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        selectedTags[index].title,
                                        style: textTheme.titleSmall,
                                      ),
                                       IconButton(onPressed: (){setState(() {
                                         selectedTags.removeAt(index);
                                       });},
                                        icon:  const Icon(
                                          CupertinoIcons.delete,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ;
                      }),
                ),
              ),
            ],
          )),
        ),
      ),
    ));
  }
}
