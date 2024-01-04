class Car {
  String? type;
  String? model;
  int? year;
  int? price;
  int? maximumSpeed;
  int? numOfSeats;
  double? fuelEfficiency;
  Car(
      {this.type,
      this.model,
      this.year,
      this.maximumSpeed,
      this.price,
      required this.numOfSeats,
      required this.fuelEfficiency});
  void carSpeed() {
    print("car speed = $maximumSpeed km/hr");
  }

  double calculateFuelEfficiency() => 0;
  double calculateDistanceTraveled() => 0;
}

class Truck extends Car {
  double _carGoCapacity = 0;
  double get carGoCapacity => _carGoCapacity;
  set carGoCapacity(double value) => _carGoCapacity = value;
  Truck(this._carGoCapacity, {required super.fuelEfficiency, required super.numOfSeats});
 @override
  double calculateFuelEfficiency() {
    return fuelEfficiency! * (1.0 / (1.0 + _carGoCapacity / 1000));
  }
  @override
  double calculateDistanceTraveled(){
    return calculateFuelEfficiency() * numOfSeats!;
  }
}

class Bus extends Truck {
  Bus(super.carGoCapacity, {required super.fuelEfficiency, required super.numOfSeats});

  @override
  double calculateFuelEfficiency() {
    return fuelEfficiency! * (1.0 / (1.0 + numOfSeats! / 5.0));
  }

  @override
  double calculateDistanceTraveled() {
    return calculateFuelEfficiency() * fuelEfficiency!;
  }
}

class MiniBus extends Bus {
  MiniBus(super.carGoCapacity, {required super.fuelEfficiency, required super.numOfSeats});
  @override
  double calculateFuelEfficiency() {
    return fuelEfficiency! * (1.0 / (1.0 + numOfSeats! / 10.0));
  }

  @override
  double calculateDistanceTraveled() {
    return calculateFuelEfficiency() * fuelEfficiency!;
  }
}


void main(List<String> arguments) {
  var toyota = Car(type: "a55",model: "2024", year: 2023, maximumSpeed: 150, numOfSeats: 7, fuelEfficiency: 50);
toyota.carSpeed();
var camry = Truck(20, fuelEfficiency: 50, numOfSeats: 5);
print(camry.calculateFuelEfficiency());
print (camry.calculateDistanceTraveled());
var toyotaBus = Bus(100, fuelEfficiency: 90, numOfSeats: 50);
print(toyotaBus.calculateDistanceTraveled());

var toyotaMiniBus = MiniBus(100, fuelEfficiency: 90, numOfSeats: 33);
print(toyotaMiniBus.calculateDistanceTraveled());
}
