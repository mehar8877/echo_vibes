import 'package:ecovibe/Providers/color_provider.dart';
import 'package:ecovibe/Providers/like_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:math';
// Import ColorProvider

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterTts ffTts = FlutterTts();
  late PageController _pageController;

  final List<String> screens = [
    'HI belive in yourself ,',
    'The secret of getting ahead is getting started',
    'You don\'t have to be great to start, but you have to start to be great',
    'It always seems impossible until it’s done',
    'The only way to do great work is to love what you do',
    '"Don\'t watch the clock; do what it does. Keep going'

  ];

  @override
  void initState() {
    initTts();
    _pageController = PageController();
    super.initState();
  }

  void initTts() async {
    await ffTts.setLanguage("en-IN");
    await ffTts.setSpeechRate(0.55);
    await ffTts.setPitch(0.95);
    await ffTts.setVoice({"name": "en-in-x-ene-local", "locale": "en-IN"});
  }

  void _speak(String text) async {
    await ffTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    final double totalHeight = MediaQuery.of(context).size.height;
    final double totalWidth = MediaQuery.of(context).size.width;

    final colorProvider = Provider.of<ColorProvider>(context);

    Provider.of<LikeProvider>(context, listen: false)
        .genreateLike(screens.length);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorProvider.currentGradient[0],
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.card_giftcard,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: PageView.builder(
          controller: _pageController,
          itemCount: screens.length,
          scrollDirection: Axis.vertical,
          onPageChanged: (index) {
            // Generate new random gradient on page change
            colorProvider.generateRandomGradient();
          },
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
                      color: Color.fromRGBO(random.nextInt(256),random.nextInt(256) , random.nextInt(256), 1)
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
                  Positioned(child:
                      Consumer<LikeProvider>(builder: (context, like, child) {
                    if (like.isDobuleTapped) {
                      return TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: Duration(seconds: 1),
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, -50 * value),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 50 + (50 * value),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return SizedBox.shrink();
                  })),
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
                        },
                        child: Icon(
                          Icons.speaker_phone,
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
                                like.toggle(index);
                              },
                              child:Container(
                                width: 60, // Slightly larger for a more noticeable button
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle, // Ensures the container stays circular
                                  color: Colors.white
                                ),
                                child: Icon(
                                  like.isLiked(index) ? Icons.favorite : Icons.favorite_border_outlined,
                                  color: like.isLiked(index) ? Colors.red : Colors.black,
                                  size: 30,
                                  // Slightly reduced size for balance
                                ),
                              )

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
