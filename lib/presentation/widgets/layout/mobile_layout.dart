import 'package:flutter/material.dart';
import 'package:real_estate_app/presentation/widgets/button/notification_button.dart';
import 'package:real_estate_app/presentation/widgets/button/theme_toggle_button.dart';
import 'package:real_estate_app/presentation/widgets/logo/app_logo.dart';
import 'package:real_estate_app/presentation/widgets/navigation/custom_bottom_navigation_bar.dart';
import 'package:real_estate_app/shared/utils/navigation_item_data.dart';

class MobileLayout extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final ValueChanged<int> onPageChanged;
  final PageController pageController;
  final List<NavigationItemData> navigationItems;
  final int notificationCount;
  final List<Widget> screens;

  const MobileLayout({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.onPageChanged,
    required this.pageController,
    required this.navigationItems,
    required this.notificationCount,
    required this.screens,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTapped: onItemTapped,
        items: navigationItems,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const AppLogo(),
      actions: [
        const ThemeToggleButton(),
        NotificationButton(count: notificationCount),
        const SizedBox(width: 8),
      ],
    );
  }
}
