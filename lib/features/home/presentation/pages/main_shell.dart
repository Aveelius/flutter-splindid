import 'package:flutter/material.dart';
import 'package:pasar_splindid_app/core/widgets/shared_widgets.dart';
import 'package:pasar_splindid_app/features/home/presentation/pages/dashboard_screen.dart';
import 'package:pasar_splindid_app/features/market/presentation/pages/market_screen.dart';
import 'package:pasar_splindid_app/features/community/presentation/pages/community_screen.dart';
import 'package:pasar_splindid_app/features/map/presentation/pages/map_screen.dart';
import 'package:pasar_splindid_app/features/settings/presentation/pages/settings_screen.dart';
import 'package:pasar_splindid_app/features/utility/presentation/pages/utility_screens.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selected = 0;
  final pages = const [DashboardPage(), MarketPage(), CommunityPage(), MapPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(children: [
          const StatusStrip(),
          AppHeader(onSearch: () => openPage(context, const SearchPage()),
              onNotifications: () => openPage(context, const NotificationsPage()),
              dashboard: selected == 0),
          Expanded(child: IndexedStack(index: selected, children: pages)),
          SafeArea(
            top: false,
            child: Container(
              height: 66,
              decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFE1E7E2)))),
              child: Row(children: List.generate(5, (i) {
                final icon = [Icons.home_outlined, Icons.storefront_outlined, Icons.groups_2_outlined, Icons.map_outlined, Icons.settings_outlined][i];
                final active = selected == i;
                return Expanded(child: InkWell(
                  onTap: () => setState(() => selected = i),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(icon, size: 23, color: active ? forest : const Color(0xFF647069)),
                    const SizedBox(height: 3),
                    Text(['Dashboard', 'Pasar', 'Komunitas', 'Peta', 'Pengaturan'][i],
                        style: TextStyle(fontSize: 10, color: active ? forest : const Color(0xFF56625B), fontWeight: active ? FontWeight.w700 : FontWeight.w400)),
                  ]),
                ));
              })),
            ),
          ),
        ]),
      );
}
