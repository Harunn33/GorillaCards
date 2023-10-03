// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/paddings.dart';
import '../../../shared/constants/strings.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    required this.controller,
  });

  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.titleMedium,
      onTapOutside: (event) => controller.searchFocusNode.unfocus(),
      cursorColor: AppColors.black,
      cursorHeight: 2.h,
      focusNode: controller.searchFocusNode,
      controller: controller.searchController,
      onChanged: (value) {
        controller.searchController.addListener(() {
          controller.searchQuery.value = controller.searchController.text;
          controller.searchDecks();
        });
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search_outlined,
          color: AppColors.santasGrey,
        ),
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.santasGrey,
            ),
        hintText: AppStrings.searchFieldHint.tr,
        contentPadding: AppPaddings.h3v1Padding,
      ),
    );
  }
}
