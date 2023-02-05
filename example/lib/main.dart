import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:persistent_bottom_nav_bar_v2_example_project/screens.dart';

void main() => runApp(PersistenBottomNavBarDemo());

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

PersistentTabController controller = PersistentTabController(initialIndex: 0);

class PersistenBottomNavBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Persistent Bottom Navigation Bar Demo',
      routerConfig: GoRouter(
        routes: [
          // GoRoute(
          //   path: '/',
          //   builder: (context, state) => MinimalExample(),
          //   routes: [
          //     GoRoute(
          //       path: ':tab',
          //       builder: (BuildContext context, GoRouterState state) {
          //         controller.jumpToTab(int.parse(state.params['tab'] ?? "0"));
          //         return Container();
          //       },
          //     ),
          //   ],
          // ),
          ShellRoute(
            builder: (context, state, child) {
              // controller.onIndexChanged = (value) {
              //   GoRouter.of(context).go("/$value");
              // };
              // controller.jumpToTab(int.parse(state.params['tab'] ?? "0"));
              // return MinimalExample();
              return Scaffold(
                body: child,
                bottomNavigationBar: BottomNavigationBar(items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                ]),
              );
            },
            routes: [
              // This screen is displayed on the ShellRoute's Navigator.
              GoRoute(
                path: '/:tab',
                builder: (BuildContext context, GoRouterState state) {
                  return MainScreen();
                },
                routes: <RouteBase>[
                  // This screen is displayed on the ShellRoute's Navigator.
                  GoRoute(
                    path: 'details',
                    builder: (BuildContext context, GoRouterState state) {
                      return const MainScreen2();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // routes: {
      //   '/minimal': (context) => MinimalExample(),
      //   '/interactive': (context) => InteractiveExample(),
      // },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => context.go("/minimal"),
              child: Text("Show Minimal Example"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go("/interactive"),
              child: Text("Show Interactive Example"),
            ),
          ],
        ),
      );
    });
  }
}

class MinimalExample extends StatefulWidget {
  MinimalExample({Key? key}) : super(key: key);

  @override
  State<MinimalExample> createState() => _MinimalExampleState();
}

class _MinimalExampleState extends State<MinimalExample> {
  @override
  void initState() {
    super.initState();
    print("Initialize Minimal Example State");
  }

  List<PersistentTabConfig> _tabs() {
    return [
      PersistentTabConfig(
        screen: MainScreen(),
        item: ItemConfig(
          icon: Icon(Icons.home),
          title: "Home",
        ),
        navigatorConfig: NavigatorConfig(
          navigatorKey: navigatorKey,
        ),
      ),
      PersistentTabConfig(
        screen: MainScreen(),
        item: ItemConfig(
          icon: Icon(Icons.message),
          title: "Messages",
        ),
      ),
      PersistentTabConfig(
        screen: MainScreen(),
        item: ItemConfig(
          icon: Icon(Icons.settings),
          title: "Settings",
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuilding Minimal Example");
    return PersistentTabView(
      controller: controller,
      tabs: _tabs(),
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}
