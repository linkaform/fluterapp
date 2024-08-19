class EntryPass {
  final String? folio;
  final String? ubicacion;
  final String? nombre;
  final String? estatus;
  final String? email;
  final String? curp;
  final DateTime? fechaDeExpedicion;
  final DateTime? fechaDeCaducidad;
  final List<FileInfo>? foto;
  final List<FileInfo>? identificacion;
  final String? tipoDePase;
  final List<String>? visitaANombre;
  final List<String>? visitaAPuesto;
  final List<String>? visitaADepartamento;
  final List<String>? visitaAUserId;
  final List<String>? visitaAEmail;
  final List<String>? comentario;
  final String? id;
  final List<String>? visitaA;
  final List<String>? certificaciones;
  final List<String>? grupoAreasAcceso;
  final List<String>? grupoInstruccionesPase;
  final List<String>? grupoEquipos;
  final List<String>? grupoVehiculos;
  final List<String>? ultimoAcceso;
  final String? tipoMovimiento;

  EntryPass({
    this.folio,
    this.ubicacion,
    this.nombre,
    this.estatus,
    this.email,
    this.curp,
    this.fechaDeExpedicion,
    this.fechaDeCaducidad,
    this.foto,
    this.identificacion,
    this.tipoDePase,
    this.visitaANombre,
    this.visitaAPuesto,
    this.visitaADepartamento,
    this.visitaAUserId,
    this.visitaAEmail,
    this.comentario,
    this.id,
    this.visitaA,
    this.certificaciones,
    this.grupoAreasAcceso,
    this.grupoInstruccionesPase,
    this.grupoEquipos,
    this.grupoVehiculos,
    this.ultimoAcceso,
    this.tipoMovimiento,
  });

  factory EntryPass.fromJson(Map<String, dynamic> json) {
    return EntryPass(
      folio: json['folio'] as String?,
      ubicacion: json['ubicacion'] as String?,
      nombre: json['nombre'] as String?,
      estatus: json['estatus'] as String?,
      email: json['email'] as String?,
      curp: json['curp'] as String?,
      fechaDeExpedicion: json['fecha_de_expedicion'] != null
          ? DateTime.parse(json['fecha_de_expedicion'] as String)
          : null,
      fechaDeCaducidad: json['fecha_de_caducidad'] != null
          ? DateTime.parse(json['fecha_de_caducidad'] as String)
          : null,
      foto: (json['foto'] as List<dynamic>?)
          ?.map((e) => FileInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      identificacion: (json['identificacion'] as List<dynamic>?)
          ?.map((e) => FileInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      tipoDePase: json['tipo_de_pase'] as String?,
      visitaANombre: (json['visita_a_nombre'] as List<dynamic>?)?.cast<String>(),
      visitaAPuesto: (json['visita_a_puesto'] as List<dynamic>?)?.cast<String>(),
      visitaADepartamento: (json['visita_a_departamento'] as List<dynamic>?)?.cast<String>(),
      visitaAUserId: (json['visita_a_user_id'] as List<dynamic>?)?.cast<String>(),
      visitaAEmail: (json['visita_a_email'] as List<dynamic>?)?.cast<String>(),
      comentario: (json['comentario'] as List<dynamic>?)?.cast<String>(),
      id: json['_id'] as String?,
      visitaA: (json['visita_a'] as List<dynamic>?)?.cast<String>(),
      certificaciones: (json['certificaciones'] as List<dynamic>?)?.cast<String>(),
      grupoAreasAcceso: (json['grupo_areas_acceso'] as List<dynamic>?)?.cast<String>(),
      grupoInstruccionesPase: (json['grupo_instrucciones_pase'] as List<dynamic>?)?.cast<String>(),
      grupoEquipos: (json['grupo_equipos'] as List<dynamic>?)?.cast<String>(),
      grupoVehiculos: (json['grupo_vehiculos'] as List<dynamic>?)?.cast<String>(),
      ultimoAcceso: (json['ultimo_acceso'] as List<dynamic>?)?.cast<String>(),
      tipoMovimiento: json['tipo_movimiento'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'folio': folio,
      'ubicacion': ubicacion,
      'nombre': nombre,
      'estatus': estatus,
      'email': email,
      'curp': curp,
      'fecha_de_expedicion': fechaDeExpedicion?.toIso8601String(),
      'fecha_de_caducidad': fechaDeCaducidad?.toIso8601String(),
      'foto': foto?.map((e) => e.toJson()).toList(),
      'identificacion': identificacion?.map((e) => e.toJson()).toList(),
      'tipo_de_pase': tipoDePase,
      'visita_a_nombre': visitaANombre,
      'visita_a_puesto': visitaAPuesto,
      'visita_a_departamento': visitaADepartamento,
      'visita_a_user_id': visitaAUserId,
      'visita_a_email': visitaAEmail,
      'comentario': comentario,
      '_id': id,
      'visita_a': visitaA,
      'certificaciones': certificaciones,
      'grupo_areas_acceso': grupoAreasAcceso,
      'grupo_instrucciones_pase': grupoInstruccionesPase,
      'grupo_equipos': grupoEquipos,
      'grupo_vehiculos': grupoVehiculos,
      'ultimo_acceso': ultimoAcceso,
      'tipo_movimiento': tipoMovimiento,
    };
  }
}

class FileInfo {
  final String? fileName;
  final String? fileUrl;

  FileInfo({this.fileName, this.fileUrl});

  factory FileInfo.fromJson(Map<String, dynamic> json) {
    return FileInfo(
      fileName: json['file_name'] as String?,
      fileUrl: json['file_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file_name': fileName,
      'file_url': fileUrl,
    };
  }
}