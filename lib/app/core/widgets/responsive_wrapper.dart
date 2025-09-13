import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A responsive wrapper that displays the app in an iPhone frame on desktop
/// and uses full screen on mobile devices
class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Check if we're on web and screen is wide enough for desktop layout
    if (kIsWeb && MediaQuery.of(context).size.width > 768) {
      return _DesktopLayout(child: child);
    }

    // Mobile layout - use full screen
    return child;
  }
}

class _DesktopLayout extends StatelessWidget {
  final Widget child;

  const _DesktopLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final scale = (screenSize.height * 0.85) / 812; // Use 85% of screen height
    final phoneWidth = 375 * scale;
    final phoneHeight = 812 * scale;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary, // Primary color background
      body: Center(
        child: Container(
          width: phoneWidth,
          height: phoneHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40 * scale),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              // iPhone frame/bezel
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40 * scale),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2c2c2c), Color(0xFF1a1a1a)],
                  ),
                ),
                padding: EdgeInsets.all(8 * scale),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32 * scale),
                    color: Colors.black,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32 * scale),
                    child: ScrollConfiguration(
                      behavior: const _TouchScrollBehavior(),
                      child: MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          padding: EdgeInsets.only(
                            top: 50 * scale, // Safe area for Dynamic Island
                            bottom: 20 * scale, // Safe area for home indicator
                          ),
                        ),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
              // Home indicator (iPhone bottom bar)
              Positioned(
                bottom: 12 * scale,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 134 * scale,
                    height: 5 * scale,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2.5 * scale),
                    ),
                  ),
                ),
              ),
              // Dynamic Island (top notch area)
              Positioned(
                top: 20 * scale,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 126 * scale,
                    height: 37 * scale,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(18.5 * scale),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom scroll behavior that enables touch scrolling on desktop
class _TouchScrollBehavior extends MaterialScrollBehavior {
  const _TouchScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
  };
}
