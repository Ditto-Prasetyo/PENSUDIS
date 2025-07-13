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
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textFadeController,
      curve: Curves.easeInOut,
    ));
    
    _backgroundDissolveAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundDissolveController,
      curve: Curves.easeInOut,
    ));
    
    _loadingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeInOut,
    ));
    
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

  void _goToMainScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
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
                      image: AssetImage('images/background_image.png'),
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
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFE8F4FD), // Light blue
                              Color(0xFFB8E6FF), // Medium blue
                              Color(0xFFFFC1CC), // Light pink
                              Color(0xFFFFB3C1), // Medium pink
                              Color(0xFF87CEEB), // Sky blue
                              Color(0xFFF8BBD9), // Light pink
                            ],
                            stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
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
                          onPressed: _goToMainScreen,
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

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PENSUDIS App'),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8F4FD),
              Color(0xFFFFC1CC),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.school,
                      size: 80,
                      color: Colors.blue.shade600,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Welcome to PENSUDIS!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ready to explore the app',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}