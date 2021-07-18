import 'dart:math';
import 'package:flutter/material.dart';

class StellaThemeData {
  /// Angle of light on the xOy plane in radians. This value must be within
  /// range [0, 2pi).
  final double shadowTheta;

  /// Angle of light on the θOz plane in radians. This value must be within
  /// range (0, pi/2).
  final double shadowDelta;

  /// Shadow intensity. The greater the intensity is the more apparent it
  /// looks like.
  final double shadowIntensity;

  /// Background color.
  final Color backgroundColor;

  /// Background color.
  final Color foregroundColor;

  /// Background color.
  final Color hintColor;

  /// Background color and canvas color, somewhere in between.
  final Color backgroundCanvasColor;

  /// Canvas color.
  final Color canvasColor;

  /// Animation duration for fast changes / tickers.
  final Duration tickerDuration;

  /// Animation duration.
  final Duration animationDuration;

  /// Page padding.
  final EdgeInsets padding;

  /// Padding between tiles.
  final double tilePadding;

  /// Padding between blocks.
  final double blockPadding;

  StellaThemeData({
    this.shadowTheta = pi * 3 / 4,
    this.shadowDelta = pi / 4,
    this.shadowIntensity = 0.15,
    // this.backgroundColor = const Color.fromARGB(0xff, 226, 234, 242),
    this.backgroundColor = const Color.fromARGB(0xff, 212, 222, 236),
    this.foregroundColor = Colors.black,
    this.hintColor = const Color(0xff959595),
    this.backgroundCanvasColor = const Color.fromARGB(0xff, 212, 222, 236),
    this.canvasColor = const Color.fromARGB(0xff, 208, 218, 232),
    this.tickerDuration = const Duration(milliseconds: 80),
    this.animationDuration = const Duration(milliseconds: 200),
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
    this.tilePadding = 15.0,
    this.blockPadding = 40.0,
  }) {
    assert(shadowTheta >= 0.0 && shadowTheta < pi * 2);
    assert(shadowDelta > 0.0 && shadowDelta < pi / 2);
    assert(shadowIntensity >= 0.0 && shadowIntensity <= 1.0);
  }

  factory StellaThemeData.defaultLight() {
    return StellaThemeData();
  }

  factory StellaThemeData.defaultDark() {
    return StellaThemeData();
  }
}

class StellaTheme extends StatelessWidget {
  /// Child widget.
  final Widget child;

  /// Theme shown when [ThemeData.brightness] is light.
  late final StellaThemeData lightTheme;

  /// Theme shown when [ThemeData.brightness] is dark.
  late final StellaThemeData darkTheme;

  StellaTheme({
    required this.child,
    StellaThemeData? lightTheme,
    StellaThemeData? darkTheme,
  }) {
    this.lightTheme = lightTheme ?? StellaThemeData.defaultLight();
    this.darkTheme = darkTheme ?? StellaThemeData.defaultDark();
  }

  static StellaThemeData of(BuildContext context) {
    final StellaTheme? result =
        context.findAncestorWidgetOfExactType<StellaTheme>();
    // no ancestors
    if (result == null)
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
            'StellaTheme.of() called with a context that does not contain '
            'a StellaTheme.'),
        ErrorDescription(
            'No StellaTheme ancestor could be found starting from the context '
            'that was passed to StellaTheme.of(). This usually happens when the '
            'context provided is from the same StatefulWidget as that whose '
            'build function actually creates the StellaTheme widget being '
            'sought.'),
        context.describeElement('The context used was')
      ]);
    // determine upon brightness
    late StellaThemeData data;
    if (Theme.of(context).brightness == Brightness.dark)
      data = result.darkTheme;
    else
      data = result.lightTheme;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

enum NeuShape {
  Flat,
  Concave,
  Convex,
  Pressed,
}

class NeuContainer extends StatelessWidget {
  final Widget? child;
  final double elevation;
  final double radius;
  final NeuShape shape;
  final Color? overrideColor;
  final double? overrideTheta;

  NeuContainer({
    Key? key,
    required this.child,
    this.elevation = 18.0,
    this.radius = 18.0,
    this.shape = NeuShape.Flat,
    this.overrideColor,
    this.overrideTheta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StellaThemeData sTheme = StellaTheme.of(context);
    bool outerShadow = this.shape != NeuShape.Pressed;
    return Container(
      child: ClipRRect(
        child: child,
        borderRadius: BorderRadius.circular(radius),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          _getShadow(sTheme, 1.0, outerShadow), // bright side
          _getShadow(sTheme, -1.0, outerShadow), // dark side
        ],
        gradient: _gradient(sTheme),
      ),
    );
  }

  BoxShadow _getShadow(StellaThemeData sTheme, double scale, bool outer) {
    double theta = overrideTheta ?? sTheme.shadowTheta;
    double dxOy = elevation / tan(sTheme.shadowDelta),
        dx = dxOy * cos(theta) * scale,
        dy = -dxOy * sin(theta) * scale; // reversed y axis
    Color color = _luminate(overrideColor ?? sTheme.backgroundColor,
        sTheme.shadowIntensity * scale);
    Offset offset = Offset(dx, dy);
    double blurRadius = dxOy * 1.414;
    return BoxShadow(color: color, offset: offset, blurRadius: blurRadius);
  }

  Color _luminate(Color color, double ratio) {
    // TODO: might as well use the HSL method.
    return Color.fromARGB(
      color.alpha,
      min(max((color.red.toDouble() * (1.0 + ratio)).round(), 0x00), 0xff),
      min(max((color.green.toDouble() * (1.0 + ratio)).round(), 0x00), 0xff),
      min(max((color.blue.toDouble() * (1.0 + ratio)).round(), 0x00), 0xff),
    );
  }

