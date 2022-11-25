class News {
  final String title;
  final String description;
  final String image;
  final String link;

  News(this.title, this.description, this.image, this.link);

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      json['title'],
      json['description'],
      json['imageUrl'],
      json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': image,
      'link': link,
    };
  }

  News copyWith({
    String? title,
    String? description,
    String? image,
    String? link,
  }) {
    return News(
      title ?? this.title,
      description ?? this.description,
      image ?? this.image,
      link ?? this.link,
    );
  }

  @override
  String toString() {
    
    return title;
    
  }
  
}