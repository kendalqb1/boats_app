import 'package:boats_app/models/boat.dart';
import 'package:boats_app/screens/boat_details.dart';
import 'package:boats_app/widgets/card_boat.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late ValueNotifier<double> _pageNotifier;
  late ValueNotifier<bool> _appBarNotifier;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.7);
    _pageController.addListener(_pageListener);
    _pageNotifier = ValueNotifier(0.0);
    _appBarNotifier = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() => _pageNotifier.value = _pageController.page!;

  void _openDetails(BuildContext context, Boat boat) async {
    _appBarNotifier.value = true;
    await Navigator.push(
      context,
      PageRouteBuilder(
        reverseTransitionDuration: const Duration(milliseconds: 600),
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, animationTwo) {
          return FadeTransition(
            opacity: animation,
            child: BoatDetails(boat: boat),
          );
        },
      ),
    );
    _appBarNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: ValueListenableBuilder<bool>(
              valueListenable: _appBarNotifier,
              builder: (context, value, _) {
                return _CustomAppBar(animate: value);
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: Boat.boats.length,
              itemBuilder: (context, index) {
                final boat = Boat.boats[index];
                return ValueListenableBuilder<double>(
                  valueListenable: _pageNotifier,
                  builder: (context, value, _) {
                    final factorChange = (value - index).abs();
                    return CardBoat(
                      boat: boat,
                      factorChange: factorChange,
                      onTap: () => _openDetails(context, boat),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final bool animate;

  const _CustomAppBar({
    Key? key,
    required this.animate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 600),
      transform: Matrix4.translationValues(0, animate ? -100 : 0, 0),
      child: AnimatedOpacity(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 600),
        opacity: animate ? 0 : 1,
        child: SizedBox(
          height: kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Boats',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                  color: Colors.grey[800],
                  iconSize: 35,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
