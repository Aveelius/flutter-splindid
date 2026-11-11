import 'package:flutter/material.dart';
import 'package:pasar_splindid_app/core/widgets/shared_widgets.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});
  @override
  Widget build(BuildContext context) => PageBody(children: [
        const PageIntro(title: 'Komunitas Splendid', description: 'Berbagi cerita, bertukar tips, dan bertemu sesama pecinta flora & fauna.'),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13)), child: Column(children: [
          Row(children: [const Avatar(), const SizedBox(width: 10), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Apa cerita hobimu hari ini?', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11)), SizedBox(height: 3), Text('Bagikan foto dan inspirasi ke komunitas.', style: TextStyle(color: muted, fontSize: 10))]))]),
          const SizedBox(height: 11), SizedBox(width: double.infinity, height: 36, child: FilledButton.icon(onPressed: () => openPage(context, const ComposePostPage()), icon: const Icon(Icons.add, size: 17), label: const Text('Buat Postingan Baru', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)), style: FilledButton.styleFrom(backgroundColor: forest))),
        ])),
        const SizedBox(height: 11), Row(children: [const Expanded(child: Text('Kabar komunitas', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800))), InkWell(onTap: () => openPage(context, const CommunityFeedPage()), borderRadius: BorderRadius.circular(6), child: const Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6), child: Text('Terbaru', style: TextStyle(fontSize: 10, color: forest))))]),
        const StoryCard(name: 'Rizky Pratama', subtitle: '2 jam lalu • Pasar Ikan Hias', image: 'assets/images/aquascape.png', sideImage: 'assets/images/guppy.png', message: 'Akhirnya aquascape pertama jadi! Tanaman dan guppy-nya dari stan Pak Budi. Ada tips supaya air tetap jernih?', tags: '#PecintaIkan #Aquascape #SplendidMalang', likes: 128, comments: 24),
        const SizedBox(height: 14),
        const StoryCard(name: 'Dewi Lestari', subtitle: '4 jam lalu • Pasar Bunga', image: 'assets/images/community_garden.png', sideImage: 'assets/images/flowers.png', message: 'Sudut teras makin segar dengan anggrek baru dari Splendid 🌿 Ternyata cukup cahaya pagi dan siram dua kali seminggu.', tags: '#PecintaTanaman #Anggrek #TerasHijau', likes: 86, comments: 12),
        const SizedBox(height: 18), const PageIntro(title: 'Temukan Grup Hobi', description: 'Obrolan seru dimulai dari hobi yang sama.'),
        GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.12, children: const [
          HobbyGroup(icon: Icons.set_meal, title: 'Pecinta Ikan Malang', members: '1.240 anggota', color: Color(0xFFE8F3E9)), HobbyGroup(icon: Icons.flutter_dash, title: 'Kicau Mania Splendid', members: '860 anggota', color: Color(0xFFFFE9EB)),
          HobbyGroup(icon: Icons.local_florist_outlined, title: 'Sahabat Tanaman', members: '720 anggota', color: Color(0xFFFFF1DE)), HobbyGroup(icon: Icons.pets, title: 'Komunitas Pet Lovers', members: '540 anggota', color: Color(0xFFE6F1FF)),
        ]),
      ]);
}

