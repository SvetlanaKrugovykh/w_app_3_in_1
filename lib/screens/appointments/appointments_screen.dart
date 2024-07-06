import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../localization/localization_service.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now()
      .add(Duration(days: 1)); // Example: end date is the next day
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay(
      hour: TimeOfDay.now().hour + 1,
      minute: TimeOfDay.now().minute); // Example: end time is one hour later

  @override
  Widget build(BuildContext context) {
    var localizationService = Provider.of<LocalizationService>(context);
    return Scaffold(
      appBar: AppBar(
        title:
            Text(localizationService.getTranslatedValue('appointments.title')),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizationService
                  .getTranslatedValue('appointments.selectInterval'),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  locale: Locale(localizationService.currentLanguage),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    setState(() {
                      _selectedStartDate = selectedDate;
                    });
                  }
                });
              },
              child: Text(localizationService
                  .getTranslatedValue('appointments.selectStartDate')),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: _selectedStartDate ?? DateTime.now(),
                  firstDate: _selectedStartDate ?? DateTime.now(),
                  lastDate: DateTime(2100),
                  locale: Locale(localizationService.currentLanguage),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    setState(() {
                      _selectedEndDate = selectedDate;
                    });
                  }
                });
              },
              child: Text(localizationService
                  .getTranslatedValue('appointments.selectEndDate')),
            ),
            SizedBox(height: 16.0),
            Text(
              localizationService
                  .getTranslatedValue('appointments.selectTimeInterval'),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (BuildContext context, Widget? child) {
                    // Corrected Widget? child
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child!,
                    );
                  },
                ).then((selectedTime) {
                  if (selectedTime != null) {
                    setState(() {
                      _selectedStartTime = selectedTime;
                    });
                  }
                });
              },
              child: Text(localizationService
                  .getTranslatedValue('appointments.selectStartTime')),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: _selectedStartTime ?? TimeOfDay.now(),
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child!,
                    );
                  },
                ).then((selectedTime) {
                  if (selectedTime != null) {
                    setState(() {
                      _selectedEndTime = selectedTime;
                    });
                  }
                });
              },
              child: Text(localizationService
                  .getTranslatedValue('appointments.selectEndTime')),
            ),
            SizedBox(height: 16.0),
            Text(
              localizationService
                  .getTranslatedValue('appointments.selectedDateTime'),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              localizationService
                      .getTranslatedValue('appointments.selectStartDate') +
                  ': ${_selectedStartDate?.toString() ?? localizationService.getTranslatedValue('appointments.notSelected')}',
            ),
            Text(
              localizationService
                      .getTranslatedValue('appointments.selectEndDate') +
                  ': ${_selectedEndDate?.toString() ?? localizationService.getTranslatedValue('appointments.notSelected')}',
            ),
            SizedBox(height: 8.0),
            Text(
              localizationService
                  .getTranslatedValue('appointments.selectedTimeInterval'),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              localizationService
                      .getTranslatedValue('appointments.selectStartTime') +
                  ': ${_selectedStartTime?.format(context) ?? localizationService.getTranslatedValue('appointments.notSelected')}',
            ),
            Text(
              localizationService
                      .getTranslatedValue('appointments.selectEndTime') +
                  ': ${_selectedEndTime?.format(context) ?? localizationService.getTranslatedValue('appointments.notSelected')}',
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: AppointmentsScreen(),
//     localizationsDelegates: [
//       GlobalMaterialLocalizations.delegate,
//       GlobalWidgetsLocalizations.delegate,
//     ],
//     supportedLocales: [
//       const Locale('ru'), // Добавляем поддержку русской локализации
//     ],
//   ));
// }
