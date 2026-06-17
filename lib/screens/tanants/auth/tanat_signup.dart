import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tanat_login.dart';

class TenantSignupPage extends StatefulWidget {
  const TenantSignupPage({super.key});

  @override
  State<TenantSignupPage> createState() => _TenantSignupPageState();
}

class _TenantSignupPageState extends State<TenantSignupPage>
    with TickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeTerms = false;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _headerSlide;
  late Animation<Offset> _formSlide;

  static const Color _primary = Color(0xFF7B6FD0);
  static const Color _primaryLight = Color(0xFFAFA9EC);
  static const Color _primaryGlow = Color(0xFF5B50C8);

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnim = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));
    _formSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0818),
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/hero.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.3, 0.6, 1.0],
                colors: [
                  Color(0x99000000),
                  Color(0x55000000),
                  Color(0xBB000000),
                  Color(0xF0000000),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0x221A0D3D),
                  Color(0x110D0818),
                  Color(0x332D1F6B),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.55,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0x777B6FD0),
                    Color(0x007B6FD0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _primary.withOpacity(0.25),
                    _primary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          FadeTransition(
            opacity: _fadeAnim,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      SlideTransition(
                        position: _headerSlide,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _GlassIconButton(
                              icon: Icons.arrow_back_ios_new_rounded,
                              accentColor: _primary,
                              onTap: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SlideTransition(
                        position: _headerSlide,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _primary.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: _primary.withOpacity(0.35),
                                  width: 0.8,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: _primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Tenant Portal',
                                    style: TextStyle(
                                      color: _primaryLight,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            const Text(
                              'Create your\naccount',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.1,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Start your journey to find the perfect home.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.55),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      SlideTransition(
                        position: _formSlide,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: _primary.withOpacity(0.2),
                              width: 0.8,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _DarkInputField(
                                controller: _nameController,
                                hint: 'Full name',
                                prefixIcon: Icons.person_outline_rounded,
                                accentColor: _primary,
                                keyboardType: TextInputType.name,
                              ),
                              const SizedBox(height: 12),
                              _DarkInputField(
                                controller: _emailController,
                                hint: 'Email address',
                                prefixIcon: Icons.mail_outline_rounded,
                                accentColor: _primary,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 12),
                              _DarkInputField(
                                controller: _passwordController,
                                hint: 'Password',
                                prefixIcon: Icons.lock_outline_rounded,
                                accentColor: _primary,
                                obscureText: _obscurePassword,
                                suffixIcon: GestureDetector(
                                  onTap: () => setState(() =>
                                      _obscurePassword = !_obscurePassword),
                                  child: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.white.withOpacity(0.4),
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              _DarkInputField(
                                controller: _confirmPasswordController,
                                hint: 'Confirm password',
                                prefixIcon: Icons.lock_outline_rounded,
                                accentColor: _primary,
                                obscureText: _obscureConfirm,
                                suffixIcon: GestureDetector(
                                  onTap: () => setState(() =>
                                      _obscureConfirm = !_obscureConfirm),
                                  child: Icon(
                                    _obscureConfirm
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.white.withOpacity(0.4),
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              GestureDetector(
                                onTap: () => setState(
                                    () => _agreeTerms = !_agreeTerms),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: _agreeTerms
                                            ? _primary
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        border: Border.all(
                                          color: _agreeTerms
                                              ? _primary
                                              : Colors.white.withOpacity(0.3),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: _agreeTerms
                                          ? const Icon(
                                              Icons.check,
                                              size: 14,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            height: 1.4,
                                          ),
                                          children: [
                                            const TextSpan(
                                              text:
                                                  'I agree to the ',
                                            ),
                                            TextSpan(
                                              text: 'Terms of Service',
                                              style: TextStyle(
                                                color: _primaryLight,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const TextSpan(text: ' and '),
                                            TextSpan(
                                              text: 'Privacy Policy',
                                              style: TextStyle(
                                                color: _primaryLight,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              _PressableButton(
                                label: 'Create account',
                                primaryColor: _primary,
                                glowColor: _primaryGlow,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SlideTransition(
                        position: _formSlide,
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.white.withOpacity(0.12),
                                thickness: 0.5,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: Text(
                                'or continue with',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.white.withOpacity(0.12),
                                thickness: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SlideTransition(
                        position: _formSlide,
                        child: Row(
                          children: [
                            Expanded(
                              child: _DarkSocialButton(
                                icon: Icons.g_mobiledata_rounded,
                                label: 'Google',
                                accentColor: _primary,
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _DarkSocialButton(
                                icon: Icons.apple_rounded,
                                label: 'Apple',
                                accentColor: _primary,
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      SlideTransition(
                        position: _formSlide,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                _slideRoute(const TenantLoginPage()),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.35),
                                ),
                                children: [
                                  const TextSpan(
                                      text: 'Already have an account? '),
                                  TextSpan(
                                    text: 'Log in',
                                    style: TextStyle(
                                      color: _primaryLight,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Center(
                        child: Container(
                          width: 120,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Route _slideRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;

  const _GlassIconButton({
    required this.icon,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: accentColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: accentColor.withOpacity(0.25),
            width: 0.5,
          ),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _DarkInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final Color accentColor;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const _DarkInputField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    required this.accentColor,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: accentColor.withOpacity(0.2),
          width: 0.8,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.28),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: accentColor.withOpacity(0.6),
            size: 20,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

class _PressableButton extends StatefulWidget {
  final String label;
  final Color primaryColor;
  final Color glowColor;
  final VoidCallback onTap;

  const _PressableButton({
    required this.label,
    required this.primaryColor,
    required this.glowColor,
    required this.onTap,
  });

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0,
      upperBound: 1,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            color: widget.primaryColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(0.4),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DarkSocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color accentColor;
  final VoidCallback onTap;

  const _DarkSocialButton({
    required this.icon,
    required this.label,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_DarkSocialButton> createState() => _DarkSocialButtonState();
}

class _DarkSocialButtonState extends State<_DarkSocialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0,
      upperBound: 1,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: widget.accentColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.accentColor.withOpacity(0.25),
              width: 0.8,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 22, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