class StoryCard extends StatefulWidget {
  const StoryCard({super.key, required this.name, required this.subtitle, required this.image, required this.sideImage, required this.message, required this.tags, required this.likes, required this.comments});
  final String name, subtitle, image, sideImage, message, tags; final int likes, comments;
  @override State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  bool liked = false;
  Widget action(IconData icon, String label, VoidCallback onTap, {Color color = forest}) => Expanded(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon, color: color, size: 17),
              const SizedBox(width: 4),
              Flexible(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFF4E5C53), fontSize: 10))),
            ]),
          ),
        ),
      );
  @override Widget build(BuildContext context) => Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(padding: const EdgeInsets.fromLTRB(12, 8, 7, 7), child: Row(children: [Avatar(size: 36), const SizedBox(width: 9), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)), const SizedBox(height: 3), Text(widget.subtitle, style: const TextStyle(color: muted, fontSize: 10))])), IconButton(onPressed: () => showPostMenu(context), icon: const Icon(Icons.more_horiz, size: 20), visualDensity: VisualDensity.compact)])),
    InkWell(onTap: () => openPage(context, const PostDetailPage()), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: ClipRRect(borderRadius: BorderRadius.circular(9), child: SizedBox(height: 165, child: Row(children: [Expanded(flex: 4, child: Image.asset(widget.image, fit: BoxFit.cover, height: 165)), const SizedBox(width: 6), Expanded(child: Image.asset(widget.sideImage, fit: BoxFit.cover, height: 165))]))))),
    Padding(padding: const EdgeInsets.fromLTRB(12, 8, 12, 0), child: Row(children: [Container(width: 14, height: 4, decoration: BoxDecoration(color: forest, borderRadius: BorderRadius.circular(4))), const SizedBox(width: 5), Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFFDCE2DD), shape: BoxShape.circle)), const Spacer(), const Text('1 / 2 foto', style: TextStyle(color: muted, fontSize: 9))])),
    Padding(padding: const EdgeInsets.fromLTRB(12, 13, 12, 0), child: Text(widget.message, style: const TextStyle(fontSize: 11, height: 1.4))),
    Padding(padding: const EdgeInsets.fromLTRB(12, 8, 12, 10), child: Text(widget.tags, style: const TextStyle(color: forest, fontSize: 10, fontWeight: FontWeight.w500))), const Divider(height: 1, indent: 12, endIndent: 12),
    Row(children: [
      action(liked ? Icons.favorite : Icons.favorite_border, 'Suka ${widget.likes + (liked ? 1 : 0)}', () => setState(() => liked = !liked), color: liked ? Colors.red : forest),
      action(Icons.mode_comment_outlined, 'Komentar ${widget.comments}', () => openPage(context, const CommentsPage())),
      action(Icons.share_outlined, 'Bagikan', () => sharePost(context)),
    ]),
  ]));
}

class HobbyGroup extends StatefulWidget {
  const HobbyGroup({super.key, required this.icon, required this.title, required this.members, required this.color});
  final IconData icon; final String title, members; final Color color;
  @override State<HobbyGroup> createState() => _HobbyGroupState();
}

class _HobbyGroupState extends State<HobbyGroup> {
  bool joined = false;
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 33, height: 33, decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.circular(9)), child: Icon(widget.icon, color: forest, size: 18)), const SizedBox(height: 7), Text(widget.title, maxLines: 2, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800)), const SizedBox(height: 3), Text(widget.members, style: const TextStyle(fontSize: 9, color: muted)), const Spacer(), SizedBox(width: double.infinity, height: 34, child: FilledButton(onPressed: () { setState(() => joined = !joined); if (joined) openPage(context, HobbyGroupPage(title: widget.title)); }, style: FilledButton.styleFrom(backgroundColor: const Color(0xFFE8F3E9), foregroundColor: forest, elevation: 0), child: Text(joined ? 'Bergabung ✓' : 'Gabung', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700))))]));
}

class HobbyGroupPage extends StatefulWidget {
  const HobbyGroupPage({super.key, required this.title}); final String title;
  @override State<HobbyGroupPage> createState() => _HobbyGroupPageState();
}

class _HobbyGroupPageState extends State<HobbyGroupPage> {
  final message = TextEditingController(); final posts = ['Selamat datang! Kenalan dulu, ceritakan hobi dan pengalamanmu.', 'Ada rekomendasi toko pakan dan perlengkapan yang bagus di sekitar Malang?'];
  @override void dispose() { message.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => SubPage(
        title: widget.title,
        child: Column(children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Icon(Icons.groups_2, color: forest, size: 30),
                    const SizedBox(height: 8),
                    Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                    const SizedBox(height: 4),
                    const Text('Komunitas hobi warga Malang • 1.240 anggota', style: TextStyle(color: muted, fontSize: 11)),
                  ]),
                ),
                const SizedBox(height: 14),
                ...posts.map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        child: Text(p, style: const TextStyle(fontSize: 12, height: 1.4)),
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              Expanded(child: TextField(controller: message, decoration: const InputDecoration(hintText: 'Tulis ke grup...', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderSide: BorderSide.none)))),
              IconButton(
                onPressed: () {
                  if (message.text.trim().isNotEmpty) {
                    setState(() { posts.add(message.text.trim()); message.clear(); });
                  }
                },
                icon: const Icon(Icons.send, color: forest),
              ),
            ]),
          ),
        ]),
      );
}

class CommunityPostCard extends StatelessWidget {
  const CommunityPostCard({super.key, required this.name, required this.subtitle, required this.message, required this.onTap});
  final String name, subtitle, message; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(13), child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [const Avatar(), const SizedBox(width: 9), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w700)), Text(subtitle, style: const TextStyle(fontSize: 10, color: muted))])]), const SizedBox(height: 10), Text(message, style: const TextStyle(fontSize: 11, height: 1.35)), const SizedBox(height: 7), const Text('Suka 36  •  Komentar 8', style: TextStyle(fontSize: 10, color: muted))])));
}

