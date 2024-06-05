
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_bloc.dart';
import '../../database/note_database.dart';
import '../../model/note_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/app_text.dart';
import '../../widgets/app_text_field.dart';
import '../calendar/calendar_page.dart';

class SelectedNotePage extends StatelessWidget {
  SelectedNotePage({Key? key, required this.model, required this.mainColor})
      : super(key: key);

  final Color mainColor;
  final NoteModel model;
  late final titleController;

  late final descriptionController;

  late final timeController;

  late final locationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
          ),
          Container(
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => CreateNotePage(
                        //               model: model,
                        //             )));

                        _editDialog(context: context, model: model);
                      },
                      child: Container(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            AppText(
                              'Edit',
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    AppText(
                      model.title,
                      textOverflow: TextOverflow.ellipsis,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      size: 25,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    AppText(
                      model.description,
                      textOverflow: TextOverflow.ellipsis,
                      color: Colors.white,
                      size: 10,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.access_time_filled,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 7),
                            AppText(
                              model.time,
                              textOverflow: TextOverflow.ellipsis,
                              color: Colors.white,
                              size: 10,
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        model.location == ''
                            ? SizedBox()
                            : Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 7),
                                  AppText(
                                    model.location,
                                    textOverflow: TextOverflow.ellipsis,
                                    color: Colors.white,
                                    size: 10,
                                  )
                                ],
                              )
                      ],
                    ),
                    SizedBox(
                      height: 110,
                    ),
                    AppText(
                      'Remainder',
                      textOverflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      size: 18,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    AppText(
                      '15 minutes before',
                      textOverflow: TextOverflow.ellipsis,
                      color: AppColors.grey,
                      size: 16,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    AppText(
                      'Description',
                      textOverflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      size: 18,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    AppText(
                      model.description,
                      textOverflow: TextOverflow.ellipsis,
                      color: AppColors.grey,
                      size: 14,
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final noteModel = NoteModel(
                        id: model.id,
                        title: titleController.text,
                        description: descriptionController.text,
                        time: timeController.text,
                        location: locationController.text,
                        priority: model.priority);

                    print('Title:${noteModel.title}');
                    print('Desc:${noteModel.description}');
                    print('Time:${noteModel.time}');
                    print('Loca:${noteModel.location}');
                    print('prior:${noteModel.priority}');
                    print('id:${noteModel.id}');
                    // bloc.add(DatabaseUpdateEvent(noteModel));
                    // } else {
                    //   print('Update:${titleController.text}');

                    //   bloc.add(DatabaseUpdateEvent(noteModel));
                    // }

                    // bloc.add(DatabaseInitEvent(
                    //     getDateData: '${widget.year}${monthNameToNumber(widget.month!)}${widget.day}'));

                    // changePeriodBloc.add(OnSelectedDayEvent());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalendarPage()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.rerWhite,
                      minimumSize: Size(300, 50)),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_forever_rounded,
                        color: AppColors.red,
                      ),
                      AppText(
                        'Delete event',
                        color: Colors.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _editDialog({required BuildContext context, required NoteModel model}) {
    titleController = TextEditingController(text: model.title);

    descriptionController = TextEditingController(text: model.description);

    timeController = TextEditingController(text: model.time);

    locationController = TextEditingController(text: model.location);

    showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(horizontal: 12),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            'Change note',
                            size: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: AppColors.grey,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      AppText(
                        'Note title',
                        size: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AppTextField(
                        controller: titleController,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      AppText(
                        'Description',
                        size: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          height: 120,
                          child: AppTextField(
                            controller: descriptionController,
                          )),
                      SizedBox(
                        height: 18,
                      ),
                      AppText(
                        'Location',
                        size: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AppTextField(
                        controller: locationController,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      AppText(
                        'Time',
                        size: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AppTextField(
                        controller: timeController,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      BlocProvider(
                          create: (context) =>
                              DatabaseBloc(noteDatabase: NoteDatabase()),
                          child: BlocConsumer<DatabaseBloc, DatabaseState>(
                              listener: (context, state) {},
                              builder: (context, selectedDayState) {
                                var bloc =
                                    BlocProvider.of<DatabaseBloc>(context);
                                return Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final noteModel = NoteModel(
                                          id: model.id,
                                          title: titleController.text,
                                          description:
                                              descriptionController.text,
                                          time: timeController.text,
                                          location: locationController.text,
                                          priority: model.priority);

                                      print('Title:${noteModel.title}');
                                      print('Desc:${noteModel.description}');
                                      print('Time:${noteModel.time}');
                                      print('Loca:${noteModel.location}');
                                      print('prior:${noteModel.priority}');
                                      print('id:${noteModel.id}');
                                      bloc.add(DatabaseUpdateEvent(noteModel));
                                      // } else {
                                      //   print('Update:${titleController.text}');

                                      //   bloc.add(DatabaseUpdateEvent(noteModel));
                                      // }

                                      // bloc.add(DatabaseInitEvent(
                                      //     getDateData: '${widget.year}${monthNameToNumber(widget.month!)}${widget.day}'));

                                      // changePeriodBloc.add(OnSelectedDayEvent());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CalendarPage()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        minimumSize: Size(300, 50)),
                                    child: AppText(
                                      'Add',
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                                // }
                                // return SizedBox();
                              })),
                    ],
                  ),
                ),
              ),
            ));
  }
}
