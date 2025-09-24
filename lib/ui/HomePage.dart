import 'package:epic_gallery/ui/pages/Dashboard.dart';
import 'package:epic_gallery/ui/pages/Gallery.dart';
import 'package:epic_gallery/ui/pages/Profile.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';


class SidebarXExampleApp extends StatelessWidget {
  SidebarXExampleApp({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SidebarX Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
              backgroundColor: canvasColor,
              title: Text(_getTitleByIndex(_controller.selectedIndex)),
              leading: IconButton(
                onPressed: () {
                  // if (!Platform.isAndroid && !Platform.isIOS) {
                  //   _controller.setExtended(true);
                  // }
                  _key.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
            )
                : null,
            drawer: ExampleSidebarX(controller: _controller),
            body: Row(
              children: [
                if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                Expanded(
                  child:
                  Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(0),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,

      /// 🔹 Header (Top Section)
      headerBuilder: (context, extended) {
        return Column(
          children: [
            // Collapse/Expand toggle
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  _controller.extended ? Icons.arrow_back : Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  _controller.setExtended(!_controller.extended);
                },
              ),
            ),
            const SizedBox(height: 10),
            // Profile / Avatar in header if you want
            if (extended)
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
          ],
        );
      },

      /// 🔹 Footer (Bottom Section)
      footerBuilder: (context, extended) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const Icon(Icons.person, color: Colors.white),
              if (extended) ...[
                const SizedBox(width: 10),
                const Text(
                  "My Profile",
                  style: TextStyle(color: Colors.white),
                ),
              ],
              const Spacer(),
              if (extended)
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Logging out...")),
                    );
                  },
                ),
            ],
          ),
        );
      },

      /// Menu Items
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Dashboard',
          onTap: () {

            debugPrint('Dashboard clicked');
          },
        ),
        const SidebarXItem(
          icon: Icons.search,
          label: 'Gallery',
        ),
        const SidebarXItem(
          icon: Icons.person,
          label: 'Profile',
        ),
      ],
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return Dashboard();

          case 1:
            return Gallery();

          case 2:
            return Profile();


          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Search';
    case 2:
      return 'People';
    case 3:
      return 'Favorites';
    case 4:
      return 'Custom iconWidget';
    case 5:
      return 'Profile';
    case 6:
      return 'Settings';
    default:
      return 'Not found page';
  }
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);