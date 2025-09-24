
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/allCategoryList.dart';
import 'CardSub.dart';
import 'categories.dart';


class AllCategories extends StatefulWidget{
  const AllCategories({super.key});

  @override
  State<AllCategories> createState() =>_AllCategoriesState();

}

class _AllCategoriesState extends  State<AllCategories>{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Categories"),
          leading:  IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body:

        ListView.builder(
            itemCount: wallpaperCategories.length,
            itemBuilder: (context, index) {
              final categoryMap = wallpaperCategories[index];
              // final category = categoryMap.keys.first;
              // final subcategories = categoryMap[category]!;

              return allc(categoryMap);
            }

        )

    );
  }

  Widget allc(Map<String,List<String>> catategory){
    final category = catategory.keys.first;
    final subcategories = catategory[category]!;

    return Padding(
        padding: EdgeInsetsGeometry.only(left: 8,right: 8,top: 16,bottom: 16),
        child:

        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(category)
              ],
            ),


            subsall(subcategories)


          ],)
    );
  }



  Widget subsall(List<String> subs) {
    return SizedBox(
      height: 200, // set height appropriately
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 9 / 16,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: subs.length,
        itemBuilder: (_, index) {
          final subscategory = subs[index];
          return GestureDetector(
            onTap: () =>Navigator.push(context,
                MaterialPageRoute(
                    builder: (_) =>Categorypage(search: subscategory)
                )
            ),
            child: cardsub(subcategory: subscategory),
          );
        },
      ),
    );
  }



}