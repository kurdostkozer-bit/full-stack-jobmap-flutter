import 'package:flutter/material.dart';
import '../../../../design_system/index.dart';

/// Home screen - main dashboard
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.simple(
        titleWidget: Row(
          children: [
            AppAvatar(initials: 'JD', size: 40),
            SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello, John', style: context.textTheme.labelLarge),
                Text(
                  'Find your next role',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            AppTextField.search(
              hintText: 'Search jobs, companies...',
              onTap: () {
                // TODO: Open search
              },
            ),
            SizedBox(height: AppSpacing.lg),

            // Featured section
            Text(
              'Featured Jobs',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.md),
                child: AppCard(
                  onTap: () {
                    // TODO: Navigate to job details
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Senior Developer',
                                  style: context.textTheme.titleLarge,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: AppSpacing.xs),
                                Text(
                                  'Tech Company Inc.',
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: context.colorScheme.outline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppBadge(
                            label: 'New',
                            backgroundColor: Colors.green,
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.sm,
                        children: [
                          AppChip(label: 'Remote', selected: true),
                          AppChip(label: 'Full-time', selected: true),
                          AppChip(label: '\$100k-150k'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.lg),

            // Recommended section
            Text(
              'Recommended For You',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            AppSkeletonLoader(itemCount: 2),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(AppIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.messages),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.profile),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
