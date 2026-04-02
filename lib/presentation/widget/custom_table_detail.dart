import 'package:flutter/material.dart';

class CustomTableDetail extends StatelessWidget {
  final dynamic items;
  final List<String> whitelistKeys;
  final bool detailLabel;

  const CustomTableDetail({
    super.key,
    required this.items,
    this.whitelistKeys = const [],
    this.detailLabel = true,
  });

  // Auto Format 'Key' Data
  // Display: (e.g., "release_date" -> "Release Date")
  String _formatKey(String key) {
    return key
        .split('_')
        .map(
          (word) =>
              word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '',
        )
        .join(' ');
  }

  // Auto Format 'Value' Data
  String _formatValue(dynamic value) {
    if (value == null) return '-';
    if (value is List) return value.isEmpty ? '-' : value.join(', ');
    if (value is String && value.isEmpty) return '';
    if (value is Map) {
      return value.entries.map((e) => "${e.key}: ${e.value}").join('\n');
    }
    return value.toString();
  }

  String formatList(List<String>? list) => list?.join(", ") ?? "-";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> rawData = (items is Map)
        ? items
        : (items.toJson() as Map<String, dynamic>);

    final List<String> keysToDisplay = whitelistKeys.isEmpty
        ? rawData.keys.toList()
        : whitelistKeys.where((key) => rawData.containsKey(key)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (detailLabel && keysToDisplay.isNotEmpty)
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              "Detail",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

        if (keysToDisplay.isEmpty)
          const Center(child: Text("No data matches the filter.")),

        if (keysToDisplay.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 0.5,
                ),
              ),
              child: Table(
                columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: List.generate(keysToDisplay.length, (index) {
                  final key = keysToDisplay[index];
                  final value = rawData[key];
                  final isEven = index % 2 == 0;

                  return TableRow(
                    decoration: BoxDecoration(
                      color: isEven
                          ? Theme.of(context).colorScheme.surfaceContainerLow
                          : Theme.of(context).colorScheme.surface,
                    ),
                    children: [
                      _buildCell(context, _formatKey(key), isKey: true),
                      _buildCell(context, _formatValue(value)),
                    ],
                  );
                }),
              ),
            ),
          ),
      ],
    );
  }
}

Widget _buildCell(BuildContext context, String text, {bool isKey = false}) {
  final theme = Theme.of(context).colorScheme;
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: isKey ? FontWeight.w700 : FontWeight.normal,
        color: isKey ? theme.onSurfaceVariant : theme.onSurface,
      ),
    ),
  );
}
