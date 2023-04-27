import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/extensions/extensions.dart';
import 'package:dinamik_yemek_dagitim/view/bottomNavigation/bottom_curved_painter.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int)? onIconPresedCallback;
  const CustomBottomNavigationBar({super.key, this.onIconPresedCallback});

  @override
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late AnimationController _xController;
  late AnimationController _yController;
  @override
  void initState() {
    _xController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);
    _yController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);

    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _xController.value =
        _indexToPosition(_selectedIndex) / MediaQuery.of(context).size.width;
    _yController.value = 1.0;

    super.didChangeDependencies();
  }

  double _indexToPosition(int index) {
    // Calculate button positions based off of their
    // index (works with `MainAxisAlignment.spaceAround`)
    const buttonCount = 3.0;
    final appWidth = MediaQuery.of(context).size.width;
    final buttonsWidth = _getButtonContainerWidth();
    final startX = (appWidth - buttonsWidth) / 2;
    return startX +
        index.toDouble() * buttonsWidth / buttonCount +
        buttonsWidth / (buttonCount * 2.0);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  Widget _icon(IconData icon, bool isEnable, int index, {double? size}) {
    return Expanded(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        onTap: () {
          _handlePressed(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          alignment: isEnable ? Alignment.topCenter : Alignment.center,
          child: AnimatedContainer(
              height: size ?? (isEnable ? 40 : 40),
              duration: const Duration(milliseconds: 100),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isEnable ? LightColor.orange : Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: isEnable ? const Color(0xfffeece2) : Colors.white,
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: const Offset(5, 5),
                    ),
                  ],
                  shape: BoxShape.circle),
              child: Opacity(
                opacity: isEnable ? _yController.value : 1,
                child: Icon(icon,
                    color: isEnable
                        ? LightColor.background
                        : Theme.of(context).iconTheme.color),
              )),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    const inCurve = ElasticOutCurve(0.38);
    return CustomPaint(
      painter: BackgroundCurvePainter(
          _xController.value * MediaQuery.of(context).size.width,
          Tween<double>(
            begin: Curves.easeInExpo.transform(_yController.value),
            end: inCurve.transform(_yController.value),
          ).transform(_yController.velocity.sign * 0.5 + 0.5),
          Colors.white),
    );
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 400.0) {
      width = 400.0;
    }
    return width;
  }

  void _handlePressed(int index) {
    if (_selectedIndex == index || _xController.isAnimating) return;
    widget.onIconPresedCallback!(index);
    setState(() {
      _selectedIndex = index;
    });

    _yController.value = 1.0;
    _xController.animateTo(
        _indexToPosition(index) / MediaQuery.of(context).size.width,
        duration: const Duration(milliseconds: 620));
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        _yController.animateTo(1.0,
            duration: const Duration(milliseconds: 1200));
      },
    );
    _yController.animateTo(0.0, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    const height = 60.0;
    return SizedBox(
      width: appSize.width,
      height: context.dynamicHeight * 0.09,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            width: appSize.width,
            height: height - 10,
            child: _buildBackground(),
          ),
          Positioned(
            left: (appSize.width - _getButtonContainerWidth()) / 2,
            top: 0,
            width: _getButtonContainerWidth(),
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _icon(Icons.today, _selectedIndex == 0, 0),
                _icon(Icons.document_scanner_rounded, _selectedIndex == 1, 1,
                    size: 150),
                _icon(Icons.done, _selectedIndex == 2, 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
