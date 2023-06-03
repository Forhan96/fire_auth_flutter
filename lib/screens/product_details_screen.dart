import 'package:fire_auth/components/default_button.dart';
import 'package:fire_auth/models/product.dart';
import 'package:fire_auth/providers/checout_provider.dart';
import 'package:fire_auth/providers/home_provider.dart';
import 'package:fire_auth/utils/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:fire_auth/router/routes.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.item}) : super(key: key);
  final Product item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: ListView(
          children: [
            Image.network(
              item.images?[0] ?? "",
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: AppColors.primaryColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                      Text(
                        "BDT ${item.price ?? 0}",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: AppColors.primaryColor.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Brand :",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            item.brand ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: AppColors.primaryColor.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            " ${item.rating ?? 0}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: AppColors.primaryColor.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.description ?? "",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  DefaultButton(
                    text: "Add To Cart",
                    onPressed: () {
                      CheckoutProvider _checkoutProvider = Provider.of<CheckoutProvider>(context, listen: false);
                      _checkoutProvider.addItemToCart(item);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          color: AppColors.primaryColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        "Details",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.cartScreen);
          },
        ),
      ],
    );
  }
}
