import 'package:epic_gallery/ui/pages/Dashboard.dart';
import 'package:epic_gallery/ui/pages/Gallery.dart';
import 'package:epic_gallery/ui/pages/Profile.dart';
import 'package:flutter/material.dart';

class CollapsibleMenuExample extends StatefulWidget {
  @override
  _CollapsibleMenuExampleState createState() => _CollapsibleMenuExampleState();
}

class _CollapsibleMenuExampleState extends State<CollapsibleMenuExample> {
  int _selectedIndex = 2;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar with gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: NavigationRail(
              backgroundColor: Colors.transparent,
              extended: _isExpanded,
              destinations: const [
                NavigationRailDestination(
                  icon: Tooltip(
                    message: "Home",
                    child: Icon(Icons.home),
                  ),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Tooltip(
                    message: "Settings",
                    child: Icon(Icons.settings),
                  ),
                  label: Text('Settings'),
                ),
                NavigationRailDestination(
                  icon: Tooltip(
                    message: "Profile",
                    child: Icon(Icons.person),
                  ),
                  label: Text('Profile'),
                ),
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },

              /// 🔹 Collapse/Expand toggle at the top
              leading: IconButton(
                icon: Icon(_isExpanded ? Icons.arrow_back : Icons.menu),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),

              /// 🔹 Footer pinned at bottom with divider above
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Divider(
                    color: Colors.white54,
                    thickness: 1,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: _isExpanded
                        ? Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage:
                          AssetImage("assets/images/bu.jpg"),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "My Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.logout,
                              color: Colors.white),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Logging out...")),
                            );
                          },
                        ),
                      ],
                    )
                        : const CircleAvatar(
                      radius: 18,
                      backgroundImage:
                      AssetImage("assets/images/bu.jpg"),
                    ),
                  ),
                ],
              ),

              selectedIconTheme: const IconThemeData(color: Colors.white),
              unselectedIconTheme:
              const IconThemeData(color: Colors.white70),
              selectedLabelTextStyle:
              const TextStyle(color: Colors.white, fontSize: 14),
              unselectedLabelTextStyle:
              const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),

          // Main content
          Expanded(
           child: tabs(_selectedIndex),



          ),
        ],
      ),
    );
  }

  Widget tabs(int index){
    switch (index) {
      case 0:
        return Dashboard();

      case 1:
        return Gallery();

      case 2:
        return Profile();


      default:
        return Dashboard();
    }
  }


}
