import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resto/models/restaunrant_model.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, required this.restaurantModel});
  final RestaurantModel restaurantModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(11)),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(11),
                  topRight: Radius.circular(11),
                ),
                child: Image.network(
                  restaurantModel.imageUrl,
                  fit: BoxFit.cover,
                  width: 330.w,
                  height: 130.h,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFF1BC400)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 5.w, right: 5.w, top: 3.h, bottom: 3.h),
                    child: Row(
                      children: [
                        Text(
                          restaurantModel.ratings,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                        Image.asset(
                          'assets/rating_star.png',
                          width: 9.w,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            height: 50.h,
            width: 330.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x40000000),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    restaurantModel.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF000000),
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/discount.png',
                        width: 27.w,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        '${restaurantModel.discount}% FLAT OFF',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFF0000),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
