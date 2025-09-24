import 'package:flutter/material.dart';


import '../../data/model/ImageModel.dart';
import '../../network/image_service.dart';
import '../pages/Dashboard.dart';


class Categorypage extends StatefulWidget{
  final String search;

  const Categorypage({super.key, required this.search});

  @override
  State<Categorypage> createState() =>_AllCategoriesState();

}

class _AllCategoriesState extends  State<Categorypage>{


  // final TextEditingController searchControler = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Wallpaper> _wallpapers = [];

  String selectedCategorys = '';
  int _page = 1;
  bool _isLoading = false;




  @override
  void initState() {
    super.initState();


    _fetchWallpapers();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        _fetchWallpapers();
      }
    });
  }



  Future<void> _fetchWallpapers() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    final newItems = await ApiService.fetchWallpapers(
        widget.search, _page++);
    setState(() {
      _wallpapers.addAll(newItems);
      _isLoading = false;
    });
  }






  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    int col = 2;
    col = screenwidth <= 300 ? 1 : screenwidth <= 600 ? 2 : screenwidth <= 1000
        ? 3
        : 4;
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.search),
        leading:  IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Column(
        children: [


          Expanded(child:
          Padding(
              padding: EdgeInsets.only(
                  left: 8,right: 8
              ),
              child:


              walls(col, _scrollController, context, _wallpapers)


          ),

          ),

          if (_isLoading)Padding(

            padding: EdgeInsets.only(bottom: 16),
            child:
            CircularProgressIndicator(
              value: 0.7,
              strokeWidth: 0.6,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow[300]!),
            ),

          )
        ],
      ),

      // )
    );
  }
}