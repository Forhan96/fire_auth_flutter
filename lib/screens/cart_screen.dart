import 'package:fire_auth/components/cart_item.dart';
import 'package:fire_auth/components/default_button.dart';
import 'package:fire_auth/models/product.dart';
import 'package:fire_auth/providers/checout_provider.dart';
import 'package:fire_auth/router/routes.dart';
import 'package:fire_auth/utils/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutProvider>(
      builder: (context, checkoutProvider, child) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(checkoutProvider),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DefaultButton(
              text: "Checkout",
              onPressed: () {
                CheckoutProvider _checkoutProvider = Provider.of<CheckoutProvider>(context, listen: false);
                _checkoutProvider.makePayment();
              },
            ),
          ),
        );
      },
    );
  }

  SafeArea _buildBody(CheckoutProvider checkoutProvider) {
    return SafeArea(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        itemCount: checkoutProvider.addedItemList.length,
        itemBuilder: (context, index) {
          Product item = checkoutProvider.addedItemList[index];
          return CartItem(
            onDeleteTap: () {
              checkoutProvider.removeItemFromCart(index);
            },
            item: item,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 12.h,
          );
        },
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
        "Cart",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}


