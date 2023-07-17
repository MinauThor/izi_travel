class Departure {
  String? depart;
  int? price;
  int? seat;

  Departure();

  Map<String, dynamic> toJson() => {'depart': depart, 'price': price, 'seat': seat};

  Departure.fromSnapshot(snapshot)
    : depart = snapshot.data()['depart'],
      price = snapshot.data()['price'].toInt,
      seat = snapshot.data()['seat'].toInt;
}