import 'package:flutter/material.dart';
import 'package:pasar_splindid_app/core/widgets/shared_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool communityAlerts = true, promotions = false;
  @override
  Widget build(BuildContext context) => PageBody(children: [
        const PageIntro(title: 'Pengaturan', description: 'Kelola profil, keamanan, dan preferensi akunmu.'),
        Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Container(width: 64, height: 64, decoration: const BoxDecoration(color: Color(0xFFE6EEE6), shape: BoxShape.circle), child: const Icon(Icons.person, color: forest, size: 40)), const SizedBox(width: 12), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Andi Saputra', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)), SizedBox(height: 4), Text('andi.saputra@email.com', style: TextStyle(fontSize: 10, color: muted)), SizedBox(height: 5), BadgeTag('★ Anggota Senior')]))]),
          const SizedBox(height: 14), const Text('Bergabung sejak Januari 2024 • Kota Malang', style: TextStyle(fontSize: 10, color: muted)), const SizedBox(height: 12),
          Row(children: [Expanded(child: SizedBox(height: 37, child: FilledButton.icon(onPressed: () => openPage(context, const EditProfilePage()), icon: const Icon(Icons.edit, size: 15), label: const Text('Edit Profil', style: TextStyle(fontSize: 10)), style: FilledButton.styleFrom(backgroundColor: const Color(0xFFE8F3E9), foregroundColor: forest)))), const SizedBox(width: 8), Expanded(child: SizedBox(height: 37, child: FilledButton.icon(onPressed: () => openPage(context, const OrdersPage()), icon: const Icon(Icons.shopping_bag_outlined, size: 15), label: const Text('Pesanan Saya', style: TextStyle(fontSize: 10)), style: FilledButton.styleFrom(backgroundColor: forest))))]),
        ])),
        const SizedBox(height: 19), const Text('Akun & preferensi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)), const SizedBox(height: 9),
        Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13)), child: Column(children: [
          SettingsRow(icon: Icons.verified_user_outlined, title: 'Akun & Keamanan', subtitle: 'Kata sandi, nomor telepon, dan privasi', onTap: () => openPage(context, const UtilityPage(title: 'Akun & Keamanan', detail: 'Atur keamanan akun dan privasimu.'))),
          SettingsRow(icon: Icons.notifications_none, title: 'Notifikasi', subtitle: 'Atur kabar yang ingin kamu terima', onTap: () => openPage(context, const NotificationSettingsPage())),
          SwitchRow(title: 'Aktivitas komunitas', subtitle: 'Balasan, suka, dan kabar dari grup', value: communityAlerts, onChanged: (v) => setState(() => communityAlerts = v)),
          SwitchRow(title: 'Promo & penawaran', subtitle: 'Info produk dan promo dari pedagang', value: promotions, onChanged: (v) => setState(() => promotions = v)),
          SettingsRow(icon: Icons.credit_card_outlined, title: 'Metode Pembayaran', subtitle: 'Kelola rekening, kartu, dan dompet digital', onTap: () => openPage(context, const UtilityPage(title: 'Metode Pembayaran', detail: 'Belum ada metode pembayaran tersimpan.'))),
          SettingsRow(icon: Icons.help_outline, title: 'Pusat Bantuan', subtitle: 'Pertanyaan umum dan bantuan pelanggan', onTap: () => openPage(context, const UtilityPage(title: 'Pusat Bantuan', detail: 'Hubungi tim Pasar Splendid untuk mendapatkan bantuan.'))),
          SettingsRow(icon: Icons.info_outline, title: 'Tentang Pasar Splendid', subtitle: 'Versi 1.0.0', onTap: () => openPage(context, const UtilityPage(title: 'Tentang Pasar Splendid', detail: 'Pasar flora dan fauna kebanggaan Kota Malang.'))),
        ])),
        const SizedBox(height: 18),
        Container(padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: const Color(0xFFE8F3E9), borderRadius: BorderRadius.circular(13)), child: const Row(children: [Icon(Icons.eco_outlined, color: forest, size: 23), SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Bersama menjaga Pasar Splendid', style: TextStyle(color: forest, fontSize: 11, fontWeight: FontWeight.w800)), SizedBox(height: 4), Text('Belanja bijak, rawat hewan, dan dukung pedagang lokal.', style: TextStyle(color: muted, fontSize: 9))]))])),
        const SizedBox(height: 18), SizedBox(width: double.infinity, height: 42, child: FilledButton.icon(onPressed: () => showInfo(context, 'Keluar akun', 'Kamu berhasil keluar dari akun.'), icon: const Icon(Icons.logout, size: 17), label: const Text('Keluar Akun', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11)), style: FilledButton.styleFrom(backgroundColor: const Color(0xFFB91F24)))),
        const Padding(padding: EdgeInsets.only(top: 14), child: Center(child: Text('Pasar Splendid • Versi 1.0.0', style: TextStyle(color: muted, fontSize: 9)))),
      ]);
}

