import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<String> images = [
    'https://tse1.mm.bing.net/th?id=OIP.eTM1DfOhzQesv6QLtWH-ZgHaLH&pid=Api&P=0&h=180',
    'https://tse1.mm.bing.net/th?id=OIP.iJKo8KwUWtfCuLvFi3PCsgHaJQ&pid=Api&P=0&h=180',
    'https://www.quotesforthemind.com/wp-content/uploads/2018/05/inspiring-and-uplifting-quotes-quote-images-image-about-you-can-only-fail-when-you-stop-trying-to-succeed-in-life.jpg',
    'https://bod-blog-assets.prod.cd.beachbodyondemand.com/bod-blog/wp-content/uploads/2022/04/22145056/motivational-workout-quotes-maya-angelou.png',
    'https://i.pinimg.com/originals/8d/ea/ef/8deaefb22985cd8b75750c2f2d78f364.jpg',
    'https://i.pinimg.com/736x/3d/29/16/3d291666fbe37a0a71fb3a111c0879d8.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      ),
      body: PageView.builder(
          itemCount: images.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                GestureDetector(
                  onDoubleTap: () {},
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                    bottom: 20,
                    right: 20,
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.white,
                    ))
              ],
            );
          }),
    );
  }
}
