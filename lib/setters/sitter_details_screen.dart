
import 'package:babysit/location/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SitterDetailsScreen extends StatelessWidget {
  final String sitterName;

  SitterDetailsScreen({required this.sitterName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Find a Sitter',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30.r,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.person, color: Colors.white, size: 30.r),
              ),
              title: Text(
                sitterName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              subtitle: Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20.sp),
                  Icon(Icons.star, color: Colors.amber, size: 20.sp),
                  Icon(Icons.star, color: Colors.amber, size: 20.sp),
                  Icon(Icons.star, color: Colors.amber, size: 20.sp),
                  Icon(Icons.star_border, size: 20.sp),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            _buildSectionHeader(context, 'Location'),
            SizedBox(height: 10.h),
            Container(
              height: 200.h,
              child: LocationWidget(
                initialPosition: LatLng(37.7749, -122.4194),
              ),
            ),
            SizedBox(height: 20.h),
            _buildSectionHeader(context, 'Skills'),
            SizedBox(height: 20.h),
            _buildSectionHeader(context, 'More Information'),
            SizedBox(height: 20.h),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: Size(150.w, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Text('Booking', style: TextStyle(fontSize: 18.sp)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
        ),
        Icon(Icons.expand_more, color: Theme.of(context).iconTheme.color),
      ],
    );
  }
}
