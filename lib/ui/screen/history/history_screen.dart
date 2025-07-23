import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/ui/widget/base_text_input.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/i18n/generated_locales/l10n.dart';
import '../../../res/colors.dart';
import '../../widget/base_appbar.dart';
import '../../widget/base_screen.dart';
import '../../widget/custom_text_label.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  final List<Product> products = const [
    Product(
      imageUrl: 'https://picsum.photos/200',
      name: 'Sữa tươi nguyên chất TH không đường - dung tích 1L',
      company: 'Công ty cổ phần sữa TH true milk',
      date: '15/12/2025 09:55',
      status: ProductStatus.identified,
    ),
    Product(
      imageUrl: 'https://picsum.photos/200',
      name: 'Sữa tươi nguyên chất TH không đường - dung tích 1L',
      company: 'Công ty cổ phần sữa TH true milk',
      date: '15/12/2025 09:55',
      status: ProductStatus.notIdentified,
    ),
    Product(
      imageUrl: 'https://picsum.photos/200',
      name: 'Không có thông tin',
      company: 'Không có thông tin',
      date: '15/12/2025 09:55',
      status: ProductStatus.notIdentified,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hiddenIconBack: true,
      hideAppBar: false,
      customAppBar: BaseAppBar(title: AppLocalizations.current.history, showBackButton: false),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
            child: CustomTextInput(
              hintText: "Tìm kiếm",
              hintTextColor: AppColors.textHintGrey,
              hintTextFontWeight: FontWeight.w400,
              hintTextFontSize: 16.sw,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SvgPicture.asset(Assets.images.icSearch)
              ),
              // borderRadius: 12,
              // onChanged: (value) {
              //   // Handle search logic here
              // },
            ),
            // child: TextField(
            //   decoration: InputDecoration(
            //     hintText: 'Tìm kiếm',
            //     prefixIcon: const Icon(Icons.search),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            // ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum ProductStatus { identified, notIdentified }

class Product {
  final String imageUrl;
  final String name;
  final String company;
  final String date;
  final ProductStatus status;

  const Product({
    required this.imageUrl,
    required this.name,
    required this.company,
    required this.date,
    required this.status,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isIdentified = product.status == ProductStatus.identified;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.transparentOrangeOverlay,
        borderRadius: BorderRadius.circular(14.sw),
        border: Border.all(color: AppColors.primaryBrand, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              width: 60,
              height: 60,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(product.company),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 6),
                      Text(product.date),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isIdentified
                        ? 'Sản phẩm đã định danh'
                        : 'Sản phẩm không có định danh',
                    style: TextStyle(
                      color: isIdentified ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const Icon(Icons.more_horiz),
          ],
        ),
      ),
    );
  }
}

