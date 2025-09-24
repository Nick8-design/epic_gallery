
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path_provider/path_provider.dart';


import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


import 'dart:typed_data';

import '../../data/model/ImageModel.dart';



class ImageDetailScreen extends ConsumerStatefulWidget  {
  final Wallpaper wallpaper;

  const ImageDetailScreen({super.key, required this.wallpaper});

  @override
  ConsumerState<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends ConsumerState<ImageDetailScreen> {
  // final favoritesService = FavoritesService();

  Future<void> _setWallpaper(String imageUrl)async {

  }
  //
  // Future<void> _setWallpaper(String imageUrl) async {
  //   final WallpaperManagerFlutter _wallpaperManager = WallpaperManagerFlutter();
  //
  //
  //   final result = await showDialog<String>(
  //     context: context,
  //
  //
  //     builder: (BuildContext context) {
  //       return SimpleDialog(
  //         title: const Text('Set Wallpaper'),
  //         children: <Widget>[
  //           SimpleDialogOption(
  //             onPressed: () => Navigator.pop(context, 'HOME'),
  //             child: const Text('Home Screen'),
  //           ),
  //           SimpleDialogOption(
  //             onPressed: () => Navigator.pop(context, 'LOCK'),
  //             child: const Text('Lock Screen'),
  //           ),
  //           SimpleDialogOption(
  //             onPressed: () => Navigator.pop(context, 'BOTH'),
  //             child: const Text('Both Screens'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //
  //
  //
  //   if (result != null) {
  //     int location;
  //     if (result == 'HOME') {
  //       location = WallpaperManagerFlutter.homeScreen;
  //     } else if (result == 'LOCK') {
  //       location = WallpaperManagerFlutter.lockScreen;
  //     } else {
  //       location = WallpaperManagerFlutter.bothScreens;
  //     }
  //
  //     try {
  //       File file = await DefaultCacheManager().getSingleFile(
  //           imageUrl
  //       );
  //       await _wallpaperManager.setWallpaper(file, location);
  //
  //       if (!mounted) return;
  //       Fluttertoast.showToast(msg:  'Wallpaper set successfully.');
  //
  //     } catch (e) {
  //       if (!mounted) return;
  //       Fluttertoast.showToast(msg: 'Error: $e',backgroundColor: Colors.red);
  //
  //     }
  //   }
  //
  // }







  Future<String> getDownloadPath() async {
    Directory? directory = await getExternalStorageDirectory();
    return directory!.path;
  }


  Future<void> _downloadImage() async {

  }

  // Future<void> _downloadImage() async {
  //
  //   int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(100000);
  //   await requestStoragePermissions();
  //
  //   try {
  //     String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
  //     if (selectedDirectory == null) {
  //       return ;
  //     }
  //
  //
  //     String savePath = "$selectedDirectory/${widget.wallpaper.name}.png";
  //
  //
  //     Directory saveDirectory = Directory(selectedDirectory);
  //     if (!saveDirectory.existsSync()) {
  //       saveDirectory.createSync(recursive: true);
  //     }
  //
  //
  //
  //     // AwesomeNotifications().createNotification(
  //     //   content: NotificationContent(
  //     //     id: notificationId,
  //     //     channelKey: 'download_channel',
  //     //     title: 'Downloading...',
  //     //     body: 'Progress: 0%',
  //     //     notificationLayout: NotificationLayout.ProgressBar,
  //     //     progress: 0,
  //     //     locked: true,
  //     //   ),
  //     // );
  //
  //
  //     // await Dio().download( widget.wallpaper.imageUrl, savePath);
  //
  //     await Dio().download(
  //       widget.wallpaper.imageUrl,
  //       savePath,
  //       onReceiveProgress: (received, total) {
  //         if (total != -1) {
  //           int progress = (received / total * 100).floor();
  //
  //           AwesomeNotifications().createNotification(
  //             content: NotificationContent(
  //               id: notificationId,
  //               channelKey: 'download_channel',
  //               title: progress==100?"Downloaded":'Downloading...',
  //               body:progress==100?"Downloaded successfully": 'Progress: $progress%',
  //               notificationLayout: NotificationLayout.ProgressBar,
  //               progress: progress.toDouble(),
  //               locked: true,
  //             ),
  //           );
  //         }
  //       },
  //     );
  //
  //
  //
  //
  //     AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //         id: notificationId,
  //         channelKey: 'download_channel',
  //         title: 'Download Complete',
  //         body: 'Image saved to $savePath',
  //         notificationLayout: NotificationLayout.Default,
  //       ),
  //     );
  //
  //     Fluttertoast.showToast(msg: 'Downloaded to $savePath');
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   SnackBar(content: Text()),
  //     // );
  //
  //
  //     return;
  //   } catch (e) {
  //     print("Error: $e");
  //
  //
  //     print('Download failed: $e');
  //
  //     AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //         id: notificationId,
  //         channelKey: 'download_channel',
  //         title: 'Download Failed',
  //         body: e.toString(),
  //         notificationLayout: NotificationLayout.Default,
  //       ),
  //     );
  //     //
  //     Fluttertoast.showToast(msg: 'Download failed: $e',backgroundColor: Colors.red);
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   SnackBar(content: Text(), backgroundColor: Colors.red),
  //     // );
  //     //     print('Download failed: $e');
  //
  //     return ;
  //
  //   }
  // }





  @override
  Widget build(BuildContext context) {
    // final favorites = ref.watch(wallpaperFavoritesProvider);

    // final isFavorite = favoritesService.isFavoritewalls(widget.wallpaper);

    return Scaffold(
      appBar: AppBar(title: Text(widget.wallpaper.name)),
      body: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: widget.wallpaper.imageUrl,
              fit: BoxFit.cover,
            ),//

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: _downloadImage),
              IconButton(
                  icon: const Icon(Icons.wallpaper),
                  onPressed: () => _setWallpaper(widget.wallpaper.imageUrl)),




              IconButton(
                icon: Icon(
                    // ref.read(wallpaperFavoritesProvider.notifier).isFavorite(widget.wallpaper) ?
                    Icons.favorite
                        // : Icons.favorite_border
                ),
                onPressed: () {

                  // ref.read(wallpaperFavoritesProvider.notifier).toggle(widget.wallpaper);
                  // Fluttertoast.showToast(
                  //     msg: ref.read(wallpaperFavoritesProvider.notifier).isFavorite(widget.wallpaper)
                  //         ? 'Removed from favorites'
                  //         :'Added to favorites'
                  // );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}


Future<void> requestStoragePermissions() async {
  //
  // if (await Permission.storage.request().isGranted) {
  //   // print("Storage permission granted");
  //   Fluttertoast.showToast(msg: "Storage permission granted");
  // } else {
  //   Fluttertoast.showToast(msg: "Storage permission denied");
  //   // print("Storage permission denied");
  // }
}