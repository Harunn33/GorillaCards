// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/CurriculumTestPage/CurriculumTestPageController.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/widgets/CustomAppBar.dart';

class CurriculumTestPage extends GetView<CurriculumTestPageController> {
  const CurriculumTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: AppPaddings.generalPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSpacer.h3,
            Expanded(
              child: controller.getQuestionType(
                controller.checkQuestionType(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
