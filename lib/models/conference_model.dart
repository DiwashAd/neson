class ConferenceModel {
  int? id;
  String? title;
  String? description;
  String? venue;
  String? date;
  String? time;
  String? image;
  List<Schedules>? schedules;
  String? scheduleDownloadUrl;
  String? memberDownloadUrl;
  List<Members>? members;
  List<Abstracts>? abstracts;
  String? createdAt;

  ConferenceModel(
      {this.id,
      this.title,
      this.description,
      this.venue,
      this.date,
      this.time,
      this.image,
      this.schedules,
      this.scheduleDownloadUrl,
      this.memberDownloadUrl,
      this.members,
      this.abstracts,
      this.createdAt});

  ConferenceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    venue = json['venue'];
    date = json['date'];
    time = json['time'];
    image = json['image'];
    if (json['schedules'] != null) {
      schedules = <Schedules>[];
      json['schedules'].forEach((v) {
        schedules!.add(new Schedules.fromJson(v));
      });
    }
    scheduleDownloadUrl = json['schedule_download_url'];
    memberDownloadUrl = json['member_download_url'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
    if (json['abstracts'] != null) {
      abstracts = <Abstracts>[];
      json['abstracts'].forEach((v) {
        abstracts!.add(new Abstracts.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['venue'] = this.venue;
    data['date'] = this.date;
    data['time'] = this.time;
    data['image'] = this.image;
    if (this.schedules != null) {
      data['schedules'] = this.schedules!.map((v) => v.toJson()).toList();
    }
    data['schedule_download_url'] = this.scheduleDownloadUrl;
    data['member_download_url'] = this.memberDownloadUrl;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    if (this.abstracts != null) {
      data['abstracts'] = this.abstracts!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Schedules {
  String? title;
  String? time;

  Schedules({this.title, this.time});

  Schedules.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['time'] = this.time;
    return data;
  }
}

class Members {
  String? name;
  String? position;
  String? image;

  Members({this.name, this.position, this.image});

  Members.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    position = json['position'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['position'] = this.position;
    data['image'] = this.image;
    return data;
  }
}

class Abstracts {
  int? id;
  String? title;
  User? user;
  String? fileUrl;
  String? createdAt;

  Abstracts({this.id, this.title, this.user, this.fileUrl, this.createdAt});

  Abstracts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    fileUrl = json['file_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['file_url'] = this.fileUrl;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class User {
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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
