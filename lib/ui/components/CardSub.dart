import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/model/ImageModel.dart';

import '../../network/image_service.dart';

class cardsub extends StatefulWidget {
  final String subcategory;

  cardsub({required this.subcategory});

  @override
  State<cardsub> createState() =>cardsubState();

}


class cardsubState extends State<cardsub> {


  List<Wallpaper> _wallpapers = [];
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _loadWallpapers();
  }

  Future<void> _loadWallpapers() async {
    final wallpapers = await _fetchWallpaper();
    if (mounted) {
      setState(() {
        _wallpapers = wallpapers;
        _isLoading = false;
      });
    }
  }

  Future<List<Wallpaper>> _fetchWallpaper() async {

    return await ApiService.fetchWallpapers(widget.subcategory, 8, perPage: 1);
  }




  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: _isLoading
          ? _buildLoadingPlaceholder()
          : _buildWallpaperCard(),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildWallpaperCard() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: _wallpapers[0].imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            placeholder: (_, __) => Center(
              child: CircularProgressIndicator(),
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
              widget.subcategory,
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
    );
  }
}


