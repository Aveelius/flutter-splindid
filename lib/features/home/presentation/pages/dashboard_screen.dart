import 'package:flutter/material.dart';
import 'package:pasar_splindid_app/core/widgets/shared_widgets.dart';
import 'package:pasar_splindid_app/features/market/presentation/pages/market_screen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) => PageBody(padding: const EdgeInsets.fromLTRB(16, 12, 16, 22), background: canvas, children: [
        ClipRRect(borderRadius: BorderRadius.circular(16), child: Stack(alignment: Alignment.centerLeft, children: [
          Image.asset('assets/images/market_hero.png', width: double.infinity, height: 150, fit: BoxFit.cover),
          Container(height: 150, color: Colors.black.withValues(alpha: .49)),
          Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5), decoration: BoxDecoration(color: Colors.black.withValues(alpha: .36), borderRadius: BorderRadius.circular(15)),
                child: const Text('PASAR FLORA DAN FAUNA MALANG', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w700))),
            const SizedBox(height: 9), const Text('Pasar Splendid Malang', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22)),
            const SizedBox(height: 4), const Text('Temukan flora, fauna, dan cerita baru\ndi jantung Kota Malang.', style: TextStyle(color: Color(0xFFEAF1E9), fontSize: 12, height: 1.4)),
          ])),
        ])),
        const SizedBox(height: 12),
        Row(children: const [
          Expanded(child: StatCard(icon: Icons.access_time, label: 'Jam Operasional', value: '07:00-17:00')),
          SizedBox(width: 10), Expanded(child: StatCard(icon: Icons.people_alt_outlined, label: 'Pengunjung', value: '1,250+')),
        ]), const SizedBox(height: 10),
        Row(children: const [
          Expanded(child: StatCard(icon: Icons.grid_view_rounded, label: 'Kategori', value: '4 Sektor')),
          SizedBox(width: 10), Expanded(child: StatCard(icon: Icons.forum_outlined, label: 'Komunitas', value: '340 Active')),
        ]),
        const SizedBox(height: 18),
        Row(children: [Container(width: 3, height: 18, decoration: BoxDecoration(color: forest, borderRadius: BorderRadius.circular(3))), const SizedBox(width: 8), const Expanded(child: Text('Sektor Utama Pasar Splendid', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800))),
          IconButton(tooltip: 'Lihat semua sektor', onPressed: () => openPage(context, const MarketPage()), icon: const Icon(Icons.arrow_forward, color: forest, size: 18), visualDensity: VisualDensity.compact)]),
        const SizedBox(height: 3),
        GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: .98,
          children: const [
            SectorTile(title: 'Burung', tag: 'Kicau & unggas', description: 'Ragam burung kicau dan perlengkapannya.', image: 'assets/images/birds.png', category: 'Burung'),
            SectorTile(title: 'Ikan Hias', tag: 'Akuatik', description: 'Ikan warna-warni untuk akuarium impianmu.', image: 'assets/images/koi.png', category: 'Ikan Hias'),
            SectorTile(title: 'Bunga & Tanaman', tag: 'Botani', description: 'Segarkan rumah dengan bunga dan tanaman.', image: 'assets/images/flowers.png', category: 'Bunga'),
            SectorTile(title: 'Hewan Peliharaan', tag: 'Sahabat rumah', description: 'Temukan sahabat kecil dan kebutuhan hariannya.', image: 'assets/images/rabbit.png', category: 'Hewan'),
          ]),
      ]);
}

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.icon, required this.label, required this.value});
  final IconData icon; final String label, value;
  @override
  Widget build(BuildContext context) => Container(height: 65, padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [Container(width: 31, height: 31, decoration: BoxDecoration(color: const Color(0xFFEAF3EB), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: forest, size: 19)),
        const SizedBox(width: 8), Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 9, color: muted)), const SizedBox(height: 3), FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800))) ]))]));
}

class SectorTile extends StatelessWidget {
  const SectorTile({super.key, required this.title, required this.tag, required this.description, required this.image, required this.category});
  final String title, tag, description, image, category;
  @override
  Widget build(BuildContext context) => InkWell(onTap: () => openPage(context, SectorPage(category: category)), borderRadius: BorderRadius.circular(16),
    child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Container(color: Colors.white, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 73, width: double.infinity, child: Stack(fit: StackFit.expand, children: [Image.asset(image, fit: BoxFit.cover), Positioned(left: 8, top: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Text(tag, style: const TextStyle(fontSize: 8, color: forest, fontWeight: FontWeight.w700))))])),
      Padding(padding: const EdgeInsets.fromLTRB(10, 8, 9, 7), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)), const SizedBox(height: 4), Text(description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: muted, height: 1.2, fontSize: 10))])),
    ]))));
}
