import 'package:flutter/material.dart';

/// Breakpoint definitions for Claritask AI responsive design.
class ResponsiveBreakpoints {
  ResponsiveBreakpoints._();

  static const double mobile = 650;
  static const double tablet = 1024;
  static const double desktop = 1200;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobile;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobile && width < tablet;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tablet;

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 900;
}

/// Extension on [BuildContext] for easy responsive checks and values.
extension ResponsiveContext on BuildContext {
  bool get isMobile => ResponsiveBreakpoints.isMobile(this);
  bool get isTablet => ResponsiveBreakpoints.isTablet(this);
  bool get isDesktop => ResponsiveBreakpoints.isDesktop(this);
  bool get isWide => ResponsiveBreakpoints.isWide(this);

  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }
}

/// A widget that switches between mobile, tablet, and desktop builders.
class ResponsiveLayout extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= ResponsiveBreakpoints.tablet && desktop != null) {
      return desktop!(context);
    }
    if (width >= ResponsiveBreakpoints.mobile && tablet != null) {
      return tablet!(context);
    }
    return mobile(context);
  }
}

/// A wrapper widget that centers content and constrains its maximum width
/// on tablet and desktop screens to prevent UI elements from stretching too wide.
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth = 1100,
    this.padding,
    this.alignment = Alignment.topCenter,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPadding = context.responsive<EdgeInsetsGeometry>(
      mobile: const EdgeInsets.symmetric(horizontal: 16),
      tablet: const EdgeInsets.symmetric(horizontal: 24),
      desktop: const EdgeInsets.symmetric(horizontal: 32),
    );

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? defaultPadding,
          child: child,
        ),
      ),
    );
  }
}
