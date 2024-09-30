import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingViewPage extends StatelessWidget {
  final String serviceType;
  final String dateTime;
  final String childNames;
  final String sitterOrNursery;
  final String location;
  final String notes;
  final String status; // e.g., confirmed, pending, cancelled

  BookingViewPage({
    required this.serviceType,
    required this.dateTime,
    required this.childNames,
    required this.sitterOrNursery,
    required this.location,
    required this.notes,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Booking'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Service type'),
            _buildInfoCard(serviceType),
            SizedBox(height: 20.h),
            _buildSectionTitle('Date and time'),
            _buildInfoCard(dateTime),
            SizedBox(height: 20.h),
            _buildSectionTitle('Child/Children Names'),
            _buildInfoCard(childNames),
            SizedBox(height: 20.h),
            _buildSectionTitle('Allocated Babysitter/Nursery'),
            _buildInfoCard(sitterOrNursery),
            SizedBox(height: 20.h),
            _buildSectionTitle('Location'),
            InkWell(
              onTap: () {
                // Navigate to map or location page
              },
              child: _buildInfoCard(location, showMapLink: true),
            ),
            SizedBox(height: 20.h),
            _buildSectionTitle('Additional Notes'),
            _buildInfoCard(notes),
            SizedBox(height: 20.h),
            _buildSectionTitle('Reservation Status'),
            _buildStatusCard(status),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton('Cancel Booking', Colors.red, () {
                  // Cancel booking functionality
                }),
                _buildActionButton('Paying Off', Colors.green, () {
                  // Pay functionality
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoCard(String text, {bool showMapLink = false}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ),
          if (showMapLink)
            GestureDetector(
              onTap: () {
                // Handle map location tap
              },
              child: Text(
                'Show on map',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14.sp,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String status) {
    Color statusColor;

    switch (status.toLowerCase()) {
      case 'confirmed':
        statusColor = Colors.green;
        break;
      case 'pending':
        statusColor = Colors.orange;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 16.sp,
          color: statusColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(150.w, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
