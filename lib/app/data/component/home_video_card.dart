import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';
import 'package:popover/popover.dart';


class HomeVideoCard extends StatelessWidget {
  final String thumbnailUrl;
  final String title;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onClick;
  final VoidCallback onOptionsPressed;

  const HomeVideoCard({
    Key? key,
    required this.thumbnailUrl,
    required this.title,
    required this.onOptionsPressed, required this.onEdit, required this.onDelete, required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail (bagian atas)
            Image.network(
              thumbnailUrl,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return SvgPicture.asset(
                  'assets/error_pages.svg',
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 180,
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Jika tidak ada progress, tampilkan gambar
                } else {
                  double progress = (loadingProgress.expectedTotalBytes != null && loadingProgress.expectedTotalBytes != 0)
                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                      : 0;
                  return Container(
                    height: 180,
                    width: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colours.primary500,
                        value: progress, // Update progress sesuai dengan pemuatan
                      ),
                    ),
                  );
                }
              },
            ),
            // Bagian bawah: Judul dan ikon opsi
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Judul video
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Ikon opsi (tiga titik)
                  Builder(
                    builder: (ctx) =>  VideosMenu(ctx: ctx, onDelete: onDelete, onEdit: onEdit,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconButton VideosMenu({required BuildContext ctx, required Function() onEdit, required  Function() onDelete}) {
    return IconButton(
                    onPressed: () {
                      final RenderBox button = ctx.findRenderObject() as RenderBox;
                      final RenderBox overlay = Overlay.of(ctx).context.findRenderObject() as RenderBox;
                      final RelativeRect position = RelativeRect.fromRect(
                        Rect.fromPoints(
                          button.localToGlobal(Offset.zero, ancestor: overlay),
                          button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
                        ),
                        Offset.zero & overlay.size,
                      );
                      showMenu(
                        context: ctx,
                        color: Colors.white,
                        position: position,
                        items: [
                          PopupMenuItem(
                            child: GestureDetector(
                              onTap: () => onEdit,
                              child: Text("Edit"),
                            ),
                          ),
                          PopupMenuItem(
                            child: GestureDetector(
                              onTap: () => onDelete,
                              child: Text("Delete"),
                            ),
                          ),
                        ],
                      );
                    },
                    icon: Icon(Icons.more_vert, color: Colours.font),
                  );
  }
}


