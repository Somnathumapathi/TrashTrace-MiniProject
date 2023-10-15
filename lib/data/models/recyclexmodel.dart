class RCXPartner {
  final int id;
  final String name;
  final String type;
  final String imagePath;
  final String contact;

  RCXPartner({
    required this.id,
    required this.name,
    required this.type,
    required this.imagePath,
    required this.contact,
  });
}

class ReCyclXJob {
  final int id;
  final String name;
  final String partnerName;
  final String partnerType;
  final String status;
  final String date;

  ReCyclXJob(
    this.id,
    this.name,
    this.partnerName,
    this.partnerType,
    this.status,
    this.date,
  );

  factory ReCyclXJob.fromMap(Map x) {
    return ReCyclXJob(
      0,
      x['name'],
      x['partner']['name'],
      x['partner']['type'],
      x['status'],
      x['date'],
    );
  }
}
