part of '../pokemon_detail_page.dart';

class _WidgetEvolutionItem extends StatelessWidget {
  const _WidgetEvolutionItem({
    required this.name,
    required this.secondName,
    required this.level,
    required this.id,
    this.secondID,
  });

  final int id;
  final String name;
  final int? secondID;
  final String secondName;
  final dynamic level;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildItem(id, name),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.navigate_next_rounded),
            if (level != null)
              Text(
                'Level $level',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
          ],
        ),
        _buildItem(secondID, secondName),
      ],
    ).marginOnly(bottom: 40);
  }

  Widget _buildItem(int? id, String name) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/pokeball.png',
              color: Colors.black12,
              width: 150,
              height: 150,
            ),
            CachedNetworkImage(
              imageUrl: '${AppConfig.baseUrlImg}$id.png',
              height: 100.0,
              width: 100.0,
              errorWidget: (context, url, error) => Container(
                color: Colors.transparent,
              ),
              placeholder: (context, url) => Container(
                color: Colors.transparent,
              ),
            ),
          ],
        ),
        Text(name.capitalize!),
      ],
    );
  }
}
