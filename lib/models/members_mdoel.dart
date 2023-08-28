class MembersModel {
  int? id;
  String? name;
  String? position;
  String? type;
  String? image;
  String? duration;
  String? createdAt;

  MembersModel(
      {this.id,
      this.name,
      this.position,
      this.type,
      this.image,
      this.duration,
      this.createdAt});

  MembersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    position = json['position'];
    type = json['type'];
    image = json['image'];
    duration = json['duration'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['type'] = this.type;
    data['image'] = this.image;
    data['duration'] = this.duration;
    data['created_at'] = this.createdAt;
    return data;
  }
}
