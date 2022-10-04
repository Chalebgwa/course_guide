// user model
class Client {
  final String uid;
  final String email;
  final String name;
  final String? photoURL;
  final String? location;
  final DateTime? createdAt;
  final DateTime? dob;

  Client(this.uid, this.email, this.name, this.photoURL, this.location,
      this.createdAt, this.dob);

  Client.fromMap(Map<String, dynamic> data)
      : uid = data['uid'],
        email = data['email'],
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
      'createdAt': createdAt,
      'dob': dob,
    };
  }
}
