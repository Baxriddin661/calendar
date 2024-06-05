

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({Key? key, required this.controller, this.maxLines = 1}) : super(key: key);
  final controller;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
          color: AppColors.greyWhite,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  color: AppColors.greyWhite,
                  width: 1,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                    color: AppColors.primaryColor, width: 1)),
          ),
        ));
  }
}
