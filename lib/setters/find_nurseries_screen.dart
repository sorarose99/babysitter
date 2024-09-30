
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FindNurseriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Find a Nurseries',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: ListView(
          children: [
            _buildNurseryItem(
              context,
              imageUrl: 'assets/nursery1.jpg',
              name: 'Mama Samora Center for Child Custody',
              rating: 4.2,
              distance: '3.2 km',
              status: 'Open • Closes 11PM',
            ),
            _buildNurseryItem(
              context,
              imageUrl: 'assets/nursery2.jpg',
              name: 'Madarik Kindergarten',
              rating: 4.8,
              distance: '2.2 km',
              status: 'Open 24 hours',
            ),
            _buildNurseryItem(
              context,
              imageUrl: 'assets/nursery3.jpg',
              name: 'Little Stars Nursery',
              rating: 4.5,
              distance: '1.8 km',
              status: 'Open • Closes 6PM',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNurseryItem(
    BuildContext context, {
    required String imageUrl,
    required String name,
    required double rating,
    required String distance,
    required String status,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              imageUrl,
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16.sp),
                    SizedBox(width: 2.w),
                    Text(
                      rating.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                          ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '• $distance',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  status,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14.sp,
                      ),
                ),
              ],
            ),
          ),
          Flexible(
            child: IconButton(
              icon: Icon(Icons.location_on,
                  color: Theme.of(context).colorScheme.secondary),
              onPressed: () {
              },
            ),
          ),
        ],
      ),
    );
  }
}