  Gradient _gradient(StellaThemeData sTheme) {
    Color colorFlat = overrideColor ?? sTheme.backgroundColor;
    late Color colorBegin, colorEnd;
    if (shape == NeuShape.Flat || shape == NeuShape.Pressed) {
      colorBegin = colorEnd = colorFlat;
    } else if (shape == NeuShape.Concave) {
      colorBegin = _luminate(colorFlat, -0.1);
      colorEnd = _luminate(colorFlat, 0.07);
    } else if (shape == NeuShape.Convex) {
      colorBegin = _luminate(colorFlat, 0.07);
      colorEnd = _luminate(colorFlat, -0.1);
    }
    return LinearGradient(
      // stretch it to corners
      begin: Alignment.topRight,
      colors: [colorBegin, colorEnd],
      end: Alignment.bottomLeft,
      transform: GradientRotation(-sTheme.shadowTheta + pi / 4),
    );
  }
}

class NeuButton extends StatefulWidget {
  final Widget child;
  final double elevation;
  final double radius;
  final NeuShape shape;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  NeuButton({
    Key? key,
    required this.child,
    this.elevation = 18.0,
    this.radius = 18.0,
    this.shape = NeuShape.Flat,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  @override
  _NeuButtonState createState() =>
      _NeuButtonState(child, elevation, radius, shape);
}

class _NeuButtonState extends State<NeuButton> with TickerProviderStateMixin {
  Widget child;
  double height;
  double radius;
  NeuShape shape;

  /// If the button is currently being pressed down.
  bool pressed = false;

  /// Animation controller
  late AnimationController _animationController;

  _NeuButtonState(this.child, this.height, this.radius, this.shape);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      value: pressed ? 1.0 : 0.0,
      lowerBound: 0.0,
      upperBound: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void didUpdateWidget(NeuButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) this.child = widget.child;
    if (oldWidget.elevation != widget.elevation) this.height = widget.elevation;
    if (oldWidget.radius != widget.radius) this.radius = widget.radius;
    if (oldWidget.shape != widget.shape) this.shape = widget.shape;
  }

  @override
  Widget build(BuildContext context) {
    StellaThemeData sTheme = StellaTheme.of(context);
    return GestureDetector(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? _child) => NeuContainer(
          child: _child,
          elevation: height * (1.0 - _animationController.value * 0.5),
          radius: radius * (1.0 - _animationController.value * 0.2),
          shape: shape,
        ),
        child: child,
      ),
      onTapDown: (x) {
        pressed = true;
        _animationController.animateTo(1.0, duration: sTheme.tickerDuration);
      },
      onTapUp: (x) {
        pressed = false;
        _animationController.animateTo(0.0, duration: sTheme.tickerDuration);
      },
      onTapCancel: () {
        pressed = false;
        _animationController.animateTo(0.0, duration: sTheme.tickerDuration);
      },
      onTap: widget.onPressed,
      onLongPress: widget.onLongPress,
    );
  }
}

Widget neuIconButton(BuildContext context, IconData icon) {
  StellaThemeData sTheme = StellaThemeData.defaultLight();
  return NeuButton(
    child: Container(
      child: Icon(
        icon,
        size: 20.0,
        color: sTheme.hintColor,
      ),
      width: 40.0,
      height: 35.0,
      alignment: Alignment.center,
    ),
    radius: 8.0,
    elevation: 6.0,
    shape: NeuShape.Concave,
  );
}

class StellaPageScaffold extends StatelessWidget {
  /// Background before the scrolly thingy.
  final Widget background;

  /// The entire body. (We don't talk strict performance here)
  final Widget body;

  /// Where does the scrolly background begins.
  final double topExtent;

  StellaPageScaffold({
    required this.background,
    required this.body,
    required this.topExtent,
  });

  @override
  Widget build(BuildContext context) {
    StellaThemeData sTheme = StellaThemeData.defaultLight();
    return StellaTheme(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: sTheme.canvasColor,
            ),
            background,
            ListView(
              // makes it scrollable
              children: [
                Container(
                  // the padding
                  height: topExtent,
                ),
                NeuContainer(
                  child: body,
                  elevation: 12.0,
                  radius: 30.0,
                  shape: NeuShape.Flat,
                  overrideTheta: pi * 10 / 9,
                  overrideColor: sTheme.backgroundCanvasColor,
                ),
              ],
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
            ),
          ],
          alignment: AlignmentDirectional.topCenter,
        ),
      ),
      lightTheme: null,
      darkTheme: null,
    );
  }
}

class NeuProgressBar extends StatelessWidget {
  final Color color;
  final Color glowColor;
  final double percentage;

  NeuProgressBar({
    Key? key,
    required this.color,
    required this.glowColor,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NeuContainer(
        child: Row(
          children: [
            Expanded(
              // highlighted part of progress bar
              child: Container(
                height: 8.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4.0),
                  boxShadow: [
                    BoxShadow(
                      color: glowColor,
                      blurRadius: 20.0,
                    )
                  ],
                ),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  left: 4.0,
                ),
              ),
              flex: (percentage * 100).round(),
            ),
            Expanded(
              // fill blank
              child: Container(),
              flex: (100.0 - percentage * 100).round(),
            ),
          ],
        ),
        radius: 8.0,
        elevation: 4.0,
        shape: NeuShape.Concave,
      ),
    );
  }
}
