class JsonPlan {
  late final String? refval;
  late final String? uprn;
  late final String? address;
  late final String? addressline;
  late final String? addressSearch;
  late final String? altref;
  late final String? proposal;
  late final String? pending;
  late final double specialinterest;
  late final String? dcapptyp;
  late final String? dcapptypText;
  late final String? dcstat;
  late final String? dcstatText;
  late final String? apstatText;
  late final String? wardText;
  late final String? parishText;
  late final DateTime dateaprecv;
  late final DateTime dateapval;
  late final DateTime? dateactcom;
  late final DateTime? datedeciss;
  late final DateTime? datedecisn;
  late final DateTime? daplstart;
  late final DateTime? dateappdec;
  late final DateTime? dateclosedorissued;
  late final double latitude;
  late final double longitude;
  late final DateTime isharedate;


  JsonPlan(
      this.refval,
      this.uprn,
      this.address,
      this.addressline,
      this.addressSearch,
      this.altref,
      this.proposal,
      this.pending,
      this.specialinterest,
      this.dcapptyp,
      this.dcapptypText,
      this.dcstat,
      this.dcstatText,
      this.apstatText,
      this.wardText,
      this.parishText,
      this.dateaprecv,
      this.dateapval,
      this.dateactcom,
      this.datedeciss,
      this.datedecisn,
      this.daplstart,
      this.dateappdec,
      this.dateclosedorissued,
      this.latitude,
      this.longitude,
      this.isharedate);

  // Factory method to create an instance from JSON
  factory JsonPlan.fromJson(Map<String, dynamic> json) {
    return JsonPlan(
      json['refval'],
      json['uprn'],
      json['address'],
      json['addressline'],
      json['addressSearch'],
      json['altref'],
      json['proposal'],
      json['pending'],
      (json['specialinterest'] as num).toDouble(),
      json['dcapptyp'],
      json['dcapptyp_text'],
      json['dcstat'],
      json['dcstat_text'],
      json['apstat_text'],
      json['ward_text'],
      json['parish_text'],
      DateTime.parse(json['dateaprecv']??"2002-11-03"),
      DateTime.parse(json['dateapval']??"2002-11-03"),
      json['dateactcom'] != null ? DateTime.parse(json['dateactcom']) : null,
      json['datedeciss'] != null ? DateTime.parse(json['datedeciss']) : null,
      json['datedecisn'] != null ? DateTime.parse(json['datedecisn']) : null,
      json['daplstart'] != null ? DateTime.parse(json['daplstart']) : null,
      json['dateappdec'] != null ? DateTime.parse(json['dateappdec']) : null,
      json['dateclosedorissued'] != null ? DateTime.parse(json['dateclosedorissued']) : null,
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
      DateTime.parse(json['isharedate']),
    );
  }

  // Convert a Dart object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'refval': refval,
      'uprn': uprn,
      'address': address,
      'addressline': addressline,
      'addressSearch': addressSearch,
      'altref': altref,
      'proposal': proposal,
      'pending': pending,
      'specialinterest': specialinterest,
      'dcapptyp': dcapptyp,
      'dcapptyp_text': dcapptypText,
      'dcstat': dcstat,
      'dcstat_text': dcstatText,
      'apstat_text': apstatText,
      'ward_text': wardText,
      'parish_text': parishText,
      'dateaprecv': dateaprecv.toIso8601String(),
      'dateapval': dateapval.toIso8601String(),
      'dateactcom': dateactcom?.toIso8601String(),
      'datedeciss': datedeciss?.toIso8601String(),
      'datedecisn': datedecisn?.toIso8601String(),
      'daplstart': daplstart?.toIso8601String(),
      'dateappdec': dateappdec?.toIso8601String(),
      'dateclosedorissued': dateclosedorissued?.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'isharedate': isharedate.toIso8601String(),
    };
  }
}
