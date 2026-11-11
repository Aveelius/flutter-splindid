import 'package:flutter/material.dart';
import 'package:pasar_splindid_app/core/widgets/shared_widgets.dart';
import 'package:pasar_splindid_app/features/market/presentation/pages/market_screen.dart';
import 'package:pasar_splindid_app/features/market/presentation/pages/route_guide_screen.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final search = TextEditingController(); String selected = 'B-12'; String mapFilter = 'Semua sektor';
  @override
  void dispose() { search.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => PageBody(padding: const EdgeInsets.fromLTRB(16, 8, 16, 16), children: [
        const PageIntro(title: 'Peta Pasar Splendid', description: 'Cari stan dan temukan jalan ke sektor favoritmu.'),
        Container(height: 42, padding: const EdgeInsets.symmetric(horizontal: 11), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)), child: Row(children: [const Icon(Icons.search, color: muted, size: 20), const SizedBox(width: 7), Expanded(child: TextField(controller: search, onChanged: (value) => setState(() { selected = value.trim().isEmpty ? 'B-12' : ''; }), decoration: const InputDecoration(border: InputBorder.none, hintText: 'Cari nama stan atau sektor...', hintStyle: TextStyle(fontSize: 11)))), IconButton(onPressed: () async { final value = await showMapFilters(context); if (value != null) setState(() => mapFilter = value); }, icon: const Icon(Icons.tune, color: forest, size: 19))])),
        if (mapFilter != 'Semua sektor') Padding(padding: const EdgeInsets.only(top: 6), child: Align(alignment: Alignment.centerLeft, child: Chip(label: Text(mapFilter, style: const TextStyle(fontSize: 9, color: forest)), backgroundColor: const Color(0xFFE8F3E9), side: BorderSide.none, visualDensity: VisualDensity.compact))),
        const SizedBox(height: 16),
        Container(padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: const Color(0xFFF2F3E9), borderRadius: BorderRadius.circular(15)), child: Column(children: [
          Row(children: [const Text('JL. BRAWIJAYA', style: TextStyle(fontSize: 8, color: muted, fontWeight: FontWeight.w700)), const Spacer(), IconButton(onPressed: () => showInfo(context, 'Pintu utara', 'Jalan Brawijaya berada di sisi utara peta.'), icon: const Icon(Icons.navigation_outlined, color: forest, size: 20), visualDensity: VisualDensity.compact)]),
          Row(children: [Expanded(child: MapZone(letter: 'A', title: 'Burung', color: const Color(0xFFCC1923), selectedStall: selected, onTap: (stall) => setState(() => selected = 'A-$stall'))), const SizedBox(width: 18), Expanded(child: MapZone(letter: 'B', title: 'Ikan Hias', color: forest, selectedStall: selected, stallNumbers: const ['1', '12', '3', '4', '5', '6'], onTap: (stall) => setState(() => selected = 'B-$stall')))]),
          const Padding(padding: EdgeInsets.symmetric(vertical: 19), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.north_east, size: 15, color: forest), SizedBox(width: 7), Text('Jalur utama • 85 m ke B-12', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: forest))])),
          Row(children: [Expanded(child: MapZone(letter: 'C', title: 'Bunga', color: const Color(0xFFEF5A00), selectedStall: selected, onTap: (stall) => setState(() => selected = 'C-$stall'))), const SizedBox(width: 18), Expanded(child: MapZone(letter: 'D', title: 'Hewan', color: const Color(0xFF1454B5), selectedStall: selected, onTap: (stall) => setState(() => selected = 'D-$stall')))]),
          const SizedBox(height: 12), Row(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 18, height: 18, decoration: BoxDecoration(color: const Color(0xFFE4ECF9), border: Border.all(color: const Color(0xFF1454B5), width: 3), shape: BoxShape.circle)), const SizedBox(width: 8), Text(selected.isEmpty ? 'Anda di sini • Pintu masuk utama' : 'Stan $selected dipilih', style: const TextStyle(fontSize: 10, color: muted, fontWeight: FontWeight.w600))]),
          const SizedBox(height: 12), Row(children: [const Text('20 m', style: TextStyle(fontSize: 8, color: muted)), const Spacer(), FilledButton.icon(onPressed: () => showInfo(context, 'Lokasi Anda', 'Lokasi Anda berada di dekat pintu masuk utama.'), icon: const Icon(Icons.my_location, size: 15), label: const Text('Lokasi Saya', style: TextStyle(fontSize: 10)), style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: forest, elevation: 1))]),
        ])),
        const SizedBox(height: 12), Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: const [MapLegend(color: Color(0xFFCC1923), label: 'Burung'), MapLegend(color: forest, label: 'Ikan Hias'), MapLegend(color: Color(0xFFEF5A00), label: 'Bunga'), MapLegend(color: Color(0xFF1454B5), label: 'Hewan')]),
        const SizedBox(height: 14), if (selected.isNotEmpty || search.text.isNotEmpty) MapSelectedCard(stall: selected.isEmpty ? 'Hasil pencarian' : selected, onOpen: () => openPage(context, StallDetailPage(stall: selected.isEmpty ? 'Stan pilihan' : selected)), onRoute: () => openPage(context, RouteGuidePage(stall: selected.isEmpty ? 'Stan pilihan' : selected))),
      ]);
}

