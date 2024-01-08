import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto/models/restaunrant_model.dart';
import 'package:resto/providers/home_provider.dart';
import 'package:resto/widgets/restaurant_card.dart';

class AllTab extends StatefulWidget {
  const AllTab({super.key});

  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProviderModel, child) => ListView.builder(
        itemCount: homeProviderModel.currentRestos!.length,
        itemBuilder: (context, index) => RestaurantCard(
          restaurantModel:
              RestaurantModel.fromJson(homeProviderModel.currentRestos![index]),
        ),
      ),
    );
  }
}
