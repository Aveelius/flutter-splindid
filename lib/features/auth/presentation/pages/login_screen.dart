import 'package:flutter/material.dart';
import 'package:pasar_splindid_app/core/widgets/shared_widgets.dart';
import 'package:pasar_splindid_app/features/home/presentation/pages/main_shell.dart';
import 'package:pasar_splindid_app/features/auth/presentation/pages/register_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.registered = false});
  final bool registered;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late final _email = TextEditingController(text: DemoAccount.email);
  late final _password = TextEditingController(text: DemoAccount.password);
  bool _rememberMe = true;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    if (widget.registered) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registrasi berhasil. Silakan masuk dengan akun baru.')),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (_email.text.trim().toLowerCase() != DemoAccount.email.toLowerCase() ||
          _password.text != DemoAccount.password) {
        showInfo(context, 'Login gagal', 'Email atau kata sandi tidak sesuai. Gunakan akun demo atau akun yang baru didaftarkan.');
        return;
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const MainShell()),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF6F8FA),
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            final wide = constraints.maxWidth >= 600;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: wide ? 520 : 440),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 18),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16, left: 26),
                      child: _brand(),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        _hero(),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _brand(compact: true),
                                const SizedBox(height: 18),
                                const Text('Selamat Datang', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1C2A40))),
                                const SizedBox(height: 6),
                                const Text('Masuk untuk menjelajahi pasar dan terhubung dengan komunitas Splendid.', style: TextStyle(color: Color(0xFF708098), height: 1.45)),
                                const SizedBox(height: 9),
                                Container(width: double.infinity, padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFEAF5EF), borderRadius: BorderRadius.circular(9)), child: Text('Akun demo: ${DemoAccount.email}\nKata sandi: ${DemoAccount.password}', style: const TextStyle(color: Color(0xFF176126), fontSize: 11, height: 1.45))),
                                const SizedBox(height: 18),
                                const Text('Email', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 7),
                                TextFormField(
                                  controller: _email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: _inputDecoration('aulia.putri@email.com', Icons.mail_outline),
                                  validator: (value) {
                                    final email = value?.trim() ?? '';
                                    if (email.isEmpty || !email.contains('@') || !email.contains('.')) return 'Masukkan alamat email yang valid';
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                const Text('Password', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 7),
                                TextFormField(
                                  controller: _password,
                                  obscureText: _obscurePassword,
                                  decoration: _inputDecoration('Masukkan password', Icons.lock_outline).copyWith(
                                    suffixIcon: IconButton(
                                      tooltip: _obscurePassword ? 'Tampilkan password' : 'Sembunyikan password',
                                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                      icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 19, color: const Color(0xFF718096)),
                                    ),
                                  ),
                                  validator: (value) => (value?.isEmpty ?? true) ? 'Password wajib diisi' : null,
                                ),
                                const SizedBox(height: 7),
                                Row(children: [
                                  SizedBox(width: 32, height: 32, child: Checkbox(value: _rememberMe, activeColor: const Color(0xFF00A875), onChanged: (value) => setState(() => _rememberMe = value ?? false), visualDensity: VisualDensity.compact)),
                                  const Text('Ingat saya', style: TextStyle(fontSize: 12)),
                                  const Spacer(),
                                  TextButton(onPressed: () => showInfo(context, 'Lupa password?', 'Fitur pemulihan password akan segera tersedia.'), child: const Text('Lupa password?', style: TextStyle(color: Color(0xFF008F63), fontWeight: FontWeight.w700, fontSize: 12))),
                                ]),
                                const SizedBox(height: 5),
                                SizedBox(width: double.infinity, height: 48, child: FilledButton(
                                  onPressed: _login,
                                  style: FilledButton.styleFrom(backgroundColor: const Color(0xFF00A875), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
                                  child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Masuk', style: TextStyle(fontWeight: FontWeight.w700)), SizedBox(width: 10), Icon(Icons.arrow_forward, size: 18)]),
                                )),
                                const SizedBox(height: 14),
                                Center(child: Wrap(alignment: WrapAlignment.center, children: [
                                  const Text('Belum punya akun? ', style: TextStyle(color: Color(0xFF708098), fontSize: 12)),
                                  GestureDetector(onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const RegisterPage())), child: const Text('Daftar sekarang', style: TextStyle(color: Color(0xFF008F63), fontWeight: FontWeight.w700, fontSize: 12))),
                                ])),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    const Text('© 2026 Pasar Splendid Malang  Kebijakan Privasi   •   Syarat & Ketentuan', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF708098), fontSize: 10)),
                  ],
                ),
              ),
            );
          }),
        ),
      );

  Widget _brand({bool compact = false}) => Row(children: [
        Container(width: compact ? 38 : 38, height: compact ? 38 : 38, decoration: BoxDecoration(color: const Color(0xFF00A875), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.spa_outlined, color: Colors.white, size: 25)),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Pasar Splendid', style: TextStyle(fontWeight: FontWeight.w800, color: const Color(0xFF1C2A40), fontSize: compact ? 17 : 18)),
          const Text('MALANG • SEJAK 1960', style: TextStyle(color: Color(0xFF708098), fontSize: 9, letterSpacing: .3)),
        ]),
      ]);

  Widget _hero() => SizedBox(
        height: 260,
        width: double.infinity,
        child: Stack(fit: StackFit.expand, children: [
          Image.asset('assets/images/market_hero.png', fit: BoxFit.cover),
          Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black.withValues(alpha: .08), const Color(0xFF111827).withValues(alpha: .88)]))),
          Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9), decoration: BoxDecoration(color: Colors.white.withValues(alpha: .9), borderRadius: BorderRadius.circular(20)), child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.location_on_outlined, color: Color(0xFF00A875), size: 15), SizedBox(width: 6), Text('MALANG, JAWA TIMUR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF1C2A40)))])),
            const Spacer(),
            const Text('Temukan kehidupan.\nTumbuhkan koneksi.', style: TextStyle(color: Colors.white, fontSize: 25, height: 1.15, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Jelajahi kekayaan Pasar Splendid, temui pedagang lokal, dan berbagi cerita bersama komunitas.', style: TextStyle(color: Color(0xFFE5E7EB), fontSize: 12, height: 1.45)),
            const SizedBox(height: 10),
            const Row(children: [Text('340+', style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800)), SizedBox(width: 12), Text('Anggota berbagi inspirasi\nsetiap hari.', style: TextStyle(color: Color(0xFFE5E7EB), fontSize: 11, height: 1.4))]),
          ])),
        ]),
      );

  InputDecoration _inputDecoration(String hint, IconData icon) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF718096), fontSize: 13),
        prefixIcon: Icon(icon, size: 18, color: const Color(0xFF718096)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: const BorderSide(color: Color(0xFFDCE3EB))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: const BorderSide(color: Color(0xFFDCE3EB))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: const BorderSide(color: Color(0xFF00A875), width: 1.5)),
      );
}
