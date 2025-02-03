import 'package:dp_project/feature/photos/presentation/screen/my_photo_page_screen.dart';
import 'package:dp_project/feature/photos/presentation/screen/photo_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dp_project/core/style/style_extensions.dart';
import 'package:dp_project/feature/profile/presentation/screen/profile_page_screen.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({super.key});

  @override
  ConsumerState<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 35,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: context.textColor.withOpacity(0.6),
              ),
              label: 'Home',
              activeIcon: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) => LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.secondaryColor,
                    context.primaryColor,
                  ],
                ).createShader(bounds),
                child: const Icon(
                  Icons.home,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: context.textColor.withOpacity(0.6),
              ),
              label: 'Favorites',
              activeIcon: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) => LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.secondaryColor,
                    context.primaryColor,
                  ],
                ).createShader(bounds),
                child: const Icon(
                  Icons.favorite,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: context.textColor.withOpacity(0.6),
              ),
              label: 'Profile',
              activeIcon: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) => LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.secondaryColor,
                    context.primaryColor,
                  ],
                ).createShader(bounds),
                child: const Icon(
                  Icons.person,
                ),
              ),
            ),
          ],
          currentIndex: currentPageIndex,
          elevation: 10,
          onTap: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          backgroundColor: context.backgroundColor,
          selectedLabelStyle: context.textButton,
          selectedItemColor: context.textColor,
          unselectedLabelStyle: context.textButton,
          unselectedItemColor: context.textColor,

        ),
        body: IndexedStack(
          index: currentPageIndex,
          children: const [
            PhotoPageScreen(),
            MyPhotoPageScreen(),
            ProfilePageScreen(),
          ],
        ),
      ),
    );
  }
}
