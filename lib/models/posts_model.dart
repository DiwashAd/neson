class PostsModel {
  int? id;
  String? title;
  String? subtitle;
  String? content;
  String? slug;
  String? featuredImage;
  String? createdAt;

  PostsModel(
      {this.id,
      this.title,
      this.subtitle,
      this.content,
      this.slug,
      this.featuredImage,
      this.createdAt});

  PostsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    content = json['content'];
    slug = json['slug'];
    featuredImage = json['featured_image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['content'] = this.content;
    data['slug'] = this.slug;
    data['featured_image'] = this.featuredImage;
    data['created_at'] = this.createdAt;
    return data;
  }
}
