import 'package:flutter/material.dart';
import 'package:hotel_management/constant/kstrings.dart';
import 'package:hotel_management/providers/room_provider.dart';
import 'package:hotel_management/providers/theme_provider.dart';
import 'package:hotel_management/screens/auth/login_home_screen.dart';
import 'package:hotel_management/screens/guest/guest_home_screen.dart';
import 'package:hotel_management/screens/staff/staff_dashboard_screen.dart';
import 'package:hotel_management/utils/kroute.dart';
import 'package:provider/provider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'providers/user_provider.dart';
import 'package:hotel_management/constant/kenums.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => RoomProvider()),
          ChangeNotifierProvider(create: (_) => KThemeProvider()),
        ],
        builder: (context, child) {
          final themeProvider = Provider.of<KThemeProvider>(context);
          return MaterialApp(
            title: 'Hotel Management App',
            builder: BotToastInit(),
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            navigatorObservers: [BotToastNavigatorObserver()],
            themeMode: themeProvider.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: Consumer<UserProvider>(
              builder: (context, authProvider, child) {
                if (authProvider.user == null) {
                  authProvider.fetchSavedUserData();
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (authProvider.user?.email ==
                    KDummyModelData.notARegisteredUser.email) {
                  return const LoginScreen();
                } else {
                  // Navigate based on the user's role
                  if (authProvider.role == KEnumUserRole.staff.name) {
                    return const StaffDashboardScreen();
                  } else {
                    return const GuestHomeScreen();
                  }
                }
              },
            ),
          );
        });
  }
}
