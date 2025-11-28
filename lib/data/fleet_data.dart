import 'package:flutter/foundation.dart';

class DriverModel {
  final String id;
  final String name;
  final String imageAsset;

  const DriverModel({
    required this.id,
    required this.name,
    required this.imageAsset,
  });
}

class VehicleStateModel {
  final String id;
  final String title;
  final String imageAsset;

  const VehicleStateModel({
    required this.id,
    required this.title,
    required this.imageAsset,
  });
}

class VehicleModel {
  final String id;
  final String title;
  final String plate;
  final String imageAsset;
  final String? driverId;
  final String stateId;

  const VehicleModel({
    required this.id,
    required this.title,
    required this.plate,
    required this.imageAsset,
    required this.driverId,
    required this.stateId,
  });

  VehicleModel copyWith({
    String? title,
    String? plate,
    String? imageAsset,
    String? driverId,
    String? stateId,
  }) {
    return VehicleModel(
      id: id,
      title: title ?? this.title,
      plate: plate ?? this.plate,
      imageAsset: imageAsset ?? this.imageAsset,
      driverId: driverId ?? this.driverId,
      stateId: stateId ?? this.stateId,
    );
  }
}

class FleetStorage {
  FleetStorage._();

  static final List<DriverModel> _drivers = <DriverModel>[
    const DriverModel(
      id: 'driver_paul',
      name: 'Paul M.',
      imageAsset: 'assets/images/account_circle.svg',
    ),
    const DriverModel(
      id: 'driver_sarah',
      name: 'Sarah K.',
      imageAsset: 'assets/images/account_circle.svg',
    ),
    const DriverModel(
      id: 'driver_alex',
      name: 'Alex Q.',
      imageAsset: 'assets/images/account_circle.svg',
    ),
    const DriverModel(
      id: 'driver_maria',
      name: 'Maria D.',
      imageAsset: 'assets/images/account_circle.svg',
    ),
    const DriverModel(
      id: 'driver_lucas',
      name: 'Lucas R.',
      imageAsset: 'assets/images/account_circle.svg',
    ),
  ];

  static final ValueNotifier<List<DriverModel>> driversNotifier =
      ValueNotifier<List<DriverModel>>(List<DriverModel>.unmodifiable(_drivers));

  static List<DriverModel> get drivers => driversNotifier.value;

  static final List<VehicleStateModel> vehicleStates = <VehicleStateModel>[
    const VehicleStateModel(
      id: 'state_pickup',
      title: 'Pickup',
      imageAsset: 'assets/images/state_pickup.svg',
    ),
    const VehicleStateModel(
      id: 'state_delivery',
      title: 'Delivery',
      imageAsset: 'assets/images/state_delivery.svg',
    ),
    const VehicleStateModel(
      id: 'state_boarding',
      title: 'Boarding',
      imageAsset: 'assets/images/state_boarding.svg',
    ),
    const VehicleStateModel(
      id: 'state_unboarding',
      title: 'Unboarding',
      imageAsset: 'assets/images/state_unboarding.svg',
    ),
    const VehicleStateModel(
      id: 'state_load',
      title: 'Load',
      imageAsset: 'assets/images/state_load.svg',
    ),
    const VehicleStateModel(
      id: 'state_unload',
      title: 'Unload',
      imageAsset: 'assets/images/state_unload.svg',
    ),
    const VehicleStateModel(
      id: 'state_parking',
      title: 'Parking',
      imageAsset: 'assets/images/state_parking.svg',
    ),
    const VehicleStateModel(
      id: 'state_repair',
      title: 'Repair',
      imageAsset: 'assets/images/state_repair.svg',
    ),
  ];

