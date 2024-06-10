import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_bloc.dart';
import '../../database/note_database.dart';
import '../../model/note_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/app_text.dart';
import '../../widgets/app_text_field.dart';
import '../calendar/calendar_page.dart';
import '../calendar/widgets/month_widget.dart';
import '../selected_day/selected_day_bloc.dart';

class CreateNotePage extends StatefulWidget {
  CreateNotePage(
      {Key? key,
      this.year,
      this.month,
      this.week,
      this.day,
      this.model,
      this.selectedDay})
      : super(key: key);

  final String? year;
  final String? month;
  final String? week;
  final String? day;
  final String? selectedDay;
  final NoteModel? model;

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final timeController = TextEditingController();

  final locationController = TextEditingController();

  late String priorityValue = '1';

  // priorityValue = widget.model == null ? '1' : widget.model!.priority;
  @override
  Widget build(BuildContext context) {
    // titleController = TextEditingController(
    //     text: widget.model == null ? '' : widget.model!.title);
    // descriptionController = TextEditingController(
    //     text: widget.model == null ? '' : widget.model!.description);
    //
    // timeController = TextEditingController(
    //     text: widget.model == null ? '' : widget.model!.time);
    //
    // locationController = TextEditingController(
    //     text: widget.model == null ? '' : widget.model!.location);

    return BlocProvider(
      create: (context) => DatabaseBloc(noteDatabase: NoteDatabase())
        ..add(DatabaseInitEvent(getDateData: '')),
      child: Builder(builder: (context) => _buildWidget(context)),
    );
  }

  Widget _buildWidget(BuildContext context) {
    final bloc = BlocProvider.of<DatabaseBloc>(context);
    return BlocConsumer<DatabaseBloc, DatabaseState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'Event name',
                      size: 16,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AppTextField(controller: titleController),
                    SizedBox(
                      height: 18,
                    ),
                    AppText(
                      'Event description',
                      size: 16,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AppTextField(
                      controller: descriptionController,
                      maxLines: 5,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    AppText(
                      'Event location',
                      size: 16,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AppTextField(controller: locationController),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 80,
                      height: 35,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: AppColors.greyWhite),
                      child: DropdownButton(
                        iconEnabledColor: AppColors.primaryColor,
                        onTap: () {},
                        underline: SizedBox(),
                        value: priorityValue,
                        onChanged: (value) {
                          priorityValue = value!;
                        },
                        items: [
                          DropdownMenuItem(
                            value: '1',
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(3),
                              color: AppColors.rerWhite,
                            ),
                            onTap: () {
                              setState(() {
                                priorityValue = '1';
                              });
                            },
                          ),
                          DropdownMenuItem(
                            value: '2',
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(3),
                              color: AppColors.blueWhite,
                            ),
                            onTap: () {
                              setState(() {
                                priorityValue = '2';
                              });
                            },
                          ),
                          DropdownMenuItem(
                            value: '3',
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(3),
                              color: AppColors.orangeWhite,
                            ),
                            onTap: () {
                              setState(() {
                                priorityValue = '3';
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    AppText(
                      'Event time',
                      size: 16,
                      // fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextField(
                      controller: timeController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocProvider(
                        create: (context) => SelectedDayBloc(),
                        child: BlocConsumer<SelectedDayBloc, SelectedDayState>(
                            listener: (context, state) {},
                            builder: (context, selectedDayState) {
                              var changePeriodBloc =
                                  BlocProvider.of<SelectedDayBloc>(context);
                              if (state is DatabaseLoadedState) {
                                return Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final noteModel = NoteModel(
                                        sortId:
                                            '${widget.year}${monthNameToNumber(widget.month!)}${widget.selectedDay ?? widget.day}',
                                        title: titleController.text,
                                        description: descriptionController.text,
                                        time: timeController.text,
                                        location: locationController.text,
                                        priority: priorityValue,
                                        id: '${widget.year}${monthNameToNumber(widget.month!)}${widget.selectedDay ?? widget.day}${state.notes.length}',
                                      );

                                      print('Title:${noteModel.title}');
                                      print('Desc:${noteModel.description}');
                                      print('Time:${noteModel.time}');
                                      print('Loca:${noteModel.location}');
                                      print('prior:${noteModel.priority}');
                                      print('id:${noteModel.id}');
                                      print('sortId:${noteModel.sortId}');

                                      bloc.add(DatabaseCreateEvent(noteModel));

                                      //   bloc.add(DatabaseUpdateEvent(noteModel));
                                      // }

                                      bloc.add(DatabaseInitEvent(
                                          getDateData:
                                              '${widget.year}${monthNameToNumber(widget.month!)}${widget.day}'));

                                      changePeriodBloc
                                          .add(OnSelectedDayEvent());
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
                              } else {
                                SizedBox();
                              }
                              // }
                              return SizedBox();
                            })),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
