import 'package:calendar_app/pages/calendar/widgets/week_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database_bloc.dart';
import '../../../database/note_database.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/app_text.dart';
import '../../selected_day/selected_day_bloc.dart';
import '../caledar_bloc/change_period_bloc.dart';
import 'add_note_widget.dart';
import 'day_widget.dart';

class MonthWidget extends StatefulWidget {
  MonthWidget(
      {super.key,
      required this.month,
      required this.year,
      required this.day,
      required this.week});

  final String month;
  final String year;
  final String day;
  final String week;

  @override
  State<MonthWidget> createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ChangePeriodBloc>(context);

    DateTime now = DateTime.now();
    int selectedDay = 1;
    bool tapped = false;
    return BlocProvider(
        create: (context) => SelectedDayBloc(),
        child: BlocConsumer<SelectedDayBloc, SelectedDayState>(
            listener: (context, state) {},
            builder: (context, selectedDayState) {
              var selectedDayBloc = BlocProvider.of<SelectedDayBloc>(context);
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          widget.month,
                          fontWeight: FontWeight.w500,
                          size: 18,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  int monthNum =
                                      monthNameToNumber(widget.month) ?? 1;
                                  monthNum = monthNum - 1;
                                  String newMonth =
                                      monthNumberToName(monthNum) ?? 'Januar';
                                  if (monthNum >= 1) {
                                    bloc.add(MonthPeriodEvent(month: newMonth));
                                  }
                                },
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.greyWhite,
                                ),
                                color: AppColors.grey,
                                icon: const Icon(Icons.arrow_back_ios_new)),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                onPressed: () {
                                  int monthNum =
                                      monthNameToNumber(widget.month) ?? 1;
                                  monthNum = monthNum + 1;
                                  String newMonth =
                                      monthNumberToName(monthNum) ?? 'January';
                                  if (monthNum <= 12) {
                                    bloc.add(MonthPeriodEvent(month: newMonth));
                                  } else {
                                    null;
                                  }
                                },
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.greyWhite,
                                ),
                                color: AppColors.grey,
                                icon:
                                    const Icon(Icons.arrow_forward_ios_rounded))
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocProvider(
                    create: (context) =>
                        DatabaseBloc(noteDatabase: NoteDatabase())
                          ..add(DatabaseInitEvent(getDateData: '')),
                    child: BlocConsumer<DatabaseBloc, DatabaseState>(
                        listener: (context, state) {},
                        builder: (context, databaseState) {
                          var databaseBloc =
                              BlocProvider.of<DatabaseBloc>(context);
                          // databaseBloc.add(DatabaseInitEvent(
                          //     getDateData:
                          //     '${widget.year}${monthNameToNumber(widget.month)}${widget.day}'));

                          return Column(
                            children: [
                              SizedBox(
                                height: 20,
                                width: MediaQuery.of(context).size.width / 1,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 7,
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(right: 2),
                                          alignment: Alignment.centerRight,
                                          width: 50,
                                          child: AppText(
                                            '${weekNumberToNameShort(index + 1)}',
                                            color: AppColors.grey,
                                            fontWeight: FontWeight.w500,
                                            // size: ,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              if (selectedDayState is OnSelectedDayState) ...{
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Wrap(
                                    spacing: 23.7,
                                    runSpacing: 20,
                                    children: List.generate(
                                      getDaysInMonth(int.parse(widget.year),
                                          monthNameToNumber(widget.month)!),
                                      (monthIndex) {
                                        return GestureDetector(
                                            onTap: () {
                                              selectedDay = monthIndex + 1;

                                              selectedDayBloc.add(
                                                  OnSelectedDayEvent(
                                                      day: '$selectedDay'));
                                            },
                                            child: SizedBox(
                                              width: 30,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 28,
                                                    height: 28,
                                                    decoration: BoxDecoration(
                                                        color: (monthIndex + 1)
                                                                    .toString() ==
                                                                selectedDayState
                                                                    .day
                                                            ? AppColors
                                                                .primaryColor
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    50))),
                                                    child: AppText(
                                                      '${monthIndex + 1}',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      size: 14,
                                                      color: (monthIndex + 1)
                                                                  .toString() ==
                                                              selectedDayState
                                                                  .day
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  // },
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  SizedBox(
                                                      width: 20,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          if (databaseState
                                                              is DatabaseLoadedState) ...{
                                                            SizedBox(
                                                              height: 5,
                                                              width: 20,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: databaseState
                                                                          .notes
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        var priority = databaseState
                                                                            .notes[index]
                                                                            .priority;
                                                                        return Visibility(
                                                                          visible:
                                                                              databaseState.notes[index].sortId == '${widget.year}${monthNameToNumber(widget.month)}${monthIndex + 1}',
                                                                          child: Container(
                                                                              margin: EdgeInsets.only(left: 2),
                                                                              padding: const EdgeInsets.all(2.2),
                                                                              decoration: BoxDecoration(
                                                                                  color: priority == '1'
                                                                                      ? AppColors.red
                                                                                      : priority == '2'
                                                                                          ? AppColors.blue
                                                                                          : priority == '3'
                                                                                              ? AppColors.orange
                                                                                              : Colors.transparent,
                                                                                  borderRadius: const BorderRadius.all(Radius.circular(50)))),
                                                                        );
                                                                      }),
                                                            )
                                                          },
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ));
                                      },
                                    ),
                                  ),
                                )
                              }
                            ],
                          );
                        }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  if (selectedDayState is OnSelectedDayState) ...{
                    AddEventWidget(
                        month: widget.month,
                        year: widget.year,
                        day: widget.day,
                        week: widget.week,
                        selectedDay: selectedDayState.day)
                  } else ...{
                    AddEventWidget(
                      month: widget.month,
                      year: widget.year,
                      day: widget.day,
                      week: widget.week,
                    )
                  }
                ],
              );
            }));
  }
}

int? monthNameToNumber(String monthName) {
  const monthNames = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'October': 10,
    'November': 11,
    'December': 12,
  };

  return monthNames[monthName];
}

String? monthNumberToName(int monthNumber) {
  const monthNames = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };

  return monthNames[monthNumber];
}
