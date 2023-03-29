import 'package:flutter/foundation.dart';
import 'package:solution_challenge_v1/main.dart';

class Language extends ChangeNotifier {
  String _lang = language;

  getLanguage() {
    return _lang;
  }

  setLanguage(String lang) {
    _lang = lang;
    notifyListeners();
  }

  // translate settings screen
  String tProfile() {
    if (getLanguage() == 'Arabic') {
      return 'حسابي';
    } else {
      return 'Profile';
    }
  }

  String tChangelanguage() {
    if (getLanguage() == 'Arabic') {
      return 'تغيير اللغة';
    } else {
      return 'Change Language';
    }
  }

  String tSignOut() {
    if (getLanguage() == 'Arabic') {
      return 'خروج';
    } else {
      return 'Sign Out';
    }
  }

  String tDarkMode() {
    if (getLanguage() == 'Arabic') {
      return 'الوضع الداكن';
    } else {
      return 'Dark Mode';
    }
  }

  //translate home screen
  String tEmergencySetupAndContactAuthorities() {
    if (getLanguage() == 'Arabic') {
      return 'إعداد الطوارئ والاتصال بالسلطات';
    } else {
      return 'Emergency Setup \nand Contact Authorities';
    }
  }

  String tNearestHelpCenters() {
    if (getLanguage() == 'Arabic') {
      return 'أقرب مراكز المساعدة';
    } else {
      return 'Nearest Help Centers';
    }
  }

  String tCommunityPortal() {
    if (getLanguage() == 'Arabic') {
      return 'بوابة المجتمع';
    } else {
      return 'Community Portal';
    }
  }

  String tLatestNewsAndArticles() {
    if (getLanguage() == 'Arabic') {
      return 'آخر الأخبار والمقالات';
    } else {
      return 'Latest News and Articles';
    }
  }

  String tEmeregencyRecording() {
    if (getLanguage() == 'Arabic') {
      return 'تسجيل للطوارئ';
    } else {
      return 'Emergency Recording';
    }
  }

  String tSettings() {
    if (getLanguage() == 'Arabic') {
      return 'الاعدادات';
    } else {
      return 'Settings';
    }
  }

  // home screen overlays

  //emergency setup overlay
  String tEmergencyContacts() {
    if (getLanguage() == 'Arabic') {
      return 'ارقام الطوارئ\nالخاصة بك';
    } else {
      return 'Emergency\nContacts';
    }
  }

  String tContactAuthorities() {
    if (getLanguage() == 'Arabic') {
      return 'ارقام السلطات';
    } else {
      return 'Contact\nAuthorities';
    }
  }

  // nearest help centers overlay
  String tPoliceStations() {
    if (getLanguage() == 'Arabic') {
      return 'مراكز الشرطة';
    } else {
      return 'Police\nStations';
    }
  }

  String tHospitals() {
    if (getLanguage() == 'Arabic') {
      return 'المستشفيات';
    } else {
      return 'Hospitals';
    }
  }

  String tNationalCouncilForWomen() {
    if (getLanguage() == 'Arabic') {
      return 'المجلس القومي للمرأة';
    } else {
      return 'National\nCouncil for\n Women';
    }
  }

// profile screen
  String tChangeName() {
    if (getLanguage() == 'Arabic') {
      return 'تغيير الاسم';
    } else {
      return 'Change Name';
    }
  }

  String tChangeemailaddress() {
    if (getLanguage() == 'Arabic') {
      return 'تغيير البريد الالكتروني';
    } else {
      return 'change email address';
    }
  }

  String tChangePassword() {
    if (getLanguage() == 'Arabic') {
      return 'تغيير كلمة السر';
    } else {
      return 'Change Password';
    }
  }

  // Contact Authorities
  String tNationalAuthorityforviolenceagainstwomeninMinistryofinterior() {
    if (getLanguage() == 'Arabic') {
      return ':الإدارة العامة لمكافحة العنف ضد المرأة بوزارة الداخلية';
    } else {
      return 'National Authority for violence against women in Ministry of interior';
    }
  }

  String tNationalCouncilforWomen() {
    if (getLanguage() == 'Arabic') {
      return ':مكتب الشكاوي بالمجلس القومي للمرأة';
    } else {
      return 'National Council for Women - Complaints Numbers:';
    }
  }

  String tChildhelpline() {
    if (getLanguage() == 'Arabic') {
      return ':خط نجدة الطفل';
    } else {
      return 'Child helpline:';
    }
  }

  String tMetroharassmenthotline() {
    if (getLanguage() == 'Arabic') {
      return ':الخط الساخن لقضايا التحرش في المترو';
    } else {
      return 'Metro harassment hotline:';
    }
  }

  String tMotherandchildhealthline() {
    if (getLanguage() == 'Arabic') {
      return ':خط صحة الأم والطفل';
    } else {
      return 'Mother and child health line:';
    }
  }

// screen names
  String tCommunity() {
    if (getLanguage() == 'Arabic') {
      return 'المجتمع';
    } else {
      return 'Community';
    }
  }

  String tComment() {
    if (getLanguage() == 'Arabic') {
      return 'التعليق';
    } else {
      return 'Comment';
    }
  }

  String tArticles() {
    if (getLanguage() == 'Arabic') {
      return 'المقالات';
    } else {
      return 'Articles';
    }
  }

  String tContacts() {
    if (getLanguage() == 'Arabic') {
      return 'جهات اتصال للطوارئ';
    } else {
      return 'Emergecny Contacts';
    }
  }

  String tContactAuthoritiesAppBar() {
    if (getLanguage() == 'Arabic') {
      return 'ارقام السلطات';
    } else {
      return 'Contact Authorities';
    }
  }

  String tEmergency() {
    if (getLanguage() == 'Arabic') {
      return ':النجدة';
    } else {
      return 'Emergency:';
    }
  }

  String tAmbulance() {
    if (getLanguage() == 'Arabic') {
      return ':الاسعاف';
    } else {
      return 'Ambulance:';
    }
  }
}
