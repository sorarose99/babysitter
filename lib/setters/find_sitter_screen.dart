
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FindSitterScreen extends StatelessWidget {
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
      body: ListView(
        children: [
          _buildSitterItem(
            context,
            name: 'Noor',
            distance: '2.3 km',
            iconColor: Colors.green,
            onTap: () {
              context.pushNamed('sitter-details',
                  queryParameters: {'sitterName': 'Noor'});
            },
          ),
          _buildSitterItem(
            context,
            name: 'Ranya',
            distance: '2.7 km',
            iconColor: Colors.green,
            onTap: () {
              context.pushNamed('sitter-details',
                  queryParameters: {'sitterName': 'Ranya'});
            },
          ),
          _buildSitterItem(
            context,
            name: 'Gooly',
            distance: '3.5 km',
            iconColor: Colors.orange,
            onTap: () {
              context.pushNamed('sitter-details',
                  queryParameters: {'sitterName': 'Gooly'});
            },
          ),
          _buildSitterItem(
            context,
            name: 'Rasha',
            distance: '5.5 km',
            iconColor: Colors.red,
            onTap: () {
              context.pushNamed('sitter-details',
                  queryParameters: {'sitterName': 'Rasha'});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSitterItem(
    BuildContext context, {
    required String name,
    required String distance,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.person,
            color: Theme.of(context).scaffoldBackgroundColor),
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18.sp),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            distance,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14.sp),
          ),
          SizedBox(width: 5.w),
          Icon(Icons.location_on, color: iconColor),
        ],
      ),
      onTap: onTap,
    );
  }
}
