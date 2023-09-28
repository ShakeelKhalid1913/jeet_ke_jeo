import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeet_ke_jeo/src/models/enums/options.dart';
import 'package:jeet_ke_jeo/src/services/firebase/auth.dart';
import 'package:jeet_ke_jeo/src/utils/translations.dart';

class CustomPopupMenu extends StatefulWidget {
  const CustomPopupMenu({super.key});

  @override
  State<CustomPopupMenu> createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  Options? _selectedOption;

  void changeLocale() {
    if (Get.locale == const Locale('ur', 'PK')) {
      AppTranslation.changeLocale('en', 'US');
    } else {
      AppTranslation.changeLocale('ur', 'PK');
    }
  }

  void _logout() async {
    await _auth.logout();

    if (context.mounted) {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      initialValue: _selectedOption,
      onSelected: (Options option) => setState(() => _selectedOption = option),
      itemBuilder: (_) => <PopupMenuEntry<Options>>[
        PopupMenuItem(
          value: Options.TRANSLATION,
          child: ListTile(
            leading: const Icon(Icons.language, size: 30),
            title: Text('change-language'.tr),
            onTap: () {
              changeLocale();
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem(
          value: Options.LOGOUT,
          child: ListTile(
            leading: const Icon(Icons.logout, size: 30),
            title: Text('logout'.tr),
            onTap: _logout,
          ),
        ),
      ],
    );
  }
}
