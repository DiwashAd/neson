class UserModel {
  String? email;
  String? title;
  String? firstName;
  String? lastName;
  String? fullName;
  String? titleName;
  String? avatar;
  String? nmcNo;
  String? address;
  String? mobile;
  String? gender;

  UserModel(
      {this.email,
      this.title,
      this.firstName,
      this.lastName,
      this.fullName,
      this.titleName,
      this.avatar,
      this.nmcNo,
      this.address,
      this.mobile,
      this.gender});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    title = json['title'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    titleName = json['title_name'];
    avatar = json['avatar'];
    nmcNo = json['nmc_no'];
    address = json['address'];
    mobile = json['mobile'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['title'] = this.title;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
    data['title_name'] = this.titleName;
    data['avatar'] = this.avatar;
    data['nmc_no'] = this.nmcNo;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    return data;
  }
}
