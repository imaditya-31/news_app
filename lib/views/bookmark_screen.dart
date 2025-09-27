import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/components/webview_screen.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final NewsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.bookmarks.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text('No bookmarks added.', style: TextStyle(color: Colors.grey)),
            ],
          ),
        );
      }
      return ListView.builder(
        itemCount: controller.bookmarks.length,
        itemBuilder: (context, idx) {
          var article = controller.bookmarks[idx];
          return Card(
            color: Colors.grey[50],
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.1, color: Colors.grey),
                borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(12, 4, 0, 4),
              leading: article.image_url != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        article.image_url!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[200],
                            child: const Icon(Icons.image, color: Colors.grey),
                          );
                        },
                      ),
                    )
                  : Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.article, color: Colors.grey),
                    ),
              title: Column(
                children: [
                  Text(
                    article.title ?? 'No Title',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    article.description ?? 'No Description',
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        article.source_id ?? 'Unknown',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      article.pubDate != null
                          ? DateFormat('dd MMM, yyyy')
                              .format(DateTime.parse(article.pubDate!))
                          : 'No date',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red[400],
                ),
                onPressed: () => controller.removeBookmark(article),
              ),
              onTap: () => Get.to(() => WebviewScreen(
                  url: article.link ?? '', title: article.title ?? '')),
            ),
          );
        },
      );
    });
  }
}
