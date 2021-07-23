import 'package:flutter/material.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';
import 'package:sura_flutter/sura_flutter.dart';

class UserGuidanceExample extends StatefulWidget {
  const UserGuidanceExample({Key? key}) : super(key: key);

  @override
  _UserGuidanceExampleState createState() => _UserGuidanceExampleState();
}

class _UserGuidanceExampleState extends State<UserGuidanceExample> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return UserGuidance(
      guides: [
        Guide(
          rect: Rect.fromCenter(
            center: Offset(
              size.width / 2,
              size.height / 2 + 40,
            ),
            width: 90,
            height: 46,
          ),
          tooltipAlignment: Alignment.bottomCenter,
          rectDecoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.white),
          tooltip: GuideToolTip(
            arrowTranslatePoint: size.width / 2 - 22,
            margin: EdgeInsets.only(top: 100, left: 16, right: 16),
            child: Text(
              "Alignment(0.0, 0.0) represents the center of the rectangle. The distance from -1.0 to +1.0 is the distance from one side of the rectangle to the other side of the rectangle. Therefore, 2.0 units horizontally (or vertically) is equivalent to the width (or height) of the rectangl",
            ),
          ),
        ),
        Guide(
          rect: Rect.fromCenter(
            center: Offset(
              size.width - 44,
              size.height - 44,
            ),
            width: 64,
            height: 64,
          ),
          tooltipAlignment: Alignment.topRight,
          rectDecoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          tooltip: GuideToolTip(
            arrowTranslatePoint: 44,
            padding: EdgeInsets.all(8),
            child: Text(
              "Click here",
            ),
          ),
        ),
      ],
      duration: Duration(milliseconds: 400),
      child: Scaffold(
        appBar: UIHelper.CustomAppBar(title: "User Guidance"),
        body: Center(
          child: ElevatedButton(
            child: Text("Login"),
            onPressed: () {},
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Click");
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class UserGuidance extends StatefulWidget {
  final Widget child;
  final List<Guide> guides;
  final Duration duration;
  const UserGuidance({
    Key? key,
    required this.child,
    required this.guides,
    required this.duration,
  }) : super(key: key);

  @override
  _UserGuidanceState createState() => _UserGuidanceState();
}

class _UserGuidanceState extends State<UserGuidance> {
  late GuidanceController _controller;

  @override
  void initState() {
    _controller = GuidanceController(widget.guides.length);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          widget.child,
          ValueListenableBuilder<GuidanceStep>(
            valueListenable: _controller,
            builder: (_, value, child) {
              return AnimatedSwitcher(
                duration: widget.duration,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: value.visible ? SizedBox(key: ValueKey(0), child: child) : const SizedBox(key: ValueKey(1)),
              );
            },
            child: GestureDetector(
              onTap: () {
                _controller.next();
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black87,
                        BlendMode.srcOut,
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              width: double.infinity,
                              color: Colors.black54,
                            ),
                          ),
                          Stack(
                            children: [
                              ValueListenableBuilder<GuidanceStep>(
                                valueListenable: _controller,
                                builder: (context, value, child) {
                                  final guide = widget.guides[value.step];
                                  return AnimatedPositioned.fromRect(
                                    duration: widget.duration,
                                    rect: guide.rect,
                                    child: AnimatedContainer(
                                      duration: widget.duration,
                                      decoration: guide.rectDecoration,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ValueListenableBuilder<GuidanceStep>(
                    valueListenable: _controller,
                    builder: (context, value, child) {
                      final guide = widget.guides[value.step];
                      return AnimatedSwitcher(
                        duration: widget.duration,
                        child: Align(
                          alignment: guide.getAlignment(context),
                          child: Material(
                            color: Colors.transparent,
                            child: guide.tooltip,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Guide {
  ///Rectangle that specific the widget you want to focus
  final Rect rect;

  ///Decoration of the rect
  final Decoration rectDecoration;

  ///A text to display
  final GuideToolTip tooltip;

  final Alignment tooltipAlignment;

  Guide({
    required this.rect,
    required this.tooltip,
    required this.tooltipAlignment,
    this.rectDecoration = const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
    ),
  }) {
    tooltip.setGuide = this;
  }

  Rect getRect() {
    return rect.translate(-50, -50);
  }

  Alignment getAlignment(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double alignValuePerPixel = 2 / size.height;
    double yAlign = 0;

    if (tooltipAlignment.y < 0) {
      ///Alignment top
      yAlign = (alignValuePerPixel * (rect.top)) - 1;
      yAlign -= alignValuePerPixel * 12;
    } else {
      ///Alignment bottom
      yAlign = (alignValuePerPixel * (rect.bottom + rect.height)) - 1;
      yAlign += alignValuePerPixel * 12;
      //
    }

    return Alignment(tooltipAlignment.x, yAlign);
  }

  Alignment getArrowAlignment(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double alignValuePerPixel = 2 / size.height;
    double yAlign = 0;

    if (tooltipAlignment.y < 0) {
      ///Alignment top
      yAlign = (alignValuePerPixel * (rect.top)) - 1;
    } else {
      ///Alignment bottom
      yAlign = (alignValuePerPixel * rect.bottom) - 1;
    }
    print(yAlign);
    return Alignment(0.0, yAlign);
  }
}

class GuideToolTip extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double arrowTranslatePoint;
  GuideToolTip({
    Key? key,
    required this.child,
    required this.arrowTranslatePoint,
    this.padding,
    this.margin,
  }) : super(key: key);

  late final Guide _guide;

  void set setGuide(Guide guide) => this._guide = guide;

  CrossAxisAlignment getCrossAlignment() {
    return CrossAxisAlignment.start;
    // if (_guide.tooltipAlignment.x < 0) {
    //   return CrossAxisAlignment.start;
    // } else if (_guide.tooltipAlignment.x > 0) {
    //   return CrossAxisAlignment.end;
    // } else {
    //   return CrossAxisAlignment.center;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final toolTipBox = Container(
      child: child,
      padding: padding ?? const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: SuraDecoration.radius(),
      ),
    );
    final arrow = Transform.translate(
      offset: Offset(arrowTranslatePoint, 0.0),
      child: RotatedBox(
        quarterTurns: -_guide.tooltipAlignment.y.toInt(),
        child: ClipPath(
          clipper: GuideToolTipClipper(),
          child: Container(
            width: 12,
            height: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
    List<Widget> children = [];
    if (_guide.tooltipAlignment.y > 0) {
      children.addAll([arrow, toolTipBox]);
    } else {
      children.addAll([toolTipBox, arrow]);
    }

    return Container(
      margin: margin ?? const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: getCrossAlignment(),
        children: children,
      ),
    );
  }
}

class GuideToolTipClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class GuidanceStep {
  final bool visible;
  final int step;

  const GuidanceStep({
    required this.visible,
    required this.step,
  });
}

class GuidanceController extends ValueNotifier<GuidanceStep> {
  final int totalStep;
  GuidanceController(this.totalStep)
      : super(GuidanceStep(
          visible: true,
          step: 0,
        ));

  void next() {
    if (value.step + 1 < totalStep) {
      value = GuidanceStep(
        visible: value.visible,
        step: value.step + 1,
      );
    } else {
      _hide();
    }
  }

  void _hide() {
    value = GuidanceStep(
      visible: false,
      step: value.step,
    );
  }
}
