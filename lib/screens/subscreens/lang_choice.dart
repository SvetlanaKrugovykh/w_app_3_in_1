import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../localization/localization_service.dart';

class LangChoice extends StatelessWidget {
  const LangChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (String value) {
        if (value == 'back') {
          Navigator.pop(context);
        } else {
          Provider.of<LocalizationService>(context, listen: false)
              .currentLocale = Locale(value);
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'en',
            child: Text('English'),
          ),
          const PopupMenuItem<String>(
            value: 'uk',
            child: Text('Українська'),
          ),
          const PopupMenuItem<String>(
            value: 'pl',
            child: Text('Polski'),
          ),
          const PopupMenuItem<String>(
            value: 'back',
            child: Text('Back'),
          ),
        ];
      },
    );
  }
}
