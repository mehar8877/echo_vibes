import 'package:ecovibe/Providers/color_provider.dart';
import 'package:google_fonts/google_fonts.dart';
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
  FlutterTts ffTts = FlutterTts();

  final List<String> screens = [
    'The secret of getting ahead is getting started',
    'You don\'t have to be great to start, but you have to start to be great',
    'It always seems impossible until it’s done',
    'The only way to do great work is to love what you do',
    '"Don\'t watch the clock; do what it does. Keep going'
  ];
  //int count = 0, bc = 0;
  @override
  void initState() {
    initTts();
    Provider.of<LikeProvider>(context, listen: false)
        .genreateLike(screens.length);
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
    final double totalHeight = MediaQuery.of(context).size.height;
    final double totalWidth = MediaQuery.of(context).size.width;
    final colorProvider = Provider.of<ColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorProvider.currentGradient[0],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
        ),
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
        itemCount: screens.length,
        scrollDirection: Axis.vertical,
        onPageChanged: (ind) {
          colorProvider.generateRandomGradient();
        },
        itemBuilder: (context, index) {
          
          return GestureDetector(
            //key: ValueKey(index),
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
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: colorProvider.currentGradient,
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0, -0.2),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: Text(
                      screens[index],
                      style: GoogleFonts.raleway(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  child: Consumer<LikeProvider>(
                    builder: (context, like, child) {
                      if (like.isDobuleTapped) {
                        return TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(seconds: 1),
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
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                Positioned(
                  bottom: 36,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      Share.share(screens[index]);
                    },
                    child: const Icon(
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
                    child: const Icon(
                      Icons.speaker_phone,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 160,
                  right: 20,
                  child: Consumer<LikeProvider>(
                    builder: (context, like, child) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              like.toggle(index);
                            },
                            child: Icon(
                              like.isLiked(index)
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: like.isLiked(index)
                                  ? Colors.red
                                  : Colors.white,
                              size: 36,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
