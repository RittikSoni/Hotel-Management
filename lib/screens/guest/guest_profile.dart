import 'package:flutter/material.dart';
import 'package:hotel_management/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class GuestProfile extends StatelessWidget {
  const GuestProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<KThemeProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          SwitchListTile(
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
            title: Text(
              themeProvider.themeMode == ThemeMode.dark
                  ? 'Dark Mode'
                  : 'Light Mode',
            ),
          ),
        ],
      ),
    );
  }
}
