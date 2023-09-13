// ignore_for_file: file_names

import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/models/deckModel.dart';
import 'package:gorillacards/modules/FlashCardPage/FlashCardPageController.dart';
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
            children: [
              Expanded(
                flex: 2,
                child: Swiper(
                  itemCount: flashCards.length,
                  layout: SwiperLayout.TINDER,
                  loop: false,
                  itemWidth: 100.w,
                  itemHeight: 100.h,
                  itemBuilder: (context, index) {
                    return FlipCard(
                      front: CustomFlashCard(
                        child: Container(
                          height: 60.h,
                          alignment: Alignment.center,
                          child: Text(
                            flashCards[index].front,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                      back: CustomFlashCard(
                        child: Container(
                          height: 60.h,
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
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
