
import 'package:flutter/material.dart';

import '../model/note_model.dart';
import '../pages/selected_note/selected_note_page.dart';
import '../utils/app_colors.dart';
import 'app_text.dart';

class NoteWidget extends StatelessWidget {
  NoteWidget({super.key, required this.model});

  final NoteModel model;
  late Color mainColor;
  late Color bgColor;


  @override
  Widget build(BuildContext context) {
    if (model.priority == "1") {
      print(model.priority);
      mainColor = AppColors.red;
      bgColor = AppColors.rerWhite;
    } else if (model.priority == "2") {
      mainColor = AppColors.blue;
      bgColor = AppColors.blueWhite;
      print(model.priority);
    } else {
      mainColor = AppColors.orange;
      bgColor = AppColors.orangeWhite;
      print(model.priority);
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectedNotePage(
                      model: model,
                      mainColor: mainColor,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border(top: BorderSide(width: 10, color: mainColor))),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              model.title,
              textOverflow: TextOverflow.ellipsis,
              color: mainColor,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(
              height: 4,
            ),
            AppText(
              model.description,
              textOverflow: TextOverflow.ellipsis,
              color: mainColor,
              size: 10,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      color: mainColor,
                      size: 20,
                    ),
                    AppText(
                      model.time,
                      textOverflow: TextOverflow.ellipsis,
                      color: mainColor,
                      size: 10,
                    )
                  ],
                ),
                const SizedBox(width: 20),
                model.location == ''
                    ? SizedBox()
                    : Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: mainColor,
                            size: 20,
                          ),
                          AppText(
                            model.location,
                            textOverflow: TextOverflow.ellipsis,
                            color: mainColor,
                            size: 10,
                          )
                        ],
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
