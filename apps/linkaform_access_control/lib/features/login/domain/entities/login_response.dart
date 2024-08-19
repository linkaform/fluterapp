import 'dart:convert';

class LoginResponse {
  final String response;
  final String headers;

  LoginResponse({required this.response, required this.headers});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        response: json['response'] as String,
        headers: json['headers'] as String,
      );

  Map<String, dynamic> toJson() => {
        'response': response,
        'headers': headers,
      };

  ResponseData get responseData => ResponseData.fromJson(
        json.decode(response) as Map<String, dynamic>,
      );

  HeadersData get headersData =>
      HeadersData.fromJson(json.decode(headers) as Map<String, dynamic>);
}

class ResponseData {
  final int code;
  final String jwt;
  final String sessionId;
  final bool success;
  final UserData user;

  ResponseData({
    required this.code,
    required this.jwt,
    required this.sessionId,
    required this.success,
    required this.user,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        code: json['code'] as int,
        jwt: json['jwt'] as String,
        sessionId: json['session_id'] as String,
        success: json['success'] as bool,
        user: UserData.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'jwt': jwt,
        'session_id': sessionId,
        'success': success,
        'user': user.toJson(),
      };
}

class UserData {
  final String apiKey;
  final Map<String, dynamic> birtAuthid;
  final CompanyLogo companyLogo;
  final DateTime createdAt;
  final dynamic createdBy;
  final DateTime dateJoined;
  final dynamic deletedAt;
  final dynamic domainLinked;
  final String email;
  final String firstName;
  final List<int> groups;
  final int id;
  final bool isActive;
  final bool isOnline;
  final Lang lang;
  final DateTime lastLogin;
  final DateTime? lastLogout;
  final bool licenseExpired;
  final String name;
  final String parent;
  final ParentInfo parentInfo;
  final List<String> permissions;
  final String phone;
  final String position;
  final String profilePicture;
  final String resourceUri;
  final String thumb;
  final String timezone;
  final DateTime updatedAt;
  final String updatedBy;
  final String username;

