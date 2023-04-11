// user model
class Client {
  final String uid;
  final String email;
  final String name;
  final String? photoURL;
  final String? location;
  final DateTime? createdAt;
  final DateTime? dob;
  final String? phone;
  final Map<String, dynamic>? results;

  Client(
    this.uid,
    this.email,
    this.name,
    this.photoURL,
    this.location,
    this.createdAt,
    this.dob,
    this.phone, {
    this.results,
  });

  Client.fromMap(
    Map<String, dynamic> data,
  )   : uid = data['uid'],
        email = data['email'],
        results = data['result'],
        phone = data['phone'],
        name = data['name'],
        photoURL = data['photoURL'],
        location = data['location'],
        createdAt = data['createdAt'] != null
            ? DateTime.parse(data['createdAt'])
            : null,
        dob = data['dob'] != null ? DateTime.parse(data['dob']) : null;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'photoURL': photoURL,
      'location': location,
      'createdAt': createdAt?.toIso8601String(),
      "phone": phone,
      'dob': dob?.toIso8601String(),
      'result': results,
    };
  }

  // copy with
  Client copyWith({
    String? uid,
    String? email,
    String? name,
    String? photoURL,
    String? location,
    DateTime? createdAt,
    DateTime? dob,
    String? phone,
    Map<String, dynamic>? results,
  }) {
    return Client(
      uid ?? this.uid,
      email ?? this.email,
      name ?? this.name,
      photoURL ?? this.photoURL,
      location ?? this.location,
      createdAt ?? this.createdAt,
      dob ?? this.dob,
      phone ?? this.phone,
      results: results ?? this.results,
    );
  }

  @override
  String toString() {
    return name;
  }
}
