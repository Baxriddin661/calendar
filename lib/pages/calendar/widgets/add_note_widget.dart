
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database_bloc.dart';
import '../../../database/note_database.dart';
import '../../../model/note_model.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/note_widget.dart';
import '../../create_note/create_note_page.dart';
import '../../selected_day/selected_day_bloc.dart';
import '../caledar_bloc/change_period_bloc.dart';
import 'month_widget.dart';

class AddEventWidget extends StatelessWidget {
  AddEventWidget(
      {super.key,
      required this.month,
      required this.year,
      required this.day,
      required this.week,
      this.selectedDay});

  final String month;
  final String year;
  final String day;
  final String week;
  final String? selectedDay;

  @override
  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of<ChangePeriodBloc>(context);

    return BlocProvider(
      create: (context) => DatabaseBloc(noteDatabase: NoteDatabase())
        ..add(DatabaseInitEvent(getDateData: '')),
      child: Builder(builder: (context) => _buildWidget(context)),
    );
  }

  Widget _buildWidget(BuildContext context) {
    final bloc = BlocProvider.of<DatabaseBloc>(context);

    return BlocConsumer<DatabaseBloc, DatabaseState>(
        listener: (context, databaseState) {},
        builder: (context, databaseState) {
          return Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: BlocProvider(
                  create: (context) => SelectedDayBloc(),
                  child: BlocConsumer<SelectedDayBloc, SelectedDayState>(
                      listener: (context, selectedDayState) {},
                      builder: (context, selectedDayState) {
                        var selectedDayBloc =
                            BlocProvider.of<SelectedDayBloc>(context);
                        if (selectedDayState is OnSelectedDayState &&
                            databaseState is DatabaseLoadedState) {
                          // selectedDayBloc.add(OnSelectedDayEvent());
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    'Schedule',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateNotePage(
                                                        year: year,
                                                        month: month,
                                                        week: week,
                                                        day: day,
                                                        selectedDay:
                                                            selectedDay)));

                                         },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.blue),
                                      child: AppText(
                                        '+ Add event',
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (databaseState is DatabaseLoadedState) ...{
                                SizedBox(
                                  height: 400,
                                  child: ListView.builder(
                                      itemCount: databaseState.notes.length,
                                      itemBuilder: (context, index) {
                                        return databaseState.notes[index].id ==
                                                '$year${monthNameToNumber(month)}$selectedDay'
                                            ? NoteWidget(
                                                model: NoteModel(
                                                    title: databaseState
                                                        .notes[index].title,
                                                    description: databaseState
                                                        .notes[index]
                                                        .description,
                                                    time: databaseState
                                                        .notes[index].time,
                                                    location: databaseState
                                                        .notes[index].location,
                                                    priority: databaseState
                                                        .notes[index].priority,
                                                    id: '$year $month $week $day'))
                                            : SizedBox();
                                      }),
                                )
                              }
                              // }
                            ],
                          );
                        }
                        return SizedBox();
                      })));
        });
  }
}
