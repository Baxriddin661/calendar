

import 'package:calendar_app/pages/calendar/widgets/day_widget.dart';
import 'package:calendar_app/pages/calendar/widgets/month_widget.dart';
import 'package:calendar_app/pages/calendar/widgets/week_widget.dart';
import 'package:calendar_app/pages/calendar/widgets/year_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/app_text.dart';
import 'caledar_bloc/change_period_bloc.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late String monthValue = 'Month';
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentMonth = DateFormat('MMMM').format(now);
    return BlocProvider(
      create: (context) =>
          ChangePeriodBloc()..add(InitPeriodEvent(month: currentMonth)),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  List<DateTime> getAllDatesInYear(int year) {
    List<DateTime> dates = [];
    DateTime currentDate = DateTime(year, 1, 1);
    DateTime endDate = DateTime(year + 1, 1, 1);

    while (currentDate.isBefore(endDate)) {
      dates.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dates;
  }

  Widget _buildPage(BuildContext context) {
    // BlocProvider.of<CreateApplicationBloc>(context);
    final bloc = BlocProvider.of<ChangePeriodBloc>(context);
    DateTime now = DateTime.now();
    String currentDay = DateFormat('dd MMMM yyyy').format(now);
    String currentWeekDay = DateFormat('EEEE').format(now);

    return BlocConsumer<ChangePeriodBloc, PeriodChangeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        Spacer(),
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            AppText(
                              currentWeekDay,
                              fontWeight: FontWeight.w600,
                            ),
                            Row(
                              children: [
                                AppText(
                                  currentDay,
                                  size: 12,
                                ),
                                Container(
                                  width: 70,
                                  height: 30,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    child: DropdownButton(
                                      onTap: () {

                                      },
                                      underline: SizedBox(),
                                      value: monthValue,
                                      onChanged: (value) {
                                        monthValue = value!;
                                      },
                                      items: [
                                        DropdownMenuItem(
                                          value: 'Year',
                                          child: AppText(
                                            'Year',
                                            size: 12,
                                          ),
                                          onTap: () {
                                            bloc.add(YearPeriodEvent());
                                          },
                                        ),
                                        DropdownMenuItem(
                                          value: 'Month',
                                          child: AppText(
                                            'Month',
                                            size: 12,
                                          ),
                                          onTap: () {
                                            bloc.add(MonthPeriodEvent());
                                          },
                                        ),
                                        DropdownMenuItem(
                                          value: 'Week',
                                          child: AppText(
                                            'Week',
                                            size: 12,
                                          ),
                                          onTap: () {
                                            bloc.add(WeekPeriodEvent());
                                          },
                                        ),
                                        DropdownMenuItem(
                                          value: 'Day',
                                          child: AppText(
                                            'Day',
                                            size: 12,
                                          ),
                                          onTap: () {
                                            bloc.add(DayPeriodEvent());
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.notifications_rounded))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is YearPeriodState) ...{
                      YearWidget(
                        year:int.parse(state.year),
                      ),
                    },
                    if (state is MonthPeriodState) ...{
                      MonthWidget(
                        month: state.month,
                        year: '${state.year}',
                        day: state.day,
                        week: state.week,
                      ),
                    },
                    if (state is WeekPeriodState) ...{
                      WeekWidget(
                        week: state.week,
                        year: '${state.year}',
                        month: state.month,
                        day: state.day,
                      )
                    },
                    if (state is DayPeriodState) ...{
                      DayWidget(
                        day: state.day,
                        week: state.week,
                        year: state.year,
                        month: state.month,
                      ),
                    },
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