class MapZone extends StatelessWidget {
  const MapZone({super.key, required this.letter, required this.title, required this.color, required this.selectedStall, required this.onTap, this.stallNumbers});
  final String letter, title, selectedStall; final Color color; final ValueChanged<String> onTap;
  final List<String>? stallNumbers;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: Color.lerp(Colors.white, color, .07), border: Border.all(color: color, width: 1.4), borderRadius: BorderRadius.circular(9)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [CircleAvatar(radius: 11, backgroundColor: color, child: const Icon(Icons.pets, size: 12, color: Colors.white)), const SizedBox(width: 6), Expanded(child: Text('$letter • $title', style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w800)))]), const SizedBox(height: 7), GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 3, mainAxisSpacing: 4, crossAxisSpacing: 4, childAspectRatio: 1.18, children: List.generate(6, (i) { final stall = stallNumbers?[i] ?? '${i + 1}'; final name = '$letter-$stall'; final on = name == selectedStall; return InkWell(onTap: () => onTap(stall), borderRadius: BorderRadius.circular(4), child: Container(alignment: Alignment.center, decoration: BoxDecoration(color: on ? color : Colors.white, borderRadius: BorderRadius.circular(4)), child: Text(name, style: TextStyle(fontSize: 8, color: on ? Colors.white : color, fontWeight: FontWeight.w500)))); }))]));
}

class MapLegend extends StatelessWidget {
  const MapLegend({super.key, required this.color, required this.label}); final Color color; final String label;
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 7, height: 7, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))), const SizedBox(width: 4), Text(label, style: const TextStyle(color: muted, fontSize: 8))]);
}

class MapSelectedCard extends StatelessWidget {
  const MapSelectedCard({super.key, required this.stall, required this.onOpen, required this.onRoute});
  final String stall; final VoidCallback onOpen, onRoute;
  @override Widget build(BuildContext context) {
    final letter = stall.isNotEmpty ? stall[0] : 'B';
    final category = letter == 'A' ? 'Burung' : letter == 'C' ? 'Bunga' : letter == 'D' ? 'Hewan' : 'Ikan Hias';
    final data = sectorData(category);
    final isBudi = stall == 'B-12';
    return Container(padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFE8F3E9), borderRadius: BorderRadius.circular(5)), child: Text('${category.toUpperCase()} • $stall', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: forest, fontWeight: FontWeight.w700, fontSize: 8)))), const SizedBox(width: 8), const Text('Buka sekarang', style: TextStyle(fontSize: 9, color: forest))]),
      const SizedBox(height: 10), InkWell(onTap: onOpen, child: ClipRRect(borderRadius: BorderRadius.circular(9), child: Image.asset(data.$1, height: 112, width: double.infinity, fit: BoxFit.cover))),
      const SizedBox(height: 9), InkWell(onTap: onOpen, child: Text(isBudi ? 'Budi Aquarium' : 'Stan $stall', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800))),
      const SizedBox(height: 6), Text(isBudi ? 'Pemilik: Bapak Budi Santoso\nIkan hias, pakan, dan perlengkapan akuarium.' : 'Pedagang lokal Pasar Splendid. Pilihan produk dan perlengkapan $category.', style: const TextStyle(color: muted, height: 1.45, fontSize: 11)),
      const Padding(padding: EdgeInsets.only(top: 8, bottom: 10), child: Row(children: [Icon(Icons.directions_walk, color: forest, size: 16), SizedBox(width: 5), Expanded(child: Text('85 m dari lokasi Anda • ±2 menit jalan kaki', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: muted, fontSize: 9)))])),
      SizedBox(width: double.infinity, height: 36, child: FilledButton.icon(onPressed: onRoute, icon: const Icon(Icons.navigation, size: 16), label: const Text('Petunjuk Rute', style: TextStyle(fontSize: 10)), style: FilledButton.styleFrom(backgroundColor: forest))),
    ]));
  }
}

