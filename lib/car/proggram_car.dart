
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
final cars = [
  'Ferrari',
  'Lamborghini',
  'BMW',
  'Mercedes',
  'Toyota Supra',
  'Aston Martin',
  'Abir',
  "pritu",
  "Sara",
  "Mariya"
];

class Bike {
  final String name;
  final int horsepower;

  const Bike({
    @required this.name,
    @required this.horsepower,
  });
}

List<Bike> bikes = [
  Bike(name: 'Kawasaki', horsepower: 310),
  Bike(name: 'Honda', horsepower: 210),
  Bike(name: 'Suzuki', horsepower: 250),
  Bike(name: 'BMW', horsepower: 400),
  Bike(name: 'Harley Davidson', horsepower: 350),
  Bike(name: 'Yamaha', horsepower: 450),
  Bike(name: 'Hayabusa', horsepower: 500),
];