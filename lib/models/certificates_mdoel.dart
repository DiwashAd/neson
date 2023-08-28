class CertificateModel {
  int? id;
  String? title;
  String? document;
  String? type;
  String? createdAt;

  CertificateModel(
      {this.id, this.title, this.document, this.type, this.createdAt});

  CertificateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    document = json['document'];
    type = json['type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['document'] = this.document;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    return data;
  }
}
