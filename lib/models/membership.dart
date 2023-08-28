class MembershipModel {
  int? id;
  FiscalYear? fiscalYear;
  MembershipType? membershipType;

  MembershipModel({this.id, this.fiscalYear, this.membershipType});

  MembershipModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fiscalYear = json['fiscal_year'] != null
        ? new FiscalYear.fromJson(json['fiscal_year'])
        : null;
    membershipType = json['membership_type'] != null
        ? new MembershipType.fromJson(json['membership_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.fiscalYear != null) {
      data['fiscal_year'] = this.fiscalYear!.toJson();
    }
    if (this.membershipType != null) {
      data['membership_type'] = this.membershipType!.toJson();
    }
    return data;
  }
}

class FiscalYear {
  int? id;
  String? title;
  String? startDate;
  String? endDate;
  String? isCurrent;
  String? createdAt;
  String? updatedAt;

  FiscalYear(
      {this.id,
      this.title,
      this.startDate,
      this.endDate,
      this.isCurrent,
      this.createdAt,
      this.updatedAt});

  FiscalYear.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    isCurrent = json['is_current'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['is_current'] = this.isCurrent;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class MembershipType {
  int? id;
  String? title;
  String? createdAt;
  String? updatedAt;

  MembershipType({this.id, this.title, this.createdAt, this.updatedAt});

  MembershipType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
