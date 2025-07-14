import 'package:bintar_sepuh/pages/auth/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _textFadeController;
  late AnimationController _backgroundDissolveController;
  late AnimationController _loadingController;

  late Animation<double> _textFadeAnimation;
  late Animation<double> _backgroundDissolveAnimation;
  late Animation<double> _loadingAnimation;

  bool showText = false;
  bool showLoading = false;
  bool showButton = false;

  @override
  void initState() {
    super.initState();

    // Setup animation controllers
    _textFadeController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _backgroundDissolveController = AnimationController(
      duration: Duration(milliseconds: 2500),
      vsync: this,
    );

    _loadingController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    // Setup animations
    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textFadeController, curve: Curves.easeInOut),
    );

    _backgroundDissolveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _backgroundDissolveController,
        curve: Curves.easeInOut,
      ),
    );

    _loadingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _loadingController, curve: Curves.easeInOut),
    );

    // Start animation sequence
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Detik ke-1: Munculin text PENSUDIS
    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      showText = true;
    });
    _textFadeController.forward();

    // Detik ke-3: Background dissolve + loading muncul
    await Future.delayed(Duration(milliseconds: 3000));
    setState(() {
      showLoading = true;
    });
    _backgroundDissolveController.forward();
    _loadingController.forward();

    // Detik ke-5: Loading berubah jadi tombol
    await Future.delayed(Duration(milliseconds: 4000));
    setState(() {
      showButton = true;
    });
  }

  @override
  void dispose() {
    _textFadeController.dispose();
    _backgroundDissolveController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  void _goToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background layer
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                // Original background image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/background_images.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Marble background overlay (dissolve effect)
                AnimatedBuilder(
                  animation: _backgroundDissolveAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _backgroundDissolveAnimation.value,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFF4E6D7),
                              Color(0xFFEBCBB5),
                              Color(0xFFD9A67A),
                              Color(0xFFBA5A31),
                            ],
                            stops: [0.0, 0.3, 0.7, 1.0],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // PENSUDIS text
                if (showText)
                  FadeTransition(
                    opacity: _textFadeAnimation,
                    child: Text(
                      'PENSUDIS',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 3,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Bottom section (Loading/Button)
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedBuilder(
                animation: _loadingAnimation,
                builder: (context, child) {
                  if (!showLoading) return SizedBox.shrink();

                  return Opacity(
                    opacity: _loadingAnimation.value,
                    child: showButton
                        ? ElevatedButton(
                            onPressed: _goToLoginPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 8,
                            ),
                            child: Text(
                              'Selanjutnya',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                                strokeWidth: 3,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Loading...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