  static final List<VehicleModel> _vehicles = <VehicleModel>[
    const VehicleModel(
      id: 'vehicle_car_1',
      title: 'BMW X5',
      plate: 'GS-7638',
      imageAsset: 'assets/images/vehicle_car.svg',
      driverId: 'driver_paul',
      stateId: 'state_pickup',
    ),
    const VehicleModel(
      id: 'vehicle_van_1',
      title: 'Mercedes Sprinter',
      plate: 'TR-2211',
      imageAsset: 'assets/images/vehicle_bus.svg',
      driverId: 'driver_sarah',
      stateId: 'state_boarding',
    ),
    const VehicleModel(
      id: 'vehicle_truck_1',
      title: 'MAN TGS',
      plate: 'TB-9982',
      imageAsset: 'assets/images/vehicle_truck.svg',
      driverId: 'driver_alex',
      stateId: 'state_load',
    ),
    const VehicleModel(
      id: 'vehicle_motorcycle_1',
      title: 'Honda CB500',
      plate: 'MC-5574',
      imageAsset: 'assets/images/vehicle_motorcycle.svg',
      driverId: 'driver_maria',
      stateId: 'state_delivery',
    ),
    const VehicleModel(
      id: 'vehicle_tuktuk_1',
      title: 'Bajaj RE',
      plate: 'TT-1042',
      imageAsset: 'assets/images/vehicle_tuktuk.svg',
      driverId: null,
      stateId: 'state_parking',
    ),
  ];

  static final ValueNotifier<List<VehicleModel>> vehiclesNotifier =
      ValueNotifier<List<VehicleModel>>(List<VehicleModel>.unmodifiable(_vehicles));

  static List<VehicleModel> get vehicles => vehiclesNotifier.value;

  static final Map<String, DriverModel> _driversById = Map<String, DriverModel>.fromEntries(
    _drivers.map((DriverModel driver) => MapEntry<String, DriverModel>(driver.id, driver)),
  );

  static final Map<String, VehicleStateModel> _statesById =
      Map<String, VehicleStateModel>.fromEntries(
    vehicleStates
        .map((VehicleStateModel state) => MapEntry<String, VehicleStateModel>(state.id, state)),
  );

  static DriverModel? driverById(String? id) {
    if (id == null) {
      return null;
    }
    return _driversById[id];
  }

  static VehicleStateModel stateById(String id) {
    return _statesById[id] ?? vehicleStates.first;
  }

  static void updateVehicleDriver({
    required String vehicleId,
    required String? driverId,
  }) {
    final int index = _vehicles.indexWhere((VehicleModel vehicle) => vehicle.id == vehicleId);
    if (index < 0) {
      return;
    }
    _vehicles[index] = _vehicles[index].copyWith(driverId: driverId);
    _emitVehicles();
  }

  static void updateVehicleState({
    required String vehicleId,
    required String stateId,
  }) {
    final int index = _vehicles.indexWhere((VehicleModel vehicle) => vehicle.id == vehicleId);
    if (index < 0) {
      return;
    }
    _vehicles[index] = _vehicles[index].copyWith(stateId: stateId);
    _emitVehicles();
  }

  static void addVehicle({
    required String title,
    required String plate,
    String? imageAsset,
  }) {
    final VehicleModel vehicle = VehicleModel(
      id: 'vehicle_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      plate: plate,
      imageAsset: imageAsset ?? 'assets/images/vehicle_car.svg',
      driverId: null,
      stateId: vehicleStates.first.id,
    );
    _vehicles.add(vehicle);
    _emitVehicles();
  }

  static void removeVehicle({required String vehicleId}) {
    _vehicles.removeWhere((VehicleModel vehicle) => vehicle.id == vehicleId);
    _emitVehicles();
  }

  static void _emitVehicles() {
    vehiclesNotifier.value = List<VehicleModel>.unmodifiable(_vehicles);
  }

  static void _emitDrivers() {
    driversNotifier.value = List<DriverModel>.unmodifiable(_drivers);
  }

  static void addDriver({required String name}) {
    final DriverModel driver = DriverModel(
      id: 'driver_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      imageAsset: 'assets/images/account_circle.svg',
    );
    _drivers.add(driver);
    _driversById[driver.id] = driver;
    _emitDrivers();
  }

  static Future<void> refreshVehicles() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    _emitVehicles();
  }
}

