import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherscape/config.dart';
import 'package:weatherscape/screens/event_calendar/event_calendar_page.dart';
import 'package:weatherscape/screens/weather_forecast/forecast_page.dart';
import '../constraints/constraints.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MainPageState();
}

final titleProvider = StateProvider((ref) => "Forecast");
final pageProvider = StateProvider<Widget>((ref) => const ForecastPage());

class MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(titleProvider)),
        backgroundColor: AppColors.appBarTheme,
        elevation: 0,
      ),
      drawer: _buildDrawer(context, ref),
      body: ref.watch(pageProvider),
    );
  }

  // Drawer
  Widget _buildDrawer(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: AppColors.drawerBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 120,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.drawerHeaderBackground,
              ),
              child: Text(AppConfig.appName,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          _buildDrawerItem(
              icon: Icons.sunny,
              text: "Forecast",
              onTap: () {
                ref.read(titleProvider.notifier).state = "Forecast";
                ref.read(pageProvider.notifier).state = const ForecastPage();
                Navigator.pop(context);
              }),
          _buildDrawerItem(
            icon: Icons.calendar_month_outlined,
            text: 'Plans',
            onTap: () {
              ref.read(titleProvider.notifier).state = "Plans";
              ref.read(pageProvider.notifier).state = const EventCalendarPage();
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.info,
            text: 'About',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  _buildDrawerItem(
      {required IconData icon,
      required String text,
      required void Function()? onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.drawerIconColor),
      title:
          Text(text, style: const TextStyle(color: AppColors.drawerTextColor)),
      onTap: onTap,
    );
  }
}
