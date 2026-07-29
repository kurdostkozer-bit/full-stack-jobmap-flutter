import 'package:flutter/material.dart';

/// JobMap Icon System - Material Icons mapped to semantic names
class AppIcons {
  // Private constructor to prevent instantiation
  AppIcons._();

  // ============= NAVIGATION ICONS =============
  static const IconData home = Icons.home_outlined;
  static const IconData homeFilled = Icons.home;
  static const IconData search = Icons.search;
  static const IconData notifications = Icons.notifications_none;
  static const IconData notificationsFilled = Icons.notifications;
  static const IconData messages = Icons.mail_outline;
  static const IconData messagesFilled = Icons.mail;
  static const IconData profile = Icons.person_outline;
  static const IconData profileFilled = Icons.person;
  static const IconData settings = Icons.settings_outlined;
  static const IconData settingsFilled = Icons.settings;
  static const IconData menu = Icons.menu;
  static const IconData menuClose = Icons.close;
  static const IconData back = Icons.arrow_back;
  static const IconData forward = Icons.arrow_forward;

  // ============= CAREER & JOBS ICONS =============
  static const IconData briefcase = Icons.work_outline;
  static const IconData briefcaseFilled = Icons.work;
  static const IconData jobs = Icons.assignment_outlined;
  static const IconData jobsFilled = Icons.assignment;
  static const IconData applications = Icons.list_alt_outlined;
  static const IconData applicationsFilled = Icons.list_alt;
  static const IconData bookmark = Icons.bookmark_border;
  static const IconData bookmarkFilled = Icons.bookmark;
  static const IconData company = Icons.business_outlined;
  static const IconData companyFilled = Icons.business;
  static const IconData location = Icons.location_on_outlined;
  static const IconData locationFilled = Icons.location_on;
  static const IconData salary = Icons.attach_money;
  static const IconData calendar = Icons.calendar_today_outlined;
  static const IconData calendarFilled = Icons.calendar_today;
  static const IconData clock = Icons.schedule_outlined;
  static const IconData clockFilled = Icons.schedule;

  // ============= PROFILE ICONS =============
  static const IconData user = Icons.person;
  static const IconData users = Icons.group;
  static const IconData skill = Icons.star_outline;
  static const IconData skillFilled = Icons.star;
  static const IconData experience = Icons.history;
  static const IconData education = Icons.school_outlined;
  static const IconData educationFilled = Icons.school;
  static const IconData language = Icons.language;
  static const IconData certificate = Icons.verified_outlined;
  static const IconData certificateFilled = Icons.verified;
  static const IconData portfolio = Icons.image_outlined;
  static const IconData portfolioFilled = Icons.image;
  static const IconData link = Icons.link;
  static const IconData unlink = Icons.link_off;
  static const IconData attachment = Icons.attach_file;
  static const IconData document = Icons.description_outlined;
  static const IconData documentFilled = Icons.description;
  static const IconData resume = Icons.picture_as_pdf;

  // ============= ACTION ICONS =============
  static const IconData add = Icons.add;
  static const IconData addCircle = Icons.add_circle_outline;
  static const IconData addCircleFilled = Icons.add_circle;
  static const IconData edit = Icons.edit_outlined;
  static const IconData editFilled = Icons.edit;
  static const IconData delete = Icons.delete_outline;
  static const IconData deleteFilled = Icons.delete;
  static const IconData share = Icons.share_outlined;
  static const IconData shareFilled = Icons.share;
  static const IconData download = Icons.download_outlined;
  static const IconData downloadFilled = Icons.download;
  static const IconData upload = Icons.upload_outlined;
  static const IconData uploadFilled = Icons.upload;
  static const IconData more = Icons.more_vert;
  static const IconData moreHorizontal = Icons.more_horiz;
  static const IconData refresh = Icons.refresh;
  static const IconData sync = Icons.sync;

  // ============= INTERACTION ICONS =============
  static const IconData like = Icons.favorite_outline;
  static const IconData likeFilled = Icons.favorite;
  static const IconData comment = Icons.comment_outlined;
  static const IconData commentFilled = Icons.comment;
  static const IconData reply = Icons.reply;
  static const IconData send = Icons.send_outlined;
  static const IconData sendFilled = Icons.send;
  static const IconData call = Icons.call_outlined;
  static const IconData callFilled = Icons.call;
  static const IconData email = Icons.email_outlined;
  static const IconData emailFilled = Icons.email;

  // ============= STATUS ICONS =============
  static const IconData success = Icons.check_circle_outline;
  static const IconData successFilled = Icons.check_circle;
  static const IconData error = Icons.error_outline;
  static const IconData errorFilled = Icons.error;
  static const IconData warning = Icons.warning_outlined;
  static const IconData warningFilled = Icons.warning;
  static const IconData info = Icons.info_outlined;
  static const IconData infoFilled = Icons.info;
  static const IconData check = Icons.check;
  static const IconData checkCircle = Icons.check_circle;
  static const IconData close = Icons.close;
  static const IconData closeCircle = Icons.cancel_outlined;

  // ============= UTILITY ICONS =============
  static const IconData eye = Icons.visibility_outlined;
  static const IconData eyeClosed = Icons.visibility_off_outlined;
  static const IconData filter = Icons.filter_list_outlined;
  static const IconData filterFilled = Icons.filter_list;
  static const IconData sort = Icons.sort;
  static const IconData star = Icons.star_outline;
  static const IconData starFilled = Icons.star;
  static const IconData rating = Icons.star_half;
  static const IconData bell = Icons.notifications_none;
  static const IconData bellFilled = Icons.notifications;
  static const IconData dark = Icons.dark_mode_outlined;
  static const IconData light = Icons.light_mode_outlined;
  static const IconData logout = Icons.logout;
  static const IconData login = Icons.login;

  // ============= SOCIAL ICONS =============
  static const IconData linkedIn = Icons.share;
  static const IconData github = Icons.code;
  static const IconData twitter = Icons.share;
  static const IconData facebook = Icons.public;
  static const IconData instagram = Icons.photo;
  static const IconData website = Icons.language;

  // ============= VERIFICATION ICONS =============
  static const IconData verified = Icons.verified;
  static const IconData pending = Icons.schedule;
  static const IconData rejected = Icons.close;
  static const IconData unverified = Icons.help_outline;

  // ============= SIZE PRESETS =============
  static const double sizeXs = 16.0;
  static const double sizeSm = 20.0;
  static const double sizeMd = 24.0;
  static const double sizeLg = 32.0;
  static const double sizeXl = 48.0;
  static const double sizeXxl = 64.0;
}

/// Icon utilities
class AppIconUtils {
  // Private constructor to prevent instantiation
  AppIconUtils._();

  /// Get icon with custom size and color
  static Icon icon(
    IconData icon, {
    double size = AppIcons.sizeMd,
    Color? color,
    double? semanticLabel,
  }) =>
      Icon(
        icon,
        size: size,
        color: color,
        semanticLabel: semanticLabel?.toString(),
      );

  /// Get outlined/filled icon pair
  static IconData getIconVariant({
    required IconData outlined,
    required IconData filled,
    required bool isFilled,
  }) =>
      isFilled ? filled : outlined;
}
