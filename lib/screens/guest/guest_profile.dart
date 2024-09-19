import 'package:flutter/material.dart';
import 'package:hotel_management/providers/theme_provider.dart';
import 'package:hotel_management/providers/user_provider.dart';
import 'package:hotel_management/screens/auth/login_home_screen.dart';
import 'package:hotel_management/screens/guest/booking_list_screen.dart';
import 'package:hotel_management/utils/kroute.dart';
import 'package:provider/provider.dart';

class GuestProfile extends StatelessWidget {
  const GuestProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<KThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

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
          ListTile(
            title: const Text('Booking History'),
            onTap: () {
              userProvider.user != null
                  ? KRoute.push(
                      context: context,
                      page: BookingListScreen(
                          userEmail: userProvider.user!.email))
                  : null;
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () async {
              await Provider.of<UserProvider>(context, listen: false).logout();
              KRoute.pushRemove(
                context: navigatorKey.currentContext!,
                page: const LoginScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}
