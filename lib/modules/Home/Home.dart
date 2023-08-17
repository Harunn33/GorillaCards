// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Home/HomeController.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/fonts.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/enums/images.dart';
import 'package:gorillacards/shared/widgets/CustomButton.dart';
import 'package:sizer/sizer.dart';

import '../../routes/app_pages.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: Padding(
          padding: AppPaddings.generalPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Images.appLogo.png,
              Bounceable(
                onTap: () {
                  controller.signinController.box.remove("token");
                  Get.offAllNamed(Routes.WELCOME);
                },
                child: Images.settings.svg,
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: AppPaddings.generalPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: controller.allDecks.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppStrings.noDecksYet,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  : Obx(
                      () => ListView.builder(
                        itemCount: controller.allDecks.length,
                        padding: EdgeInsets.only(top: 2.h),
                        itemBuilder: (context, index) {
                          return _CustomDeckCardItem(
                              index: index, context: context);
                        },
                      ),
                    ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => CustomButton(
                        onTap: controller.buttonDisabled.value
                            ? null
                            : () {
                                controller.allRemoveText();
                                controller.createBottomSheet(context);
                                // controller.handleCreateDeck();
                              },
                        text: AppStrings.addDeck,
                        bg: AppColors.primary,
                        textColor: AppColors.white,
                        hasIcon: true,
                      ),
                    ),
                  ),
                  AppSpacer.w3,
                  Expanded(
                    child: CustomButton(
                      onTap: () {},
                      text: AppStrings.browse,
                      icon: Icons.search,
                      bg: AppColors.primary,
                      textColor: AppColors.white,
                      hasIcon: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // DECK CARD ITEM
  Bounceable _CustomDeckCardItem(
      {required int index, required BuildContext context}) {
    return Bounceable(
      onTap: () {},
      child: SwipeActionCell(
        backgroundColor: Colors.transparent,
        key: ValueKey(controller.allDecks[index].id),
        trailingActions: <SwipeAction>[
          _SwipeAction(
            title: AppStrings.delete,
            icon: Icons.delete_outlined,
            onTap: () {},
          ),
          _SwipeAction(
            title: AppStrings.edit,
            icon: Icons.edit_outlined,
            onTap: () {},
            color: AppColors.santasGrey,
          ),
        ],
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: .5.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.santasGrey.withOpacity(.15),
            borderRadius: BorderRadius.circular(
              6.sp,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
            vertical: 1.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.allDecks[index].name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 12.sp,
                    ),
              ),
              Text(
                controller.allDecks[index].totalItem.toString(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.black,
                      fontSize: 12.sp,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Swipe Action Buttons
  SwipeAction _SwipeAction(
      {required String title,
      required IconData icon,
      required void Function() onTap,
      Color? color}) {
    return SwipeAction(
      forceAlignmentToBoundary: true,
      backgroundRadius: 6.sp,
      title: title,
      icon: Icon(
        icon,
        color: AppColors.white,
      ),
      style: TextStyle(
        fontSize: 10.sp,
        color: AppColors.white,
        fontFamily: AppFonts.medium,
      ),
      onTap: (CompletionHandler handler) async {
        await handler(true);
        onTap();
      },
      color: color ?? AppColors.red,
    );
  }
}
