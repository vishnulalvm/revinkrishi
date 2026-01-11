import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : AppColors.white,
                ),
                child: Column(
                  children: [
                    // Profile Picture
                    Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.lightPrimary.withValues(alpha: 0.2),
                        border: Border.all(
                          color: AppColors.lightPrimary,
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 50.sp,
                        color: AppColors.lightPrimary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Name
                    Text(
                      'John Farmer',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Email
                    Text(
                      'john.farmer@example.com',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Edit Profile Button
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement edit profile
                      },
                      icon: Icon(Icons.edit, size: 18.sp),
                      label: Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                        foregroundColor: isDark ? AppColors.black : AppColors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Farm Information Section
              _buildSection(
                context,
                isDark,
                'Farm Information',
                [
                  _buildInfoTile(
                    context,
                    isDark,
                    Icons.landscape,
                    'Farm Name',
                    'Green Valley Farm',
                  ),
                  _buildInfoTile(
                    context,
                    isDark,
                    Icons.location_on,
                    'Location',
                    'California, USA',
                  ),
                  _buildInfoTile(
                    context,
                    isDark,
                    Icons.square_foot,
                    'Total Area',
                    '150 Acres',
                    isLast: true,
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Settings Section
              _buildSection(
                context,
                isDark,
                'Settings',
                [
                  _buildSettingTile(
                    context,
                    isDark,
                    Icons.notifications,
                    'Notifications',
                    'Manage notification preferences',
                    () {
                      // TODO: Navigate to notifications settings
                    },
                  ),
                  _buildSettingTile(
                    context,
                    isDark,
                    Icons.language,
                    'Language',
                    'English',
                    () {
                      // TODO: Navigate to language settings
                    },
                  ),
                  _buildSettingTile(
                    context,
                    isDark,
                    Icons.dark_mode,
                    'Theme',
                    isDark ? 'Dark Mode' : 'Light Mode',
                    () {
                      // TODO: Implement theme toggle
                    },
                  ),
                  _buildSettingTile(
                    context,
                    isDark,
                    Icons.security,
                    'Privacy & Security',
                    'Manage your privacy settings',
                    () {
                      // TODO: Navigate to privacy settings
                    },
                    isLast: true,
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Account Section
              _buildSection(
                context,
                isDark,
                'Account',
                [
                  _buildSettingTile(
                    context,
                    isDark,
                    Icons.help_outline,
                    'Help & Support',
                    'Get help and support',
                    () {
                      // TODO: Navigate to help
                    },
                  ),
                  _buildSettingTile(
                    context,
                    isDark,
                    Icons.info_outline,
                    'About',
                    'App version 1.0.0',
                    () {
                      // TODO: Show about dialog
                    },
                  ),
                  _buildSettingTile(
                    context,
                    isDark,
                    Icons.logout,
                    'Logout',
                    'Sign out of your account',
                    () {
                      // TODO: Implement logout
                    },
                    isDestructive: true,
                    isLast: true,
                  ),
                ],
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    bool isDark,
    String title,
    List<Widget> children,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0.w, bottom: 8.h),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardBackground : AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context,
    bool isDark,
    IconData icon,
    String label,
    String value,
    {bool isLast = false}
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(
                  color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
                  width: 8,
                ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.lightPrimary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20.sp,
              color: AppColors.lightPrimary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context,
    bool isDark,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isDestructive = false,
    bool isLast = false,
  }) {
    final Color iconColor = isDestructive ? AppColors.error : AppColors.lightPrimary;
    final Color titleColor = isDestructive
        ? AppColors.error
        : (isDark ? AppColors.darkText : AppColors.lightText);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast
                ? BorderSide.none
                : BorderSide(
                    color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
                    width: 8,
                  ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: iconColor,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20.sp,
              color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
