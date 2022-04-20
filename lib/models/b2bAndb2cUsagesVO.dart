class B2BAndB2CUsagesVo {
  String? status;
  String? responseCode;
  String? description;
  bool? isRequieredUpdate;
  bool? isforceUpdate;
  Details? details;

  B2BAndB2CUsagesVo(
      {this.status,
        this.responseCode,
        this.description,
        this.isRequieredUpdate,
        this.isforceUpdate,
        this.details});

  B2BAndB2CUsagesVo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    description = json['description'];
    isRequieredUpdate = json['is_requiered_update'];
    isforceUpdate = json['isforce_update'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response_code'] = this.responseCode;
    data['description'] = this.description;
    data['is_requiered_update'] = this.isRequieredUpdate;
    data['isforce_update'] = this.isforceUpdate;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
  List<CableType>? cableType;
  List<JointClosure>? jointClosure;
  List<ODB>? oDB;
  List<ONU>? oNU;
  List<Cat6Cable>? cat6Cable;
  List<RJ45Connector>? rJ45Connector;
  List<PatchCord>? patchCord;
  List<MediaConverter>? mediaConverter;
  List<SPFModule>? sPFModule;
  List<SCConnector>? sCConnector;
  List<Router>? router;
  List<Sleeves>? sleeves;

  Details(
      {this.cableType,
        this.jointClosure,
        this.oDB,
        this.oNU,
        this.cat6Cable,
        this.rJ45Connector,
        this.patchCord,
        this.mediaConverter,
        this.sPFModule,
        this.sCConnector,
        this.router,
      this.sleeves});

  Details.fromJson(Map<String, dynamic> json) {
    if (json['Cable Type'] != null) {
      cableType = <CableType>[];
      json['Cable Type'].forEach((v) {
        cableType!.add(new CableType.fromJson(v));
      });
    }
    if (json['Joint Closure'] != null) {
      jointClosure = <JointClosure>[];
      json['Joint Closure'].forEach((v) {
        jointClosure!.add(new JointClosure.fromJson(v));
      });
    }
    if (json['ODB'] != null) {
      oDB = <ODB>[];
      json['ODB'].forEach((v) {
        oDB!.add(new ODB.fromJson(v));
      });
    }
    if (json['ONU'] != null) {
      oNU = <ONU>[];
      json['ONU'].forEach((v) {
        oNU!.add(new ONU.fromJson(v));
      });
    }
    if (json['Cat 6 Cable'] != null) {
      cat6Cable = <Cat6Cable>[];
      json['Cat 6 Cable'].forEach((v) {
        cat6Cable!.add(new Cat6Cable.fromJson(v));
      });
    }
    if (json['RJ-45 Connector'] != null) {
      rJ45Connector = <RJ45Connector>[];
      json['RJ-45 Connector'].forEach((v) {
        rJ45Connector!.add(new RJ45Connector.fromJson(v));
      });
    }
    if (json['Patch Cord'] != null) {
      patchCord = <PatchCord>[];
      json['Patch Cord'].forEach((v) {
        patchCord!.add(new PatchCord.fromJson(v));
      });
    }
    if (json['Media Converter'] != null) {
      mediaConverter = <MediaConverter>[];
      json['Media Converter'].forEach((v) {
        mediaConverter!.add(new MediaConverter.fromJson(v));
      });
    }
    if (json['SPF Module'] != null) {
      sPFModule = <SPFModule>[];
      json['SPF Module'].forEach((v) {
        sPFModule!.add(new SPFModule.fromJson(v));
      });
    }
    if (json['SC Connector'] != null) {
      sCConnector = <SCConnector>[];
      json['SC Connector'].forEach((v) {
        sCConnector!.add(new SCConnector.fromJson(v));
      });
    }
    if (json['Router'] != null) {
      router = <Router>[];
      json['Router'].forEach((v) {
        router!.add(new Router.fromJson(v));
      });
    }

    if (json['Sleeves'] != null) {
      sleeves = <Sleeves>[];
      json['Sleeves'].forEach((v) {
        sleeves!.add(new Sleeves.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cableType != null) {
      data['Cable Type'] = this.cableType!.map((v) => v.toJson()).toList();
    }
    if (this.jointClosure != null) {
      data['Joint Closure'] =
          this.jointClosure!.map((v) => v.toJson()).toList();
    }
    if (this.oDB != null) {
      data['ODB'] = this.oDB!.map((v) => v.toJson()).toList();
    }
    if (this.oNU != null) {
      data['ONU'] = this.oNU!.map((v) => v.toJson()).toList();
    }
    if (this.cat6Cable != null) {
      data['Cat 6 Cable'] = this.cat6Cable!.map((v) => v.toJson()).toList();
    }
    if (this.rJ45Connector != null) {
      data['RJ-45 Connector'] =
          this.rJ45Connector!.map((v) => v.toJson()).toList();
    }
    if (this.patchCord != null) {
      data['Patch Cord'] = this.patchCord!.map((v) => v.toJson()).toList();
    }
    if (this.mediaConverter != null) {
      data['Media Converter'] =
          this.mediaConverter!.map((v) => v.toJson()).toList();
    }
    if (this.sPFModule != null) {
      data['SPF Module'] = this.sPFModule!.map((v) => v.toJson()).toList();
    }
    if (this.sCConnector != null) {
      data['SC Connector'] = this.sCConnector!.map((v) => v.toJson()).toList();
    }
    if (this.router != null) {
      data['Router'] = this.router!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Router {
  String? id;
  String? name;

  Router({this.id, this.name});

  Router.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class SCConnector {
  String? id;
  String? name;

  SCConnector({this.id, this.name});

  SCConnector.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}


class SPFModule {
  String? id;
  String? name;

  SPFModule({this.id, this.name});

  SPFModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class MediaConverter {
  String? id;
  String? name;

  MediaConverter({this.id, this.name});

  MediaConverter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class PatchCord {
  String? id;
  String? name;

  PatchCord({this.id, this.name});

  PatchCord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class RJ45Connector {
  String? id;
  String? name;

  RJ45Connector({this.id, this.name});

  RJ45Connector.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Cat6Cable {
  String? id;
  String? name;

  Cat6Cable({this.id, this.name});

  Cat6Cable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ODB {
  String? id;
  String? name;

  ODB({this.id, this.name});

  ODB.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ONU {
  String? id;
  String? name;

  ONU({this.id, this.name});

  ONU.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class JointClosure {
  String? id;
  String? name;

  JointClosure({this.id, this.name});

  JointClosure.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class CableType {
  String? id;
  String? name;

  CableType({this.id, this.name});

  CableType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

  class Sleeves {
  String? id;
  String? name;

  Sleeves({this.id, this.name});

  Sleeves.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  name = json['name'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['name'] = this.name;
  return data;
  }
}
