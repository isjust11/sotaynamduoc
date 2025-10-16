import 'package:flutter/material.dart';
import 'package:sotaynamduoc/domain/data/models/folk_medicine_model.dart';
import 'package:sotaynamduoc/ui/screen/screen.dart';
import 'package:sotaynamduoc/ui/widget/base_screen.dart';

class FolkMedicineDetailScreen extends StatelessWidget {
  final FolkMedicineModel folkMedicine;
  const FolkMedicineDetailScreen({super.key, required this.folkMedicine});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      onBackPress: () => Navigator.pop(context),
      hideAppBar: true,
      body: FolkMedicineDetailBodyScreen(folkMedicine: folkMedicine),
    );
  }
}
