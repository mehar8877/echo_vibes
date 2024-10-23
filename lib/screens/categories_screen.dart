import 'package:flutter/material.dart';
class cat extends StatelessWidget {
   cat({super.key});

  final List<String> categories=[
    "Favorites",
    "Confidence",
    "General",
    "Abundance",
    "Love",
    "Success",
    "Gratiitude"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Categories',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),),
      ),
      body: ListView.separated(itemBuilder: (context,index){
        return Column(
          children: [
            SizedBox(height: 10,),
            Container(
              height: 65,
              width: 380,
              decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                title: Text(categories[index]),
                leading: Icon(Icons.category),

              ),
            ),
          ],
        );
      },
          separatorBuilder: (context,index)=> SizedBox(height: 0.1,),
          itemCount: categories.length),
    );
  }
}
