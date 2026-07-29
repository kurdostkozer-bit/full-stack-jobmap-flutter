/// Complete navigation map for JobMap application
/// This serves as documentation and reference for all screens
class NavigationMap {
  static const String root = '/';

  /// Authentication Flow
  static const AuthRoutes auth = AuthRoutes();

  /// Main Application (Job Seeker)
  static const JobSeekerRoutes jobseeker = JobSeekerRoutes();

  /// Career Profile Section (nested in JobSeeker)
  static const ProfileRoutes profile = ProfileRoutes();

  /// Company Dashboard
  static const CompanyRoutes company = CompanyRoutes();

  /// Admin Dashboard
  static const AdminRoutes admin = AdminRoutes();

  /// Modals & Overlays
  static const ModalRoutes modals = ModalRoutes();

  // Getters for backward compatibility
  static AuthRoutes get authRoutes => auth;
  static JobSeekerRoutes get jobSeekerRoutes => jobseeker;
  static CompanyRoutes get companyRoutes => company;
  static AdminRoutes get adminRoutes => admin;
  // Legacy getters (uppercase) used across the codebase
  // ignore: non_constant_identifier_names
  static AuthRoutes get Auth => auth;
  // ignore: non_constant_identifier_names
  static JobSeekerRoutes get JobSeeker => jobseeker;
  // ignore: non_constant_identifier_names
  static ProfileRoutes get Profile => profile;
  // ignore: non_constant_identifier_names
  static CompanyRoutes get Company => company;
  // ignore: non_constant_identifier_names
  static AdminRoutes get Admin => admin;
  // ignore: non_constant_identifier_names
  static ModalRoutes get Modals => modals;
}

/// Authentication Flow Routes
class AuthRoutes {
  const AuthRoutes();
  
  final String splash = '/';
  final String welcome = '/welcome';
  final String login = '/login';
  final String register = '/register';
  final String verifyEmail = '/verify-email';
  final String forgotPassword = '/forgot-password';
  final String resetPassword = '/reset-password';
}

/// Career Profile Section Routes
class ProfileRoutes {
  const ProfileRoutes();
  
  final String root = '/profile';
  final String personalInfo = '/profile/personal-info';
  final String skills = '/profile/skills';
  final String experience = '/profile/experience';
  final String education = '/profile/education';
  final String languages = '/profile/languages';
  final String projects = '/profile/projects';
  final String certificates = '/profile/certificates';
  final String socialLinks = '/profile/social-links';
  final String attachments = '/profile/attachments';
  final String jobPreferences = '/profile/job-preferences';
  final String profileCompletion = '/profile/completion';
}

/// Main Application (Job Seeker) Routes
class JobSeekerRoutes {
  const JobSeekerRoutes();
  
  final String home = '/home';
  final String searchJobs = '/search-jobs';
  final String jobDetails = '/job-details/:id';
  final String savedJobs = '/saved-jobs';
  final String applications = '/applications';
  final String applicationDetails = '/application-details/:id';
  final String notifications = '/notifications';
  final String messages = '/messages';
  final String chat = '/chat/:conversationId';
  final String referral = '/referral';
  final String settings = '/settings';
  
  final ProfileRoutes profile = const ProfileRoutes();
  ProfileRoutes get profileRoutes => profile;
  // Legacy getter to match existing codebase usage: `NavigationMap.JobSeeker.Profile`
  // ignore: non_constant_identifier_names
  ProfileRoutes get Profile => profile;
}

/// Company Dashboard Routes
class CompanyRoutes {
  const CompanyRoutes();
  
  final String dashboard = '/company/dashboard';
  final String jobs = '/company/jobs';
  final String jobDetails = '/company/job-details/:id';
  final String applications = '/company/applications';
  final String applicationDetails = '/company/application-details/:id';
  final String recruiters = '/company/recruiters';
  final String departments = '/company/departments';
  final String companyProfile = '/company/profile';
  final String settings = '/company/settings';
}

/// Admin Dashboard Routes
class AdminRoutes {
  const AdminRoutes();
  
