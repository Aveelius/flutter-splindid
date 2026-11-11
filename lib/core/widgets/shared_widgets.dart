import 'package:flutter/material.dart';

const forest = Color(0xFF185D25);
const deepForest = Color(0xFF14551F);
const canvas = Color(0xFFF1F3F6);
const ink = Color(0xFF202923);
const muted = Color(0xFF707B74);

class StatusStrip extends StatelessWidget {
  const StatusStrip({super.key});
  @override
  Widget build(BuildContext context) => Container(
        height: 32, color: deepForest,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Row(children: [
          Text('9:41', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
          Spacer(), Icon(Icons.signal_cellular_alt, size: 15, color: Colors.white), SizedBox(width: 5),
          Icon(Icons.wifi, size: 15, color: Colors.white), SizedBox(width: 5),
          Icon(Icons.battery_full, size: 19, color: Colors.white),
        ]),
      );
}

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.onSearch, required this.onNotifications, this.dashboard = false});
  final VoidCallback onSearch;
  final VoidCallback onNotifications;
  final bool dashboard;
  @override
  Widget build(BuildContext context) => Container(
        height: 64, color: forest, padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          if (dashboard) ...[
            Container(width: 34, height: 34, decoration: BoxDecoration(color: Colors.white.withValues(alpha: .16), borderRadius: BorderRadius.circular(9)),
                child: const Icon(Icons.spa_outlined, color: Colors.white, size: 23)),
            const SizedBox(width: 10),
          ],
          Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Pasar Splendid', style: TextStyle(color: Colors.white, fontSize: dashboard ? 20 : 18, fontWeight: FontWeight.w700, height: 1.1)),
            const SizedBox(height: 2), const Text('Kota Malang', style: TextStyle(color: Color(0xFFC7DCC9), fontSize: 11)),
          ])),
          HeaderAction(icon: Icons.search, onTap: onSearch), const SizedBox(width: 8),
          HeaderAction(icon: Icons.notifications_none, onTap: onNotifications),
        ]),
      );
}

class HeaderAction extends StatelessWidget {
  const HeaderAction({super.key, required this.icon, required this.onTap});
  final IconData icon; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap, borderRadius: BorderRadius.circular(30),
        child: Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.white.withValues(alpha: .14), shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 22)),
      );
}

void openPage(BuildContext context, Widget page) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));

class PageBody extends StatelessWidget {
  const PageBody({super.key, required this.children, this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 20), this.background = const Color(0xFFDADADA)});
  final List<Widget> children; final EdgeInsets padding; final Color background;
  @override
  Widget build(BuildContext context) => Container(color: background, child: ListView(padding: padding, children: children));
}

class PageIntro extends StatelessWidget {
  const PageIntro({super.key, required this.title, required this.description});
  final String title, description;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: ink)),
          Container(width: 40, height: 3, margin: const EdgeInsets.only(top: 5, bottom: 7), decoration: BoxDecoration(color: forest, borderRadius: BorderRadius.circular(5))),
          Text(description, style: const TextStyle(color: muted, fontSize: 11.5, height: 1.35)),
        ]),
      );
}

class Avatar extends StatelessWidget {
  const Avatar({super.key, this.size = 36}); final double size;
  @override
  Widget build(BuildContext context) => ClipOval(child: Image.asset('assets/images/profile.png', width: size, height: size, fit: BoxFit.cover, errorBuilder: (_, _, _) => Container(width: size, height: size, color: const Color(0xFFE1ECE2), child: Icon(Icons.person, color: forest, size: size * .62))));
}

class NoticeRow extends StatelessWidget { const NoticeRow({super.key, required this.icon, required this.title, required this.detail}); final IconData icon; final String title, detail; @override Widget build(BuildContext context) => ListTile(leading: CircleAvatar(backgroundColor: const Color(0xFFEAF3EB), child: Icon(icon, color: forest)), title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)), subtitle: Text(detail, style: const TextStyle(fontSize: 11))); }

class SubPage extends StatelessWidget { const SubPage({super.key, required this.title, required this.child}); final String title; final Widget child;
  @override Widget build(BuildContext context) => Scaffold(backgroundColor: canvas, appBar: AppBar(title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)), backgroundColor: forest, foregroundColor: Colors.white, leading: IconButton(onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back))), body: SafeArea(top: false, child: child)); }

void showInfo(BuildContext context, String title, String detail) => showDialog<void>(context: context, builder: (ctx) => AlertDialog(title: Text(title), content: Text(detail), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup'))]));

void sharePost(BuildContext context) => showModalBottomSheet<void>(context: context, builder: (ctx) => SafeArea(child: Wrap(children: [const ListTile(title: Text('Bagikan postingan', style: TextStyle(fontWeight: FontWeight.w700))), ListTile(leading: const Icon(Icons.link), title: const Text('Salin tautan'), onTap: () { Navigator.pop(ctx); showInfo(context, 'Tautan disalin', 'Tautan postingan siap dibagikan.'); }), ListTile(leading: const Icon(Icons.send), title: const Text('Kirim ke teman'), onTap: () { Navigator.pop(ctx); showInfo(context, 'Kirim ke teman', 'Pilih teman untuk berbagi postingan.'); })])));

void showPostMenu(BuildContext context) => showModalBottomSheet<void>(context: context, builder: (ctx) => SafeArea(child: Wrap(children: [ListTile(leading: const Icon(Icons.bookmark_border), title: const Text('Simpan postingan'), onTap: () { Navigator.pop(ctx); showInfo(context, 'Tersimpan', 'Postingan disimpan ke koleksimu.'); }), ListTile(leading: const Icon(Icons.flag_outlined), title: const Text('Laporkan'), onTap: () { Navigator.pop(ctx); showInfo(context, 'Laporan dikirim', 'Terima kasih telah menjaga komunitas.'); })])));

Future<String?> showMapFilters(BuildContext context) => showModalBottomSheet<String>(context: context, builder: (ctx) => SafeArea(child: Padding(padding: const EdgeInsets.all(18), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Filter peta', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)), const SizedBox(height: 10), ...['Semua sektor', 'Stan buka sekarang', 'Tampilkan jalur utama'].map((s) => ListTile(leading: const Icon(Icons.check_circle_outline, color: forest), title: Text(s, style: const TextStyle(fontSize: 13)), onTap: () => Navigator.pop(ctx, s)))]))));

class DemoAccount {
  static String name = 'Aulia Putri';
  static String email = 'demo@pasarsplendid.id';
  static String password = 'splendid123';
}
