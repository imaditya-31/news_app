import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/login_controller.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/views/bookmark_screen.dart';
import 'package:news_app/views/news_feed_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsController controller = Get.put(NewsController());
  final LoginController logincontroller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'News App',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: const Text('Logout',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    content: const Text('Are you sure, you want to logout..?'),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          logincontroller.logout();
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.red[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout_rounded),
              color: Colors.red[700],
            )
          ],
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: TextStyle(),
            automaticIndicatorColorAdjustment: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.black87,
            indicatorWeight: 2.5,
            labelStyle: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w900,
            ),
            tabs: [
              Tab(text: 'NEWS FEED'),
              Tab(text: 'BOOKMARKS'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NewsFeedScreen(),
            BookmarkScreen(),
          ],
        ),
      ),
    );
  }
}
