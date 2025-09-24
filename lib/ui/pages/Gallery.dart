

import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/categoryList.dart';
import '../../data/model/ImageModel.dart';
import '../../network/image_service.dart';
import '../../util.dart';
import '../components/AllCategories.dart';
import '../components/ImageItem.dart';
import '../components/InternetChecker.dart';
import '../components/walltile.dart';



class Gallery extends StatefulWidget {

  @override
  State<Gallery> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<Gallery> {

  final TextEditingController searchControler = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Wallpaper> _wallpapers = [];
  String selectedCategory = '';
  // String sCategory = 'Wallpapers';

  int _page = 1;
  bool _isLoading = false;
  bool typed=false;
  bool lfb = true;





  @override
  void initState() {
    super.initState();

    //
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });


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
    setState(() {
      _isLoading = true;
      lfb=true;
    }
    );

    final newItems = await ApiService.fetchWallpapers(
        selectedCategory, _page++);
    setState(() {
      _wallpapers.addAll(newItems);
      _isLoading = false;
      lfb=false;
    });



  }



  void _changeCategory(String category) {
    setState(() {
      selectedCategory = category;
      _wallpapers.clear();
      _page = 1;
    });
    _fetchWallpapers();
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


    Future<void> SelectPhoto() async {

    }


    // Future<void> SelectPhoto() async {
    //   final WallpaperManagerFlutter _wallpaperManager = WallpaperManagerFlutter();
    //   try {
    //
    //     FilePickerResult? picked = await FilePicker.platform.pickFiles(
    //       type: FileType.image,
    //     );
    //
    //
    //     if (picked == null) {
    //       Fluttertoast.showToast(msg: "Set cancelled",backgroundColor: Colors.red);
    //       return;
    //     }
    //
    //
    //     final result = await showDialog<String>(
    //       context: context,
    //
    //
    //       builder: (BuildContext context) {
    //         return SimpleDialog(
    //           title: const Text('Set Wallpaper'),
    //           children: <Widget>[
    //             SimpleDialogOption(
    //               onPressed: () => Navigator.pop(context, 'HOME'),
    //               child: const Text('Home Screen'),
    //             ),
    //             SimpleDialogOption(
    //               onPressed: () => Navigator.pop(context, 'LOCK'),
    //               child: const Text('Lock Screen'),
    //             ),
    //             SimpleDialogOption(
    //               onPressed: () => Navigator.pop(context, 'BOTH'),
    //               child: const Text('Both Screens'),
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //
    //
    //     if (result != null) {
    //       int location;
    //       if (result == 'HOME') {
    //         location = WallpaperManagerFlutter.homeScreen;
    //       } else if (result == 'LOCK') {
    //         location = WallpaperManagerFlutter.lockScreen;
    //       } else {
    //         location = WallpaperManagerFlutter.bothScreens;
    //       }
    //
    //       try {
    //         File file = File(picked.files.single.path!);
    //
    //         await _wallpaperManager.setWallpaper(file, location);
    //
    //         if (!mounted) return;
    //         Fluttertoast.showToast(msg: 'Wallpaper set successfully.');
    //
    //       } catch (e) {
    //         if (!mounted) return;
    //         Fluttertoast.showToast(msg: 'Error: $e',backgroundColor: Colors.red);
    //
    //
    //       }
    //     }
    //
    //
    //
    //
    //
    //   }catch(e){
    //     Fluttertoast.showToast(msg: "error ${e.toString()} ");
    //   }
    // }
    //














    return Scaffold(

      body:InternetChecker(
        what: 'pictures',
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(

                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),

                child: SizedBox(
                  height: 40,
                  width: screenwidth/2.0,
                  child:
                  TextField(
                    controller: searchControler,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      _changeCategory(value);
                    },
                    onChanged: (value){
                      if(searchControler.text.isNotEmpty ){
                        setState(() {
                          typed= true;
                        });


                      }else{
                        setState(() {
                          typed=false;
                        });

                      }



                    },

                    decoration: InputDecoration(
                      labelText: "search for images",

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24)
                      ),
                      prefixIcon: IconButton(
                        onPressed: () {
                          _changeCategory(searchControler.text);
                        },
                        icon: Icon(Icons.search),
                      ),

                      suffixIcon: typed?
                      IconButton(
                        onPressed: () {
                          searchControler.clear();
                          _changeCategory('all');
                          typed=false;
                        },
                        icon: Icon(Icons.clear),
                      ):null

                      ,





                    ),


                  ),
                )


            )
            ,
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (_, i) =>
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ChoiceChip(
                        label: Text(categories[i]),
                        selected: selectedCategory == categories[i],
                        onSelected: (_) {
                          if (categories[i] == "Categories") {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (_) => AllCategories()

                                )
                            );
                          } else {
                            _changeCategory(categories[i]);
                          }
                        },
                      ),

                    ),
              ),
            ),



            Expanded(
              child: isMobile()
                  ? ListPhotos( _scrollController, context, _wallpapers)
                  : gridPhotos(col, _scrollController, context, _wallpapers),
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


      ),




      // )
    );




  }
}


Widget gridPhotos(int col, ScrollController scrollController, BuildContext context,List<Wallpaper> wallpapers){
  return GridView.builder(
    controller: scrollController,

    padding: const EdgeInsets.all(8),
    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: col,
      childAspectRatio: 9 / 16,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    ),

    itemCount: wallpapers.length,
    itemBuilder: (_, index) {
      // final wallpaper = wallpapers[getRandomValue(wallpapers.length)];//rep index
      final wallpaper = wallpapers[getRandomValue(index)];
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImageDetailScreen(wallpaper: wallpaper),
          ),
        ),
        child: WallpaperTile(wallpaper: wallpaper),
      );
    },

  );
}


Widget ListPhotos( ScrollController scrollController, BuildContext context,List<Wallpaper> wallpapers){
  return ListView.builder(
    controller: scrollController,

    padding: const EdgeInsets.all(8),
    itemCount: wallpapers.length,
    itemBuilder: (_, index) {
      // final wallpaper = wallpapers[getRandomValue(wallpapers.length)];//rep index
      final wallpaper = wallpapers[getRandomValue(index)];
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImageDetailScreen(wallpaper: wallpaper),
          ),
        ),
        child: WallpaperTile(wallpaper: wallpaper),
      );
    },

  );
}


