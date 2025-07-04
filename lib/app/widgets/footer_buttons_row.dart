part of 'widgets.dart';

class FooterButtonsRow extends StatelessWidget {
  final List<Widget> children;

  FooterButtonsRow({
    super.key,
    required this.children
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(spacing: 8, children: children));
  }
}
