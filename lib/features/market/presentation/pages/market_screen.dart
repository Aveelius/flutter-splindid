import 'package:flutter/material.dart';
import 'package:pasar_splindid_app/core/widgets/shared_widgets.dart';
import 'package:pasar_splindid_app/features/market/presentation/pages/route_guide_screen.dart';

const categories = ['Semua', 'Burung', 'Ikan Hias', 'Bunga', 'Hewan', 'Perlengkapan'];

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});
  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  String filter = 'Semua';
  @override
  Widget build(BuildContext context) {
    final all = [
      const MarketCard(category: 'Burung', title: 'Pasar Burung', count: '32 stan', zone: 'Zona A', image: 'assets/images/market_bird.png', detail: 'Koleksi burung berkicau, sangkar unik, pakan & perlengkapan hobi terlengkap.', product1: 'Kenari · Rp150.000', product2: 'Sangkar · Rp85.000'),
      const MarketCard(category: 'Ikan Hias', title: 'Pasar Ikan Hias', count: '28 stan', zone: 'Zona B', image: 'assets/images/koi.png', detail: 'Aneka ikan hias air tawar, akuarium kustom, tanaman aquascape & filter.', product1: 'Guppy · Rp15.000', product2: 'Cupang · Rp35.000'),
      const MarketCard(category: 'Bunga', title: 'Pasar Bunga & Tanaman', count: '24 stan', zone: 'Zona C', image: 'assets/images/flowers.png', detail: 'Anggrek, tanaman hias, pot estetik, pupuk, dan media tanam untuk dekorasi rumah.', product1: 'Anggrek · Rp65.000', product2: 'Monstera · Rp45.000'),
      const MarketCard(category: 'Hewan', title: 'Pasar Hewan Peliharaan', count: '18 stan', zone: 'Zona D', image: 'assets/images/hamster.png', detail: 'Kelinci, kucing, hamster & marmut sehat dengan pakan serta kandang ramah hewan.', product1: 'Hamster · Rp50.000', product2: 'Kelinci · Rp120.000'),
    ];
    final visible = filter == 'Semua' || filter == 'Perlengkapan' ? all : all.where((c) => c.category == filter).toList();
    return PageBody(children: [
      const PageIntro(title: 'Jelajahi Pasar Splendid', description: 'Temukan flora, fauna, dan perlengkapan favorit dari pedagang lokal Malang.'),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: categories.map((cat) => Padding(padding: const EdgeInsets.only(right: 4), child: ChoiceChip(label: Text(cat, style: TextStyle(fontSize: 9, color: filter == cat ? Colors.white : const Color(0xFF435148))), selected: filter == cat, onSelected: (_) => setState(() => filter = cat), selectedColor: forest, backgroundColor: Colors.white, showCheckmark: false, side: BorderSide.none, visualDensity: VisualDensity.compact, padding: const EdgeInsets.symmetric(horizontal: 3)))).toList())),
      const SizedBox(height: 14), Row(children: [Expanded(child: Text('${visible.length} sektor utama', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))), const SizedBox(width: 8), const Flexible(child: Align(alignment: Alignment.centerRight, child: FittedBox(fit: BoxFit.scaleDown, child: Text('Buka hari ini • 07.00–17.00', style: TextStyle(fontSize: 10, color: forest)))))]),
      const SizedBox(height: 12), ...visible.map((card) => Padding(padding: const EdgeInsets.only(bottom: 16), child: card)),
      const Text('Harga dapat berubah. Konfirmasi ketersediaan langsung dengan pemilik stan sebelum berkunjung.', style: TextStyle(color: muted, fontSize: 9, height: 1.4)),
    ]);
  }
}

class MarketCard extends StatelessWidget {
  const MarketCard({super.key, required this.category, required this.title, required this.count, required this.zone, required this.image, required this.detail, required this.product1, required this.product2});
  final String category, title, count, zone, image, detail, product1, product2;
  @override
  Widget build(BuildContext context) => InkWell(onTap: () => openPage(context, SectorPage(category: category)), borderRadius: BorderRadius.circular(14),
    child: ClipRRect(borderRadius: BorderRadius.circular(14), child: Container(color: Colors.white, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image.asset(image, width: double.infinity, height: 143, fit: BoxFit.cover),
      Padding(padding: const EdgeInsets.fromLTRB(13, 12, 13, 13), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFFFEAEC), borderRadius: BorderRadius.circular(5)), child: Text(category.toUpperCase(), style: const TextStyle(color: Color(0xFFBD2932), fontSize: 8, fontWeight: FontWeight.w700))), const Spacer(), Text('$count • $zone', style: const TextStyle(color: muted, fontSize: 10))]),
        const SizedBox(height: 9), Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)), const SizedBox(height: 7), Text(detail, style: const TextStyle(color: muted, height: 1.35, fontSize: 11)),
        const SizedBox(height: 8), const Text('Produk unggulan • mulai dari', style: TextStyle(fontSize: 10, color: Color(0xFF46544A))), const SizedBox(height: 5),
        Wrap(spacing: 5, children: [PriceTag(product1), PriceTag(product2)]), const SizedBox(height: 9),
        SizedBox(width: double.infinity, height: 37, child: FilledButton.icon(onPressed: () => openPage(context, StallDirectoryPage(category: category)), icon: const Icon(Icons.arrow_forward, size: 16), label: const Text('Lihat Semua Stan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)), style: FilledButton.styleFrom(backgroundColor: forest))),
      ])),
    ]))));
}

