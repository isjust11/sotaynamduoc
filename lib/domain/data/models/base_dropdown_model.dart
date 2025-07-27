import 'package:equatable/equatable.dart';

class BaseDropdownModel extends Equatable {
  final dynamic id;
  final dynamic name;

  const BaseDropdownModel({this.id, this.name});

  @override
  List<Object?> get props => [id];
}
