import 'package:flutter/material.dart';
import 'package:project/data/model/product.dart';

class CustomCategoryBubble extends StatelessWidget {
  final List<dynamic> items;
  final double height;
  final bool autoNavigate;
  final Widget? destination;

  const CustomCategoryBubble({
    super.key,
    required this.items,
    this.height = 110,
    this.autoNavigate = false,
    this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(width: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final String name = (item is Product) ? item.name : item.toString();
          final String imageUrl = (item is Product && item.images.isNotEmpty)
              ? item.images[0]
              : "";
          return Column(
            spacing: 4,
            children: [
              InkWell(
                onTap: () {
                  if (autoNavigate && destination != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => destination!),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(50),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: (item is Product)
                      ? Image.network(
                          imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/placeholder-Image.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
            ],
          );
        },
      ),
    );
  }
}
