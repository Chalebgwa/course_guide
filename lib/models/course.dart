class Course {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> category;
  final String state;
  final int enrolled;
  final int graduated;

  Course(this.id, this.title, this.description, this.imageUrl, this.category, this.state, this.enrolled, this.graduated);

  Course.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        imageUrl = json['imageUrl'],
        category = json['category'].cast<String>(),
        state = json['state'],
        enrolled = json['enrolled'],
        graduated = json['graduated'];


  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'category': category,
        'state': state,
        'enrolled': enrolled,
        'graduated': graduated,
      };  


      // Copy with method
  Course copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    List<String>? category,
    String? state,
    int? enrolled,
    int? graduated,
  }) {
    return Course(
      id ?? this.id,
      title ?? this.title,
      description ?? this.description,
      imageUrl ?? this.imageUrl,
      category ?? this.category,
      state ?? this.state,
      enrolled ?? this.enrolled,
      graduated ?? this.graduated,
    );
  }
}
