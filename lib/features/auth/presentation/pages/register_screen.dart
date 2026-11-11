import 'package:flutter/material.dart';
import 'package:pasar_splindid_app/core/widgets/shared_widgets.dart';
import 'package:pasar_splindid_app/features/auth/presentation/pages/login_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool _acceptedTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptedTerms) {
      showInfo(context, 'Persetujuan diperlukan', 'Setujui Syarat & Ketentuan serta Kebijakan Privasi untuk melanjutkan.');
      return;
    }
    DemoAccount.name = _name.text.trim();
    DemoAccount.email = _email.text.trim();
    DemoAccount.password = _password.text;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginPage(registered: true)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF1F4F5),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 18),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 26, bottom: 16),
                    child: _brand(),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Column(children: [
                      _registerHero(),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Buat akun baru', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1C2A40))),
                              const SizedBox(height: 5),
                              const Text('Daftar untuk menjelajahi pasar dan terhubung dengan komunitas Splendid.', style: TextStyle(color: Color(0xFF708078), height: 1.45)),
                              const SizedBox(height: 16),
                              _fieldLabel('Nama lengkap'),
                              TextFormField(controller: _name, textCapitalization: TextCapitalization.words, decoration: _decoration('Masukkan nama lengkap', Icons.person_outline), validator: (v) => (v?.trim().isEmpty ?? true) ? 'Nama lengkap wajib diisi' : null),
                              const SizedBox(height: 13),
                              _fieldLabel('Email'),
                              TextFormField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: _decoration('nama@email.com', Icons.mail_outline), validator: (v) { final email = v?.trim() ?? ''; return email.contains('@') && email.contains('.') ? null : 'Masukkan alamat email yang valid'; }),
                              const SizedBox(height: 13),
                              _fieldLabel('Kata sandi'),
                              TextFormField(controller: _password, obscureText: _obscurePassword, decoration: _decoration('Buat kata sandi', Icons.lock_outline).copyWith(suffixIcon: IconButton(onPressed: () => setState(() => _obscurePassword = !_obscurePassword), icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined))), validator: (v) => (v?.length ?? 0) < 8 ? 'Kata sandi minimal 8 karakter' : null),
                              const SizedBox(height: 5),
                              const Text('Minimal 8 karakter, gunakan huruf dan angka.', style: TextStyle(color: Color(0xFF708078), fontSize: 10)),
                              const SizedBox(height: 13),
                              _fieldLabel('Konfirmasi kata sandi'),
                              TextFormField(controller: _confirmPassword, obscureText: _obscureConfirmation, decoration: _decoration('Ulangi kata sandi', Icons.lock_outline).copyWith(suffixIcon: IconButton(onPressed: () => setState(() => _obscureConfirmation = !_obscureConfirmation), icon: Icon(_obscureConfirmation ? Icons.visibility_off_outlined : Icons.visibility_outlined))), validator: (v) => v != _password.text ? 'Konfirmasi kata sandi belum cocok' : null),
                              const SizedBox(height: 9),
                              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                SizedBox(width: 28, height: 28, child: Checkbox(value: _acceptedTerms, activeColor: const Color(0xFF176126), onChanged: (v) => setState(() => _acceptedTerms = v ?? false), visualDensity: VisualDensity.compact)),
                                const SizedBox(width: 4),
                                const Expanded(child: Padding(padding: EdgeInsets.only(top: 5), child: Text('Saya menyetujui Syarat & Ketentuan serta Kebijakan Privasi Pasar Splendid.', style: TextStyle(color: Color(0xFF708078), fontSize: 11, height: 1.4)))),
                              ]),
                              const SizedBox(height: 10),
                              SizedBox(width: double.infinity, height: 48, child: FilledButton(onPressed: _register, style: FilledButton.styleFrom(backgroundColor: const Color(0xFF176126), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Daftar sekarang', style: TextStyle(fontWeight: FontWeight.w700)), SizedBox(width: 10), Icon(Icons.arrow_forward)]))),
                              const SizedBox(height: 12),
                              Center(child: Wrap(alignment: WrapAlignment.center, children: [const Text('Sudah punya akun? ', style: TextStyle(color: Color(0xFF708078), fontSize: 12)), GestureDetector(onTap: () => Navigator.of(context).pop(), child: const Text('Masuk di sini', style: TextStyle(color: Color(0xFF176126), fontWeight: FontWeight.w700, fontSize: 12)))])),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Divider(height: 1, color: Color(0xFFE1E7E2))),
                              const Row(children: [Icon(Icons.verified_user_outlined, color: Color(0xFF176126), size: 21), SizedBox(width: 8), Expanded(child: Text('Data Anda aman. Bersama membangun pasar yang lebih terhubung.', style: TextStyle(color: Color(0xFF708078), fontSize: 10, height: 1.4)))]),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 14),
                  const Text('© 2026 Pasar Splendid Malang', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF708078), fontSize: 10)),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _brand() => Row(children: [
        Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFF176126), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.spa_outlined, color: Colors.white, size: 24)),
        const SizedBox(width: 10),
        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Pasar Splendid', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF1C2A40), fontSize: 18)), Text('MALANG • SEJAK 1960', style: TextStyle(color: Color(0xFF708078), fontSize: 9, letterSpacing: .3))]),
      ]);

  Widget _registerHero() => SizedBox(height: 180, width: double.infinity, child: Stack(fit: StackFit.expand, children: [
        Image.asset('assets/images/market_hero.png', fit: BoxFit.cover),
        Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black.withValues(alpha: .1), const Color(0xFF102719).withValues(alpha: .88)]))),
        Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8), decoration: BoxDecoration(color: Colors.white.withValues(alpha: .92), borderRadius: BorderRadius.circular(20)), child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.location_on_outlined, color: Color(0xFF176126), size: 15), SizedBox(width: 5), Text('MALANG, JAWA TIMUR', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700))])),
          const Spacer(),
          const Text('Tumbuh bersama Splendid.', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          const Text('Temukan inspirasi, temui pedagang lokal, dan jadi bagian dari komunitas kami.', style: TextStyle(color: Color(0xFFE5E7EB), fontSize: 12, height: 1.4)),
        ])),
      ]));

  Widget _fieldLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 7), child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)));

  InputDecoration _decoration(String hint, IconData icon) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF708078), fontSize: 13),
        prefixIcon: Icon(icon, size: 19, color: const Color(0xFF708078)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: const BorderSide(color: Color(0xFFDDE4E0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: const BorderSide(color: Color(0xFFDDE4E0))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: const BorderSide(color: Color(0xFF176126), width: 1.5)),
      );
}