  final String dashboard = '/admin/dashboard';
  final String users = '/admin/users';
  final String companies = '/admin/companies';
  final String jobs = '/admin/jobs';
  final String reports = '/admin/reports';
  final String settings = '/admin/settings';
}

/// Modals & Overlays (not full routes)
class ModalRoutes {
  const ModalRoutes();
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
    route: NavigationMap.authRoutes.splash,
    category: 'auth',
  ),
  ScreenMetadata(
    name: 'Welcome',
    route: NavigationMap.authRoutes.welcome,
    category: 'auth',
  ),
  ScreenMetadata(
    name: 'Login',
    route: NavigationMap.authRoutes.login,
    category: 'auth',
  ),
  ScreenMetadata(
    name: 'Register',
    route: NavigationMap.authRoutes.register,
    category: 'auth',
  ),
  ScreenMetadata(
    name: 'Verify Email',
    route: NavigationMap.authRoutes.verifyEmail,
    category: 'auth',
  ),
  ScreenMetadata(
    name: 'Forgot Password',
    route: NavigationMap.authRoutes.forgotPassword,
    category: 'auth',
  ),
  ScreenMetadata(
    name: 'Reset Password',
    route: NavigationMap.authRoutes.resetPassword,
    category: 'auth',
  ),

  // Job Seeker screens
  ScreenMetadata(
    name: 'Home',
    route: NavigationMap.jobSeekerRoutes.home,
    category: 'job_seeker',
    description: 'Main dashboard with featured jobs',
  ),
  ScreenMetadata(
    name: 'Search Jobs',
    route: NavigationMap.jobSeekerRoutes.searchJobs,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Job Details',
    route: NavigationMap.jobSeekerRoutes.jobDetails,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Saved Jobs',
    route: NavigationMap.jobSeekerRoutes.savedJobs,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Applications',
    route: NavigationMap.jobSeekerRoutes.applications,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Notifications',
    route: NavigationMap.jobSeekerRoutes.notifications,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Messages',
    route: NavigationMap.jobSeekerRoutes.messages,
    category: 'job_seeker',
  ),

  // Career Profile screens
  ScreenMetadata(
    name: 'Profile - Personal Info',
    route: NavigationMap.jobSeekerRoutes.profileRoutes.personalInfo,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Skills',
    route: NavigationMap.jobSeekerRoutes.profileRoutes.skills,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Experience',
    route: NavigationMap.jobSeekerRoutes.profileRoutes.experience,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Education',
    route: NavigationMap.jobSeekerRoutes.profileRoutes.education,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Languages',
    route: NavigationMap.jobSeekerRoutes.profileRoutes.languages,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Projects',
    route: NavigationMap.jobSeekerRoutes.profileRoutes.projects,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Certificates',
    route: NavigationMap.jobSeekerRoutes.profileRoutes.certificates,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Social Links',
    route: NavigationMap.jobSeekerRoutes.profileRoutes.socialLinks,
    category: 'job_seeker',
  ),
  ScreenMetadata(
    name: 'Profile - Job Preferences',
    route: NavigationMap.jobSeekerRoutes.profileRoutes.jobPreferences,
    category: 'job_seeker',
  ),

  // Company screens
  ScreenMetadata(
    name: 'Company Dashboard',
    route: NavigationMap.companyRoutes.dashboard,
    category: 'company',
  ),
  ScreenMetadata(
    name: 'Company Jobs',
    route: NavigationMap.companyRoutes.jobs,
    category: 'company',
  ),
  ScreenMetadata(
    name: 'Company Applications',
    route: NavigationMap.companyRoutes.applications,
    category: 'company',
  ),

  // Admin screens
  ScreenMetadata(
    name: 'Admin Dashboard',
    route: NavigationMap.adminRoutes.dashboard,
    category: 'admin',
  ),
];

/// Get screens by category
List<ScreenMetadata> getScreensByCategory(String category) {
  return screens.where((s) => s.category == category).toList();
}
