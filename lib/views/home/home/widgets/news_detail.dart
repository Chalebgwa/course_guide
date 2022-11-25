import 'package:course_guide/models/news.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  const NewsDetail({Key? key, required this.news}) : super(key: key);
  final News news;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              news.image,
              fit: BoxFit.cover,
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(news.title),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(news.description),
              ),
            ],
          ),
        ),
      ],
    
    );
  }
}
