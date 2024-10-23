import 'package:ecovibe/Providers/like_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    initTts();
    super.initState();
  }

  FlutterTts ffTts = FlutterTts();
  void initTts() async {
    await ffTts.setLanguage("en-US");
    await ffTts.setSpeechRate(0.4);
    await ffTts.setPitch(1.0);
  }

  void _speak(String text) async {
    await ffTts.speak(text);
  }

  final List<String> screens = [
    'The secret of getting ahead is getting started',
    'You don\'t have to be great to start, but you have to start to be great',
    'It always seems impossible until it’s done',
    'The only way to do great work is to love what you do',
    '"Don\'t watch the clock; do what it does. Keep going'
  ];

  @override
  Widget build(BuildContext context) {
    final double totalHeight = MediaQuery.of(context).size.height;
    final double totalWidth = MediaQuery.of(context).size.width;

    Provider.of<LikeProvider>(context, listen: false)
        .genreateLike(screens.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            )),
      ),
      body: PageView.builder(
          itemCount: screens.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
              onDoubleTap: () {
                Provider.of<LikeProvider>(context, listen: false)
                    .makeLiked(index);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: totalWidth,
                    height: totalHeight,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -0.2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 8),
                      child: Text(
                        screens[index],
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 36,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        Share.share(screens[index]);
                      },
                      child: Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  Positioned(
                      right: 20,
                      bottom: 100,
                      child: GestureDetector(
                        onTap: () {
                          _speak(screens[index]);
                          debugPrint('Edokati Chepubey');
                        },
                        child: Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 36,
                        ),
                      )),
                  Positioned(
                      bottom: 10,
                      child: Consumer<LikeProvider>(
                          builder: (context, like, child) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                like.makeDislike(index);
                              },
                              child: Icon(
                                like.isLiked(index)
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: like.isLiked(index)
                                    ? Colors.red
                                    : Colors.white,
                                size: 50,
                              ),
                            ),
                          ],
                        );
                      }))
                ],
              ),
            );
          }),
    );
  }
}
