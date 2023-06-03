import 'package:fire_auth/models/product.dart';
import 'package:fire_auth/utils/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.item,
    this.onDeleteTap,
  }) : super(key: key);

  final Product item;
  final Function? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              item.images?[0] ?? "",
              fit: BoxFit.fitHeight,
              height: 80.h,
              width: 80.w,
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: AppColors.primaryColor.withOpacity(0.8),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "BDT ${item.price ?? 0}",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              onDeleteTap?.call();
            },
            icon: const Icon(
              Icons.delete_outline_outlined,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
