// ignore_for_file: file_names

import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/models/deckModel.dart';
import 'package:gorillacards/modules/FlashCardPage/FlashCardPageController.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/widgets/CustomAppBar.dart';
import 'package:gorillacards/shared/widgets/CustomFlashCard.dart';
import 'package:sizer/sizer.dart';

class FlashCardPage extends GetView<FlashCardPageController> {
  const FlashCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    List<Content> flashCards = arguments[0];
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Swiper(
                  itemCount: flashCards.length,
                  layout: SwiperLayout.TINDER,
                  loop: false,
                  itemWidth: 100.w,
                  itemHeight: 100.h,
                  onIndexChanged: (value) {
                    controller.isSelectedIndex.value = -1;
                    controller.selectedChoice.value = "";
                  },
                  itemBuilder: (context, index) {
                    return FlipCard(
                      front: CustomFlashCard(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.h,
                          child: Text(
                            flashCards[index].front,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                      back: CustomFlashCard(
                        child: Container(
                          height: 50.h,
                          alignment: Alignment.center,
                          child: Text(
                            flashCards[index].back,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              AppSpacer.h1,
              Padding(
                padding: AppPaddings.generalPadding,
                child: Text(
                  "Karşılığı nedir?",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.black,
                      ),
                ),
              ),
              AppSpacer.h3,
              Expanded(
                flex: 3,
                child: GridView.builder(
                  padding: AppPaddings.generalPadding,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2.h,
                    crossAxisSpacing: 4.w,
                    childAspectRatio: 2.2.sp,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return _Choice(
                      onTap: () {
                        controller.isSelectedIndex.value = index;
                        controller.selectedChoice.value =
                            "Seçenek ${index + 1}";
                      },
                      title: "Seçenek ${index + 1}",
                      isSelectedIndex: controller.isSelectedIndex,
                      index: index,
                    );
                  },
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

class _Choice extends StatelessWidget {
  final String title;
  final RxInt isSelectedIndex;
  final int index;
  final void Function()? onTap;
  const _Choice({
    required this.title,
    required this.isSelectedIndex,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Bounceable(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: AppPaddings.h3v1Padding,
          decoration: BoxDecoration(
            color: isSelectedIndex.value == index
                ? AppColors.primary
                : AppColors.drWhite,
            borderRadius: AppBorderRadius.generalRadius,
            border: Border.all(
              width: .3.w,
              color: AppColors.bellflowerBlue,
            ),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: isSelectedIndex.value == index
                      ? AppColors.white
                      : AppColors.black,
                ),
          ),
        ),
      ),
    );
  }
}
