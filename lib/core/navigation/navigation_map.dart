/// Complete navigation map for JobMap application
/// This serves as documentation and reference for all screens

class NavigationMap {
  static const String root = '/';

  /// Authentication Flow
  class Auth {
    static const String splash = '/';
    static const String welcome = '/welcome';
    static const String login = '/login';
    static const String register = '/register';
    static const String verifyEmail = '/verify-email';
    static const String forgotPassword = '/forgot-password';
    static const String resetPassword = '/reset-password';
  }

  /// Main Application (Job Seeker)
  class JobSeeker {
    static const String home = '/home';
    static const String searchJobs = '/search-jobs';
    static const String jobDetails = '/job-details/:id';
    static const String savedJobs = '/saved-jobs';
    static const String applications = '/applications';
    static const String applicationDetails = '/application-details/:id';
    static const String notifications = '/notifications';
    static const String messages = '/messages';
    static const String chat = '/chat/:conversationId';

    /// Career Profile Section
    class Profile {
      static const String root = '/profile';
      static const String personalInfo = '/profile/personal-info';
      static const String skills = '/profile/skills';
      static const String experience = '/profile/experience';
      static const String education = '/profile/education';
      static const String languages = '/profile/languages';
      static const String projects = '/profile/projects';
      static const String certificates = '/profile/certificates';
      static const String socialLinks = '/profile/social-links';
      static const String attachments = '/profile/attachments';
      static const String jobPreferences = '/profile/job-preferences';
      static const String profileCompletion = '/profile/completion';
    }

    static const String referral = '/referral';
    static const String settings = '/settings';
  }

  /// Company Dashboard
  class Company {
    static const String dashboard = '/company/dashboard';
    static const String jobs = '/company/jobs';
    static const String jobDetails = '/company/job-details/:id';
    static const String applications = '/company/applications';
    static const String applicationDetails = '/company/application-details/:id';
    static const String recruiters = '/company/recruiters';
    static const String departments = '/company/departments';
    static const String companyProfile = '/company/profile';
    static const String settings = '/company/settings';
  }

  /// Admin Dashboard
  class Admin {
    static const String dashboard = '/admin/dashboard';
    static const String users = '/admin/users';
    static const String companies = '/admin/companies';
    static const String jobs = '/admin/jobs';
    static const String reports = '/admin/reports';
    static const String settings = '/admin/settings';
  }

  /// Modals & Overlays (not full routes)
  class Modals {
    static const String filterJobs = 'filter_jobs';
    static const String sortJobs = 'sort_jobs';
    static const String shareJob = 'share_job';
    static const String reportJob = 'report_job';
    static const String confirmApplication = 'confirm_application';
  }
}

/// Screen metadata (for navigation tracking)
class ScreenMetadata {
  final String name;
  final String route;
  final String category; // 'auth', 'job_seeker', 'company', 'admin'
  final String? description;

  ScreenMetadata({
    required this.name,
    required this.route,
    required this.category,
    this.description,
  });
}

/// All screens registry
final screens = [
  // Auth screens
  ScreenMetadata(
    name: 'Splash',
    route: NavigationMap.Auth.splash,
    category: 'auth',
  ),
  ScreenMetadata(
    name: 'Welcome',
    route: NavigationMap.Auth.welcome,
    category: 'auth',
  ),
  ScreenMetadata(
    name: 'Login',
    route: NavigationMap.Auth.login,
    category: 'auth',
  ),
  ScreenMetadata(
    name: 'Register',
    route: NavigationMap.Auth.register,
    category: 'auth',
  ),
  ScreenMetadata(
    name: 'Verify Email',
    route: NavigationMap.Auth.verifyEmail,
    category: 'auth',
  ),
  ScreenMetadata(
    name: 'Forgot Password',
    route: NavigationMap.Auth.forgotPassword,
    category: 'auth',
  ),
  ScreenMetadata(
    name: 'Reset Password',
    route: NavigationMap.Auth.resetPassword,
    category: 'auth',
  ),

  // Job Seeker screens
  ScreenMetadata(
    name: 'Home',
    route: NavigationMap.JobSeeker.home,
    category: 'job_seeker',
    description: 'Main dashboard with featured jobs',
  ),
  ScreenMetadata(
    name: 'Search Jobs',
    route: NavigationMap.JobSeeker.searchJobs,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Job Details',
    route: NavigationMap.JobSeeker.jobDetails,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Saved Jobs',
    route: NavigationMap.JobSeeker.savedJobs,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Applications',
    route: NavigationMap.JobSeeker.applications,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Notifications',
    route: NavigationMap.JobSeeker.notifications,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Messages',
    route: NavigationMap.JobSeeker.messages,
    category: 'job_seeker',
  ),

  // Career Profile screens
  ScreenMetadata(
    name: 'Profile - Personal Info',
    route: NavigationMap.JobSeeker.Profile.personalInfo,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Skills',
    route: NavigationMap.JobSeeker.Profile.skills,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Experience',
    route: NavigationMap.JobSeeker.Profile.experience,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Education',
    route: NavigationMap.JobSeeker.Profile.education,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Languages',
    route: NavigationMap.JobSeeker.Profile.languages,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Projects',
    route: NavigationMap.JobSeeker.Profile.projects,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Certificates',
    route: NavigationMap.JobSeeker.Profile.certificates,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Social Links',
    route: NavigationMap.JobSeeker.Profile.socialLinks,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Job Preferences',
    route: NavigationMap.JobSeeker.Profile.jobPreferences,
    category: 'job_seeker',
  ),

  // Company screens
  ScreenMetadata(
    name: 'Company Dashboard',
    route: NavigationMap.Company.dashboard,
    category: 'company',
  ),
  ScreenMetadata(
    name: 'Company Jobs',
    route: NavigationMap.Company.jobs,
    category: 'company',
  ),
  ScreenMetadata(
    name: 'Company Applications',
    route: NavigationMap.Company.applications,
    category: 'company',
  ),

  // Admin screens
  ScreenMetadata(
    name: 'Admin Dashboard',
    route: NavigationMap.Admin.dashboard,
    category: 'admin',
  ),
];

/// Get screens by category
List<ScreenMetadata> getScreensByCategory(String category) {
  return screens.where((s) => s.category == category).toList();
}
