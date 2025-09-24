import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../data/model/ImageModel.dart';


class WallpaperTile extends StatelessWidget {
  final Wallpaper wallpaper;

  WallpaperTile({required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: wallpaper.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (_, __) => Center(
                child: CircularProgressIndicator(
                  value: 0.8,
                  color: Colors.green,
                  backgroundColor: Colors.grey[300],
                  strokeWidth: 8.0,
                ),
              ),
              errorWidget: (_, __, ___) => Icon(Icons.error),
            ),
          ),
          Positioned(
            bottom: 62,
            left: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(

                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                wallpaper.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
