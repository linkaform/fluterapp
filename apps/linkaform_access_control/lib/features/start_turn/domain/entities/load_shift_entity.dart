class LoadShiftEntity {
  final LoadShiftData? data; // Nullable
  final bool? success; // Nullable
  final String? log; // Nullable

  LoadShiftEntity({
    this.data,
    this.success,
    this.log,
  });

  factory LoadShiftEntity.fromJson(Map<String, dynamic> json) {
    return LoadShiftEntity(
      data: json.containsKey('response')
          ? LoadShiftData.fromJson(
        (json['response'] as Map<String, dynamic>).values.first
        as Map<String, dynamic>,
      )
          : null,
      success: json.containsKey('success') ? json['success'] as bool : null,
      log: json.containsKey('log') ? json['log'] as String : null,
    );
  }

  Map<String, dynamic> toJson() => {
    if (data != null) 'response': data!.toJson(),
    if (success != null) 'success': success,
    if (log != null) 'log': log,
  };
}
class LoadShiftData {
  final List<SupportGuard>? supportGuards; // Nullable
  final BoothStatus? boothStatus; // Nullable
  final BoothStats? boothStats; // Nullable
  final List<Note>? notes; // Nullable
  final List<dynamic>? userBooths; // Nullable
  final Guard? guard; // Nullable
  final Location? location; // Nullable

  LoadShiftData({
    this.supportGuards,
    this.boothStatus,
    this.boothStats,
    this.notes,
    this.userBooths,
    this.guard,
    this.location,
  });

  factory LoadShiftData.fromJson(Map<String, dynamic> json) => LoadShiftData(
    supportGuards: json.containsKey('support_guards')
        ? List<SupportGuard>.from((json['support_guards'] as List)
        .map((x) => SupportGuard.fromJson(x as Map<String, dynamic>)))
        : null,
    boothStatus: json.containsKey('booth_status')
        ? BoothStatus.fromJson(json['booth_status'] as Map<String, dynamic>)
        : null,
    boothStats: json.containsKey('booth_stats')
        ? BoothStats.fromJson(json['booth_stats'] as Map<String, dynamic>)
        : null,
    notes: json.containsKey('notes')
        ? List<Note>.from((json['notes'] as List)
        .map((x) => Note.fromJson(x as Map<String, dynamic>)))
        : null,
    userBooths: json.containsKey('user_booths')
        ? List<dynamic>.from(json['user_booths'] as List)
        : null,
    guard: json.containsKey('guard')
        ? Guard.fromJson(json['guard'] as Map<String, dynamic>)
        : null,
    location: json.containsKey('location')
        ? Location.fromJson(json['location'] as Map<String, dynamic>)
        : null,
  );

  Map<String, dynamic> toJson() => {
    if (supportGuards != null)
      'support_guards': List<dynamic>.from(supportGuards!.map((x) => x.toJson())),
    if (boothStatus != null) 'booth_status': boothStatus!.toJson(),
    if (boothStats != null) 'booth_stats': boothStats!.toJson(),
    if (notes != null) 'notes': List<dynamic>.from(notes!.map((x) => x.toJson())),
    if (userBooths != null)
      'user_booths': List<dynamic>.from(userBooths!.map((x) => x)),
    if (guard != null) 'guard': guard!.toJson(),
    if (location != null) 'location': location!.toJson(),
  };
}


class BoothStats {
  final int? gefetesPendientes; // Nullable
  final int? articulosConcesionados; // Nullable
  final int? inInvitees; // Nullable
  final int? incidentesPendites; // Nullable
  final int? vehiculosEstacionados; // Nullable

  BoothStats({
    this.gefetesPendientes,
    this.articulosConcesionados,
    this.inInvitees,
    this.incidentesPendites,
    this.vehiculosEstacionados,
  });

