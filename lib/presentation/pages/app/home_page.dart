import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/presentation/screens/home/init_home_screen.dart';
import 'package:real_estate_app/presentation/screens/home/profile_screen.dart';
import 'package:real_estate_app/presentation/screens/home/property_map_screen.dart';
import 'package:real_estate_app/presentation/screens/home/search_map_screen.dart';
import 'package:real_estate_app/presentation/widgets/layout/desktop_layout.dart';
import 'package:real_estate_app/presentation/widgets/layout/mobile_layout.dart';
import 'package:real_estate_app/shared/utils/navigation_item_data.dart';
import 'package:real_estate_app/shared/utils/responsive_layout.dart';

class HomePage extends StatefulWidget {
  static String name = 'home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  late List<Widget> _screens;
  int _notificationCount = 10;

  final List<NavigationItemData> _navigationItems = [
    NavigationItemData(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Inicio',
    ),
    NavigationItemData(
      icon: CupertinoIcons.heart,
      activeIcon: CupertinoIcons.heart_fill,
      label: 'Favoritos',
    ),
    NavigationItemData(
      icon: Icons.map_outlined,
      activeIcon: Icons.map,
      label: 'Explorar',
    ),
    NavigationItemData(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Perfil',
    ),
    NavigationItemData(
      icon: Icons.add_outlined,
      activeIcon: Icons.add,
      label: 'Publicar',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _screens = [
      const InitHomeScreen(),
      const PropertyMapScreen(),
      const SearchMapScreen(),
      const ProfileScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Solo animar en mobile/tablet
    if (ResponsiveLayout.isMobile(context) ||
        ResponsiveLayout.isTablet(context)) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getCurrentScreen() {
    return _screens[_selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: MobileLayout(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onPageChanged: _onPageChanged,
        pageController: _pageController,
        navigationItems: _navigationItems,
        notificationCount: _notificationCount,
        screens: _screens,
      ),

      tablet: DesktopLayout(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        navigationItems: _navigationItems,
        notificationCount: _notificationCount,
        currentScreen: _getCurrentScreen(),
      ),

      desktop: DesktopLayout(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        navigationItems: _navigationItems,
        notificationCount: _notificationCount,
        currentScreen: _getCurrentScreen(),
      ),
    );
  }
}
