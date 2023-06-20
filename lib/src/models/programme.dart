class DayModel {
  final int id;
  final String title;
  final List<ProgrammeModel> programmes;

  const DayModel({ required this.id, required this.title, this.programmes = const [] });
}

class DayModelFactory {
  static DayModel fromJson(dynamic json) {
    return DayModel(
      id: json["id"],
      title: json["title"],
      programmes: ProgrammeModelFactory.fromJsonArr(json["programmes"])
    );
  }
}

class ProgrammeModel {
  final int id;
  final String title;
  final String description;
  final String time;

  const ProgrammeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
  });
}

class ProgrammeModelFactory {
  static ProgrammeModel fromJson(dynamic json) {
    return ProgrammeModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      time: json["time"]
    );
  }

  static List<ProgrammeModel> fromJsonArr(dynamic json) {
    return (json as List).map((e) => ProgrammeModelFactory.fromJson(e)).toList();
  }
}