  factory BoothStats.fromJson(Map<String, dynamic> json) => BoothStats(
    gefetesPendientes: json.containsKey('gefetes_pendientes')
        ? json['gefetes_pendientes'] as int
        : null,
    articulosConcesionados: json.containsKey('articulos_concesionados')
        ? json['articulos_concesionados'] as int
        : null,
    inInvitees: json.containsKey('in_invitees')
        ? json['in_invitees'] as int
        : null,
    incidentesPendites: json.containsKey('incidentes_pendites')
        ? json['incidentes_pendites'] as int
        : null,
    vehiculosEstacionados: json.containsKey('vehiculos_estacionados')
        ? json['vehiculos_estacionados'] as int
        : null,
  );

  Map<String, dynamic> toJson() => {
    if (gefetesPendientes != null) 'gefetes_pendientes': gefetesPendientes,
    if (articulosConcesionados != null)
      'articulos_concesionados': articulosConcesionados,
    if (inInvitees != null) 'in_invitees': inInvitees,
    if (incidentesPendites != null)
      'incidentes_pendites': incidentesPendites,
    if (vehiculosEstacionados != null)
      'vehiculos_estacionados': vehiculosEstacionados,
  };
}

class BoothStatus {
  String? status;
  String? userId;
  String? statedAt;
  String? guardOnDutty;
  String? checkinId;

  BoothStatus({
    this.status,
    this.userId,
    this.statedAt,
    this.guardOnDutty,
    this.checkinId,
  });

  factory BoothStatus.fromJson(Map<String, dynamic> json) => BoothStatus(
    status: json.containsKey('status') ? json['status'] as String : null,
    userId: json.containsKey('user_id') ? json['user_id'] as String : null,
    statedAt: json.containsKey('stated_at') ? json['stated_at'] as String : null,
    guardOnDutty: json.containsKey('guard_on_dutty') ? json['guard_on_dutty'] as String : null,
    checkinId: json.containsKey('checkin_id') ? json['checkin_id'] as String : null,
  );

  Map<String, dynamic> toJson() => {
    if (status != null) 'status': status,
    if (userId != null) 'user_id': userId,
    if (statedAt != null) 'stated_at': statedAt,
    if (guardOnDutty != null) 'guard_on_dutty': guardOnDutty,
    if (checkinId != null) 'checkin_id': checkinId,
  };
}

class Guard {
  String? status; // Nullable
  final Picture? picture; // Nullable
  final int? userId; // Nullable
  final String? name; // Nullable
  final String? area; // Nullable
  final String? checkinPosition; // Nullable
  final String? statusTurn; // Nullable
  final String? location; // Nullable
  final DateTime? checkinDate; // Nullable
  final dynamic checkoutDate; // Nullable (mantener como dynamic)
  final DateTime? turnStartDatetime; // Nullable

  Guard({
    this.status,
    this.picture,
    this.userId,
    this.name,
    this.area,
    this.checkinPosition,
    this.statusTurn,
    this.location,
    this.checkinDate,
    this.checkoutDate,
    this.turnStartDatetime,
  });

  factory Guard.fromJson(Map<String, dynamic> json) => Guard(
    status: json.containsKey('status') ? json['status'] as String : null,
    picture: json.containsKey('picture')
        ? Picture.fromJson(json['picture'] as Map<String, dynamic>)
        : null,
    userId: json.containsKey('user_id') ? json['user_id'] as int : null,
    name: json.containsKey('name') ? json['name'] as String : null,
    area: json.containsKey('area') ? json['area'] as String : null,
    checkinPosition: json.containsKey('checkin_position') ? json['checkin_position'] as String : null,
    statusTurn: json.containsKey('status_turn') ? json['status_turn'] as String : null,
    location: json.containsKey('location') ? json['location'] as String : null,
    checkinDate: json.containsKey('checkin_date')
        ? DateTime.parse(json['checkin_date'] as String)
        : null,
    checkoutDate: json['checkout_date'], // Puede ser nulo, así que no lo casteamos
    turnStartDatetime: json.containsKey('turn_start_datetime')
        ? DateTime.parse(json['turn_start_datetime'] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
    if (status != null) 'status': status,
    if (picture != null) 'picture': picture!.toJson(),
    if (userId != null) 'user_id': userId,
    if (name != null) 'name': name,
    if (area != null) 'area': area,
    if (checkinPosition != null) 'checkin_position': checkinPosition,
    if (statusTurn != null) 'status_turn': statusTurn,
    if (location != null) 'location': location,
    if (checkinDate != null) 'checkin_date': checkinDate!.toIso8601String(),
    if (checkoutDate != null) 'checkout_date': checkoutDate,
    if (turnStartDatetime != null)
      'turn_start_datetime': turnStartDatetime!.toIso8601String(),
  };
}

class Location {
  final String? city; // Nullable
  final String? state; // Nullable
  final String? address; // Nullable
  final String? name; // Nullable
  final String? area; // Nullable

