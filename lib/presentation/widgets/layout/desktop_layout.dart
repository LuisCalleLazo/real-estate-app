import 'package:flutter/material.dart';
import 'package:real_estate_app/presentation/widgets/button/notification_button.dart';
import 'package:real_estate_app/presentation/widgets/button/theme_toggle_button.dart';
import 'package:real_estate_app/presentation/widgets/logo/app_logo.dart';
import 'package:real_estate_app/shared/utils/navigation_item_data.dart';

class DesktopLayout extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final List<NavigationItemData> navigationItems;
  final int notificationCount;
  final Widget currentScreen;

  const DesktopLayout({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.navigationItems,
    required this.notificationCount,
    required this.currentScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(context),
          Expanded(child: _buildMainContent(context)),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        children: [
          _buildSidebarHeader(context),
          const Divider(height: 1),
          Expanded(child: _buildNavigationList(context)),
          const Divider(height: 1),
          const Padding(
            padding: EdgeInsets.all(12),
            child: ThemeToggleListTile(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: AppLogo(iconSize: 36, fontSize: 24),
    );
  }

  Widget _buildNavigationList(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: navigationItems.length,
      itemBuilder: (context, index) {
        final item = navigationItems[index];
        final isSelected = selectedIndex == index;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: Icon(
              isSelected ? item.activeIcon : item.icon,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
            ),
            title: Text(
              item.label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
            ),
            selected: isSelected,
            selectedTileColor: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () => onItemTapped(index),
          ),
        );
      },
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        _buildTopBar(context),
        Expanded(child: currentScreen),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      // decoration: BoxDecoration(
      //   color: Theme.of(context).scaffoldBackgroundColor,
      //   border: Border(
      //     bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1),
      //   ),
      // ),
      child: Row(
        children: [
          Text(
            navigationItems[selectedIndex].label,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Spacer(),
          ThemeToggleButton(),
          const SizedBox(width: 16),
          NotificationButton(count: notificationCount),
          const SizedBox(width: 16),
          _buildUserAvatar(context),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemTapped(3),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Theme.of(
          context,
        ).colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(
          Icons.person,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
      ),
    );
  }
}