class PriceTag extends StatelessWidget {
  const PriceTag(this.text, {super.key}); final String text;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFFFEEF0), borderRadius: BorderRadius.circular(5)), child: Text(text, style: const TextStyle(color: Color(0xFFB12831), fontSize: 9)));
}

class SectorPage extends StatelessWidget { const SectorPage({super.key, required this.category}); final String category;
  @override Widget build(BuildContext context) { final data = sectorData(category); return SubPage(title: 'Pasar $category', child: ListView(padding: const EdgeInsets.all(16), children: [ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset(data.$1, height: 190, fit: BoxFit.cover)), const SizedBox(height: 12), Text('Sektor $category', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)), const SizedBox(height: 6), Text(data.$2, style: const TextStyle(color: muted, height: 1.4)), const SizedBox(height: 18), Row(children: [const Icon(Icons.storefront_outlined, color: forest, size: 18), const SizedBox(width: 7), const Text('Stan populer', style: TextStyle(fontWeight: FontWeight.w800)), const Spacer(), const Text('07.00–17.00', style: TextStyle(color: forest, fontSize: 10))]), const SizedBox(height: 8), ...List.generate(5, (i) => StallResult(stall: '${data.$3} • Stan ${i + 1}', onTap: () => openPage(context, StallDetailPage(stall: '${data.$3} • Stan ${i + 1}')))), const SizedBox(height: 8), FilledButton.icon(onPressed: () => openPage(context, StallDirectoryPage(category: category)), icon: const Icon(Icons.arrow_forward), label: const Text('Lihat semua stan'), style: FilledButton.styleFrom(backgroundColor: forest))])); }
}

(String, String, String) sectorData(String category) { switch (category) { case 'Burung': return ('assets/images/market_bird.png', 'Ragam burung berkicau, sangkar unik, pakan, dan perlengkapan hobi dari pedagang lokal.', 'Zona A'); case 'Ikan Hias': return ('assets/images/koi.png', 'Ikan warna-warni, perlengkapan akuarium, dan tanaman untuk aquascape.', 'Zona B'); case 'Bunga': return ('assets/images/flowers.png', 'Bunga segar dan tanaman hias untuk mempercantik rumah dan taman.', 'Zona C'); default: return ('assets/images/hamster.png', 'Temukan hewan peliharaan dan kebutuhan perawatan hariannya.', 'Zona D'); } }

class StallDirectoryPage extends StatelessWidget { const StallDirectoryPage({super.key, required this.category}); final String category;
  @override Widget build(BuildContext context) => SubPage(title: 'Stan $category', child: ListView(padding: const EdgeInsets.all(16), children: [Text('Pilih stan di sektor $category', style: const TextStyle(color: muted)), const SizedBox(height: 10), ...List.generate(12, (i) => StallResult(stall: '${sectorData(category).$3} - ${i + 1}', onTap: () => openPage(context, StallDetailPage(stall: '${sectorData(category).$3} - ${i + 1}'))))])); }

class StallResult extends StatelessWidget { const StallResult({super.key, required this.stall, required this.onTap}); final String stall; final VoidCallback onTap;
  @override Widget build(BuildContext context) => Card(color: Colors.white, elevation: 0, child: ListTile(onTap: onTap, leading: const CircleAvatar(backgroundColor: Color(0xFFEAF3EB), child: Icon(Icons.storefront, color: forest)), title: Text(stall, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)), subtitle: const Text('Buka hari ini • 07.00–17.00', style: TextStyle(fontSize: 10)), trailing: const Icon(Icons.chevron_right))); }

class StallDetailPage extends StatelessWidget { const StallDetailPage({super.key, required this.stall}); final String stall;
  @override Widget build(BuildContext context) => SubPage(title: stall, child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.storefront, color: forest, size: 48), const SizedBox(height: 12), Text(stall, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)), const SizedBox(height: 7), const Text('Pedagang lokal Pasar Splendid Malang. Kunjungi stan untuk melihat pilihan produk dan bertanya langsung.', style: TextStyle(color: muted, height: 1.4)), const SizedBox(height: 16), const NoticeRow(icon: Icons.access_time, title: 'Buka hari ini', detail: '07.00–17.00'), const NoticeRow(icon: Icons.location_on_outlined, title: 'Pasar Splendid', detail: 'Jalan Brawijaya, Kota Malang'), const Spacer(), SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: () => openPage(context, RouteGuidePage(stall: stall)), icon: const Icon(Icons.directions), label: const Text('Lihat rute di peta'), style: FilledButton.styleFrom(backgroundColor: forest)))]))); }
