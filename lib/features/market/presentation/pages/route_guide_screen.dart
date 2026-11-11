import 'package:flutter/material.dart';

import 'package:pasar_splindid_app/core/widgets/shared_widgets.dart';

class RouteGuidePage extends StatelessWidget {
  const RouteGuidePage({super.key, required this.stall});

  final String stall;

  @override
  Widget build(BuildContext context) => SubPage(
        title: 'Petunjuk Rute',
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.map_outlined, color: forest, size: 46),
              const SizedBox(height: 12),
              Text('Menuju $stall', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              const NoticeRow(
                icon: Icons.looks_one_outlined,
                title: 'Mulai dari pintu masuk utama',
                detail: 'Pintu masuk berada di sisi Jalan Brawijaya.',
              ),
              const NoticeRow(
                icon: Icons.looks_two_outlined,
                title: 'Ikuti jalur utama',
                detail: 'Jalan lurus sekitar 65 meter melewati kios tengah.',
              ),
              const NoticeRow(
                icon: Icons.place_outlined,
                title: 'Stan berada di Zona B',
                detail: 'Belok kanan dan cari nomor stan yang dipilih.',
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(backgroundColor: forest),
                  child: const Text('Selesai'),
                ),
              ),
            ],
          ),
        ),
      );
}