  Location({
    this.city,
    this.state,
    this.address,
    this.name,
    this.area,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    city: json.containsKey('city') ? json['city'] as String : null,
    state: json.containsKey('state') ? json['state'] as String : null,
    address: json.containsKey('address') ? json['address'] as String : null,
    name: json.containsKey('name') ? json['name'] as String : null,
    area: json.containsKey('area') ? json['area'] as String : null,
  );

  Map<String, dynamic> toJson() => {
    if (city != null) 'city': city,
    if (state != null) 'state': state,
    if (address != null) 'address': address,
    if (name != null) 'name': name,
    if (area != null) 'area': area,
  };
}

class Note {
  final String? id;
  final String? folio;
  final String? createdByName;
  final int? createdById;
  final String? createdByEmail;
  final String? noteStatus;
  final DateTime? noteOpenDate;
  final String? note;
  final List<NoteFile>? noteFile;
  final List<NotePic>? notePic;
  final List<NoteComment>? noteComments;

  Note({
    this.id,
    this.folio,
    this.createdByName,
    this.createdById,
    this.createdByEmail,
    this.noteStatus,
    this.noteOpenDate,
    this.note,
    this.noteFile,
    this.notePic,
    this.noteComments,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json.containsKey('_id') ? json['_id'] as String : null,
    folio: json.containsKey('folio') ? json['folio'] as String : null,
    createdByName: json.containsKey('created_by_name') ? json['created_by_name'] as String : null,
    createdById: json.containsKey('created_by_id') ? json['created_by_id'] as int : null,
    createdByEmail: json.containsKey('created_by_email') ? json['created_by_email'] as String : null,
    noteStatus: json.containsKey('note_status') ? json['note_status'] as String : null,
    noteOpenDate: json.containsKey('note_open_date') ? DateTime.parse(json['note_open_date'] as String) : null,
    note: json.containsKey('note') ? json['note'] as String : null,
    noteFile: json.containsKey('note_file')
        ? List<NoteFile>.from((json['note_file'] as List)
        .map((x) => NoteFile.fromJson(x as Map<String, dynamic>)))
        : null,
    notePic: json.containsKey('note_pic')
        ? List<NotePic>.from((json['note_pic'] as List)
        .map((x) => NotePic.fromJson(x as Map<String, dynamic>)))
        : null,
    noteComments: json.containsKey('note_comments')
        ? List<NoteComment>.from((json['note_comments'] as List)
        .map((x) => NoteComment.fromJson(x as Map<String, dynamic>)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    if (id != null) '_id': id,
    if (folio != null) 'folio': folio,
    if (createdByName != null) 'created_by_name': createdByName,
    if (createdById != null) 'created_by_id': createdById,
    if (createdByEmail != null) 'created_by_email': createdByEmail,
    if (noteStatus != null) 'note_status': noteStatus,
    if (noteOpenDate != null) 'note_open_date': noteOpenDate!.toIso8601String(),
    if (note != null) 'note': note,
    if (noteFile != null) 'note_file': List<dynamic>.from(noteFile!.map((x) => x.toJson())),
    if (notePic != null) 'note_pic': List<dynamic>.from(notePic!.map((x) => x.toJson())),
    if (noteComments != null) 'note_comments': List<dynamic>.from(noteComments!.map((x) => x.toJson())),
  };
}

class SupportGuard {
  String? status;
  final Picture? picture;
  final int? userId;
  final String? name;
  final String? area;
  String? checkinPosition;
  final String? statusTurn;
  final String? location;
  DateTime? checkinDate;
  final dynamic checkoutDate;
  final bool isSelected;

  SupportGuard({
    this.status,
    this.picture,
    this.userId,
    this.name,
    this.area,
    this.checkinPosition,
    this.statusTurn,
    this.location,
    this.checkinDate,
    this.checkoutDate,
    this.isSelected = false,
  });

  factory SupportGuard.fromJson(Map<String, dynamic> json) => SupportGuard(
    status: json.containsKey('status') ? json['status'] as String : null,
    picture: json.containsKey('picture')
        ? Picture.fromJson(json['picture'] as Map<String, dynamic>)
        : null,
    userId: json.containsKey('user_id') ? json['user_id'] as int : null,
    name: json.containsKey('name') ? json['name'] as String : null,
    area: json.containsKey('area') ? json['area'] as String : null,
    checkinPosition: json.containsKey('checkin_position') ? json['checkin_position'] as String : null,
    statusTurn: json.containsKey('status_turn') ? json['status_turn'] as String : null,
    location: json.containsKey('location') ? json['location'] as String : null,
    checkinDate: json.containsKey('checkin_date')
        ? DateTime.parse(json['checkin_date'] as String)
        : null,
    checkoutDate: json['checkout_date'],
  );

  Map<String, dynamic> toJson() => {
    if (status != null) 'status': status,
    if (picture != null) 'picture': picture!.toJson(),
    if (userId != null) 'user_id': userId,
    if (name != null) 'name': name,
    if (area != null) 'area': area,
    if (checkinPosition != null) 'checkin_position': checkinPosition,
    if (statusTurn != null) 'status_turn': statusTurn,
    if (location != null) 'location': location,
    if (checkinDate != null) 'checkin_date': checkinDate!.toIso8601String(),
    if (checkoutDate != null) 'checkout_date': checkoutDate,
  };

  SupportGuard copyWith({String? status, bool? isSelected}) {
    return SupportGuard(
      status: status ?? this.status,
      picture: picture,
      userId: userId,
      name: name,
      area: area,
      checkinPosition: checkinPosition,
      statusTurn: statusTurn,
      location: location,
      checkinDate: checkinDate,
      checkoutDate: checkoutDate,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class Picture {
  final String? fileName;
  final String? fileUrl;

  Picture({
    this.fileName,
    this.fileUrl,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    fileName: json.containsKey('file_name') ? json['file_name'] as String : null,
    fileUrl: json.containsKey('file_url') ? json['file_url'] as String : null,
  );

  Map<String, dynamic> toJson() => {
    if (fileName != null) 'file_name': fileName,
    if (fileUrl != null) 'file_url': fileUrl,
  };
}

class NoteFile {
  final String? fileName;
  final String? fileUrl;

  NoteFile({
    this.fileName,
    this.fileUrl,
  });

  factory NoteFile.fromJson(Map<String, dynamic> json) => NoteFile(
    fileName: json.containsKey('file_name') ? json['file_name'] as String : null,
    fileUrl: json.containsKey('file_url') ? json['file_url'] as String : null,
  );

  Map<String, dynamic> toJson() => {
    if (fileName != null) 'file_name': fileName,
    if (fileUrl != null) 'file_url': fileUrl,
  };
}

class NotePic {
  final String? fileName;
  final String? fileUrl;

  NotePic({
    this.fileName,
    this.fileUrl,
  });

  factory NotePic.fromJson(Map<String, dynamic> json) => NotePic(
    fileName: json.containsKey('file_name') ? json['file_name'] as String : null,
    fileUrl: json.containsKey('file_url') ? json['file_url'] as String : null,
  );

  Map<String, dynamic> toJson() => {
    if (fileName != null) 'file_name': fileName,
    if (fileUrl != null) 'file_url': fileUrl,
  };
}

// Clase para NoteComment (utilizada en Note)
class NoteComment {
  final Map<String, dynamic>? commentData; // Nullable

  NoteComment({this.commentData});

  factory NoteComment.fromJson(Map<String, dynamic> json) => NoteComment(
    commentData: json, // No es necesario verificar la clave aquí, ya que es el propio JSON
  );

  Map<String, dynamic> toJson() => commentData ?? {}; // Manejar el caso nulo
}