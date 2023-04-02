import 'package:location/location.dart';
import 'package:nomad/Pages/Explore_page.dart';
import 'package:nomad/Pages/Guide_page.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/Login%20page.dart';
import 'package:nomad/Pages/Proposals_page.dart';
import 'package:nomad/Pages/Reports_page.dart';
import 'package:nomad/Pages/Sginup%20page.dart';
import 'package:nomad/Pages/profile_page.dart';

double? global_Latitude;
double? global_Longitude;
bool global_LoggedIn = false;
bool global_isAdmin = false;

var global_LoggedIn_Pages = [
  GuidePage(),
  MyHomePage(),
  ProfilePage(),
];

var global_GuestUser_Pages = [
  GuidePage(),
  MyHomePage(),
  Mysginuppage(),
];

var global_adminUser_Pages = [
  GuidePage(),
  MyHomePage(),
  Mysginuppage(),
  ReportsPage(),
  ProposalPage()
];
