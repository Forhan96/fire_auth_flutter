import 'package:fire_auth/components/product_list_item.dart';
import 'package:fire_auth/models/product.dart';
import 'package:fire_auth/providers/home_provider.dart';
import 'package:fire_auth/router/routes.dart';
import 'package:fire_auth/utils/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
      await homeProvider.getProductList(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(homeProvider),
        );
      },
    );
  }

  Widget _buildBody(HomeProvider homeProvider) {
    return SafeArea(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w,
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              // childAspectRatio: 3 / 2,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.h,
            ),
            itemCount: homeProvider.productList.length,
            itemBuilder: (BuildContext ctx, index) {
              Product? item = homeProvider.productList[index];
              return ProductListItem(item: item);
            },
          ),
        );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          SizedBox(
            width: 4,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage("https://picsum.photos/191"),
            maxRadius: 20,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            "Forhan Ahmed",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            // do something
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.settingsScreen);
          },
        ),
      ],
    );
  }
}