class CommunityFeedPage extends StatelessWidget { const CommunityFeedPage({super.key}); @override Widget build(BuildContext context) => SubPage(title: 'Kabar komunitas', child: ListView(padding: const EdgeInsets.all(16), children: [CommunityPostCard(name: 'Rizky Pratama', subtitle: '2 jam lalu • Pasar Ikan Hias', message: 'Akhirnya aquascape pertama jadi! Ada tips supaya air tetap jernih?', onTap: () => openPage(context, const PostDetailPage())), const SizedBox(height: 12), CommunityPostCard(name: 'Dina Lestari', subtitle: 'Kemarin • Komunitas Tanaman', message: 'Monstera baruku akhirnya mengeluarkan daun baru!', onTap: () => openPage(context, const PostDetailPage()))])); }

class PostDetailPage extends StatelessWidget { const PostDetailPage({super.key}); @override Widget build(BuildContext context) => SubPage(title: 'Postingan komunitas', child: ListView(padding: const EdgeInsets.all(16), children: [CommunityPostCard(name: 'Rizky Pratama', subtitle: '2 jam lalu • Pasar Ikan Hias', message: 'Akhirnya aquascape pertama jadi! Tanaman dan guppy-nya dari stan Pak Budi. Ada tips supaya air tetap jernih?', onTap: () {}), const SizedBox(height: 16), FilledButton.icon(onPressed: () => openPage(context, const CommentsPage()), icon: const Icon(Icons.mode_comment_outlined), label: const Text('Lihat komentar'), style: FilledButton.styleFrom(backgroundColor: forest))])); }

class CommentsPage extends StatefulWidget { const CommentsPage({super.key}); @override State<CommentsPage> createState() => _CommentsPageState(); }

class _CommentsPageState extends State<CommentsPage> {
  final input = TextEditingController();
  final comments = ['Gunakan filter biologis dan jangan terlalu sering memberi pakan.', 'Tanamannya bagus! Bisa coba ganti air 20% setiap minggu.'];
  @override void dispose() { input.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => SubPage(
        title: 'Komentar',
        child: Column(children: [
          Expanded(child: ListView(padding: const EdgeInsets.all(16), children: comments.map((c) => ListTile(
                leading: const Avatar(),
                title: Text(c, style: const TextStyle(fontSize: 12)),
                subtitle: const Text('Anggota komunitas • baru saja', style: TextStyle(fontSize: 10, color: muted)),
              )).toList())),
          Padding(padding: const EdgeInsets.all(12), child: Row(children: [
            Expanded(child: TextField(controller: input, decoration: const InputDecoration(hintText: 'Tulis komentar...', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderSide: BorderSide.none)))),
            IconButton(onPressed: () {
              if (input.text.trim().isNotEmpty) setState(() { comments.add(input.text.trim()); input.clear(); });
            }, icon: const Icon(Icons.send, color: forest)),
          ])),
        ]),
      );
}

class ComposePostPage extends StatefulWidget { const ComposePostPage({super.key}); @override State<ComposePostPage> createState() => _ComposePostPageState(); }

class _ComposePostPageState extends State<ComposePostPage> { final input = TextEditingController(); @override void dispose() { input.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => SubPage(title: 'Postingan baru', child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [TextField(controller: input, maxLines: 7, decoration: const InputDecoration(hintText: 'Ceritakan kegiatan flora atau faunamu...', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderSide: BorderSide.none))), const SizedBox(height: 12), Row(children: [Expanded(child: OutlinedButton.icon(onPressed: () => showInfo(context, 'Tambah foto', 'Pemilih foto siap digunakan.'), icon: const Icon(Icons.image_outlined), label: const Text('Tambah foto', maxLines: 1, overflow: TextOverflow.ellipsis))), const SizedBox(width: 8), Expanded(child: FilledButton(onPressed: () { if (input.text.trim().isEmpty) { showInfo(context, 'Postingan kosong', 'Tulis cerita sebelum membagikan postingan.'); } else { final navigator = Navigator.of(context); navigator.pop(); showInfo(navigator.context, 'Terkirim', 'Postinganmu berhasil dibagikan ke komunitas.'); } }, style: FilledButton.styleFrom(backgroundColor: forest), child: const Text('Bagikan')))])]))); }
