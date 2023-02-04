import 'package:flutter/material.dart';
// staggereed grid view
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Unipage extends StatelessWidget {
  const Unipage({Key? key, required this.uni}) : super(key: key);

  final Map<String, dynamic> uni;

  @override
  Widget build(BuildContext context) {
    final images = uni['images'];

    return Scaffold(
      appBar: AppBar(
        title: Text(uni["name"]),
      ),
      body: GridView.custom(
        semanticChildCount: 1,
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: [
            QuiltedGridTile(2, 2),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 2),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.black,
                      elevation: 0,
                    ),
                    backgroundColor: Colors.black,
                    body: Center(
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: NetworkImage(images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          childCount: images.length,
        ),
      ),
    );
  }
}
