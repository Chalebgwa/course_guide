class Course {
  final String? id;
  final String? title;
  final String? uniId;
  final String? applicationFee;
  final String? careerOpportunities;
  final String? category;
  final String? courseType;
  final String? description;
  final String? duration;
  final String? enrolled;
  final String? faculty;
  final String? featured;
  final String? graduated;
  final String? imageUrl;
  final String? requirements;
  final String? state;
  final String? whatCanYouStudy;
  final String? installments;
  final String? totalFee;
  final String? finalExamFee;
  final String? midSemesterFee;
  final String? deposit;

  Course(
    this.id,
    this.title,
    this.uniId,
    this.applicationFee,
    this.careerOpportunities,
    this.category,
    this.courseType,
    this.description,
    this.duration,
    this.enrolled,
    this.faculty,
    this.featured,
    this.graduated,
    this.imageUrl,
    this.requirements,
    this.state,
    this.whatCanYouStudy,
    this.installments,
    this.totalFee,
    this.finalExamFee,
    this.midSemesterFee,
    this.deposit,
  );

  // fromJson
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      json['id'],
      json['title'],
      json['uniId'],
      json['applicationFee'],
      json['careerOpportunities'],
      json['category'],
      json['courseType'],
      json['description'],
      json['duration'],
      json['enrolled'],
      json['faculty'],
      json['featured'],
      json['graduated'],
      json['imageUrl'],
      json['requirements'],
      json['state'],
      json['whatCanYouStudy'],
      json['installments'],
      json['totalFee'],
      json['finalExamFee'],
      json['midSemesterFee'],
      json['deposit'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'applicationFee': applicationFee,
      'careerOpportunities': careerOpportunities,
      'category': category,
      'courseType': courseType,
      'description': description,
      'duration': duration,
      'enrolled': enrolled,
      'faculty': faculty,
      'featured': featured,
      'uniId': uniId,
      'graduated': graduated,
      'imageUrl': imageUrl,
      'requirements': requirements,
      'state': state,
      'whatCanYouStudy': whatCanYouStudy,
      'installments': installments,
      'totalFee': totalFee,
      'finalExamFee': finalExamFee,
      'midSemesterFee': midSemesterFee,
      'deposit': deposit,
    };
  }

  // copyWith
}