class BadgeTag extends StatelessWidget { const BadgeTag(this.text, {super.key}); final String text; @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFFFF0DF), borderRadius: BorderRadius.circular(5)), child: Text(text, style: const TextStyle(fontSize: 9, color: Color(0xFFD45211), fontWeight: FontWeight.w700))); }

class SettingsRow extends StatelessWidget {
  const SettingsRow({super.key, required this.icon, required this.title, required this.subtitle, required this.onTap}); final IconData icon; final String title, subtitle; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11), decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE6EAE7)))), child: Row(children: [Container(width: 32, height: 32, decoration: BoxDecoration(color: const Color(0xFFEAF3EB), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: forest, size: 18)), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text(subtitle, style: const TextStyle(fontSize: 9, color: muted))])), const Icon(Icons.chevron_right, color: Color(0xFF59665E), size: 20)])));
}

class SwitchRow extends StatelessWidget {
  const SwitchRow({super.key, required this.title, required this.subtitle, required this.value, required this.onChanged}); final String title, subtitle; final bool value; final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.fromLTRB(13, 6, 10, 6), child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)), const SizedBox(height: 3), Text(subtitle, style: const TextStyle(fontSize: 9, color: muted))])), Switch(value: value, onChanged: onChanged, activeTrackColor: forest, activeThumbColor: Colors.white, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)]));
}

class EditProfilePage extends StatefulWidget { const EditProfilePage({super.key}); @override State<EditProfilePage> createState() => _EditProfilePageState(); }

class _EditProfilePageState extends State<EditProfilePage> { final name = TextEditingController(text: 'Andi Saputra'); final city = TextEditingController(text: 'Kota Malang'); @override void dispose() { name.dispose(); city.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => SubPage(title: 'Edit Profil', child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [const Avatar(size: 80), const SizedBox(height: 18), TextField(controller: name, decoration: const InputDecoration(labelText: 'Nama lengkap', filled: true, fillColor: Colors.white)), const SizedBox(height: 12), TextField(decoration: const InputDecoration(labelText: 'Email', hintText: 'andi.saputra@email.com', filled: true, fillColor: Colors.white)), const SizedBox(height: 12), TextField(controller: city, decoration: const InputDecoration(labelText: 'Kota', filled: true, fillColor: Colors.white)), const SizedBox(height: 20), SizedBox(width: double.infinity, child: FilledButton(onPressed: () { final navigator = Navigator.of(context); navigator.pop(); showInfo(navigator.context, 'Profil tersimpan', 'Perubahan profil berhasil disimpan.'); }, style: FilledButton.styleFrom(backgroundColor: forest), child: const Text('Simpan perubahan')))]))); }

class OrdersPage extends StatelessWidget { const OrdersPage({super.key}); @override Widget build(BuildContext context) => const SubPage(title: 'Pesanan Saya', child: Padding(padding: EdgeInsets.all(16), child: Column(children: [NoticeRow(icon: Icons.shopping_bag_outlined, title: 'Belum ada pesanan', detail: 'Pesanan dari pedagang akan muncul di sini.')]))); }

class NotificationSettingsPage extends StatefulWidget { const NotificationSettingsPage({super.key}); @override State<NotificationSettingsPage> createState() => _NotificationSettingsPageState(); }

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  final values = [true, true, false];
  @override Widget build(BuildContext context) => SubPage(
        title: 'Preferensi Notifikasi',
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: ['Aktivitas komunitas', 'Pesanan dan stan', 'Promo & penawaran'].asMap().entries.map((e) => SwitchListTile(
                title: Text(e.value, style: const TextStyle(fontSize: 13)),
                value: values[e.key],
                activeTrackColor: forest,
                onChanged: (v) => setState(() => values[e.key] = v),
              )).toList()),
        ),
      );
}

class UtilityPage extends StatelessWidget { const UtilityPage({super.key, required this.title, required this.detail}); final String title, detail; @override Widget build(BuildContext context) => SubPage(title: title, child: Padding(padding: const EdgeInsets.all(18), child: Column(children: [const SizedBox(height: 30), const Icon(Icons.spa_outlined, color: forest, size: 48), const SizedBox(height: 12), Text(detail, textAlign: TextAlign.center, style: const TextStyle(color: muted, height: 1.5)), const SizedBox(height: 18), if (title == 'Akun & Keamanan') const NoticeRow(icon: Icons.lock_outline, title: 'Kata sandi', detail: 'Terakhir diperbarui baru-baru ini')] ))); }