  UserData({
    required this.apiKey,
    required this.birtAuthid,
    required this.companyLogo,
    required this.createdAt,
    required this.createdBy,
    required this.dateJoined,
    required this.deletedAt,
    required this.domainLinked,
    required this.email,
    required this.firstName,
    required this.groups,
    required this.id,
    required this.isActive,
    required this.isOnline,
    required this.lang,
    required this.lastLogin,
    required this.lastLogout,
    required this.licenseExpired,
    required this.name,
    required this.parent,
    required this.parentInfo,
    required this.permissions,
    required this.phone,
    required this.position,
    required this.profilePicture,
    required this.resourceUri,
    required this.thumb,
    required this.timezone,
    required this.updatedAt,
    required this.updatedBy,
    required this.username,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      apiKey: json['api_key'] as String,
      birtAuthid: jsonDecode((json['birt_authid'] as String)
          .replaceAll(RegExp(r"u'"), "'")
          .trim()
          .replaceAll("'", '"')) as Map<String, dynamic>,
      companyLogo:
          CompanyLogo.fromJson(json['company_logo'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'],
      // createdBy puede ser nulo, así que no lo casteamos
      dateJoined: DateTime.fromMillisecondsSinceEpoch(
          ((json['date_joined'] as num) * 1000).toInt()),
      deletedAt: json['deleted_at'],
      // deletedAt puede ser nulo, así que no lo casteamos
      domainLinked: json['domain_linked'],
      // domainLinked puede ser nulo, así que no lo casteamos
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      groups: List<int>.from((json['groups'] as List<dynamic>).map((x) => x)),
      id: json['id'] as int,
      isActive: json['is_active'] as bool,
      isOnline: json['is_online'] as bool,
      lang: Lang.fromJson(json['lang'] as Map<String, dynamic>),
      lastLogin: DateTime.fromMillisecondsSinceEpoch(
          ((json['last_login'] as num) * 1000).toInt()),
      lastLogout: json['last_logout'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              ((json['last_logout'] as num) * 1000).toInt())
          : null,
      licenseExpired: json['license_expired'] as bool,
      name: json['name'] as String,
      parent: json['parent'] as String,
      parentInfo:
          ParentInfo.fromJson(json['parent_info'] as Map<String, dynamic>),
      permissions: List<String>.from(
          (json['permissions'] as List<dynamic>).map((x) => x)),
      phone: json['phone'] as String,
      position: json['position'] as String,
      profilePicture: json['profile_picture'] as String,
      resourceUri: json['resource_uri'] as String,
      thumb: json['thumb'] as String,
      timezone: json['timezone'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      updatedBy: json['updated_by'] as String,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'api_key': apiKey,
        'birt_authid': jsonEncode(birtAuthid),
        'company_logo': companyLogo.toJson(),
        'created_at': createdAt.toIso8601String(),
        'created_by': createdBy,
        'date_joined': dateJoined.millisecondsSinceEpoch ~/ 1000,
        'deleted_at': deletedAt,
        'domain_linked': domainLinked,
        'email': email,
        'first_name': firstName,
        'groups': List<dynamic>.from(groups.map((x) => x)),
        'id': id,
        'is_active': isActive,
        'is_online': isOnline,
        'lang': lang.toJson(),
        'last_login': lastLogin.millisecondsSinceEpoch ~/ 1000,
        'last_logout': (lastLogout?.millisecondsSinceEpoch ?? 0) ~/ 1000,
        'license_expired': licenseExpired,
        'name': name,
        'parent': parent,
        'parent_info': parentInfo.toJson(),
        'permissions': List<dynamic>.from(permissions.map((x) => x)),
        'phone': phone,
        'position': position,
        'profile_picture': profilePicture,
        'resource_uri': resourceUri,
        'thumb': thumb,
        'timezone': timezone,
        'updated_at': updatedAt.toIso8601String(),
        'updated_by': updatedBy,
        'username': username,
      };
}

class CompanyLogo {
  final String picture;
  final String thumbnail;

  CompanyLogo({
    required this.picture,
    required this.thumbnail,
  });

  factory CompanyLogo.fromJson(Map<String, dynamic> json) => CompanyLogo(
        picture: json['picture'] as String,
        thumbnail: json['thumbnail'] as String,
      );

  Map<String, dynamic> toJson() => {
        'picture': picture,
        'thumbnail': thumbnail,
      };
}

class Lang {
  final String code;
  final String lang;

  Lang({
    required this.code,
    required this.lang,
  });

  factory Lang.fromJson(Map<String, dynamic> json) => Lang(
        code: json['code'] as String,
        lang: json['lang'] as String,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'lang': lang,
      };
}

class ParentInfo {
  final String email;
  final int id;
  final String name;

  ParentInfo({
    required this.email,
    required this.id,
    required this.name,
  });

  factory ParentInfo.fromJson(Map<String, dynamic> json) => ParentInfo(
        email: json['email'] as String,
        id: json['id'] as int,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'id': id,
        'name': name,
      };
}

class HeadersData {
  final List<String> cacheControl;
  final List<String> setCookie;
  final List<String> date;
  final List<String> transferEncoding;
  final List<String> vary;
  final List<String> contentType;
  final List<String> contentLanguage;
  final List<String> server;
  final List<String> password;

  HeadersData({
    required this.cacheControl,
    required this.setCookie,
    required this.date,
    required this.transferEncoding,
    required this.vary,
    required this.contentType,
    required this.contentLanguage,
    required this.server,
    required this.password,
  });

  factory HeadersData.fromJson(Map<String, dynamic> json) {
    final parsedHeaders = json.map((key, value) {
      if (value is List<dynamic>) {
        return MapEntry(key, value.cast<String>());
      } else if (value != null) {
        return MapEntry(key, [value.toString()]);
      } else {
        return MapEntry(key, []);
      }
    });

    return HeadersData(
      cacheControl: parsedHeaders['cache-control']  as List<String>,
      setCookie: parsedHeaders['set-cookie'] as List<String>,
      date: parsedHeaders['date'] as List<String>,
      transferEncoding: parsedHeaders['transfer-encoding'] as List<String>,
      vary: parsedHeaders['vary'] as List<String>,
      contentType: parsedHeaders['content-type'] as List<String>,
      contentLanguage: parsedHeaders['content-language'] as List<String>,
      server: parsedHeaders['server'] as List<String>,
      password: parsedHeaders['password'] as List<String>,
    );
    }

  Map<String, dynamic> toJson() => {
    'cache-control': cacheControl,
    'set-cookie': setCookie,
    'date': date,
    'transfer-encoding': transferEncoding,
    'vary': vary,
    'content-type': contentType,
    'content-language': contentLanguage,
    'server': server,
    'password': password,
  };
}
