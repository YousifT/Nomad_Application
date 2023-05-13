import 'package:location/location.dart';
import 'package:nomad/Pages/Admin_Pages/Admin_Page.dart';
import 'package:nomad/Pages/Admin_Pages/Proposals_page.dart';
import 'package:nomad/Pages/Admin_Pages/Reports_page.dart';
import 'package:nomad/Pages/Extra_Pages/Explore_page.dart';
import 'package:nomad/Pages/Guide_Pages/Guide_page.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/User_Pages/Login%20page.dart';
import 'package:nomad/Pages/User_Pages/Sginup%20page.dart';
import 'package:nomad/Pages/User_Pages/UserProfile.dart';
import 'package:nomad/Pages/User_Pages/SettingsMenu.dart';

double? global_Latitude;
double? global_Longitude;
bool global_LoggedIn = false;
bool global_isBanned = false;
bool global_isAdmin = false;
String global_UserEmail = "";
String global_FullName = "";

var global_LoggedIn_Pages = [
  MyHomePage(),
  SettingsMenu(),
];

var global_GuestUser_Pages = [
  MyHomePage(),
  Mysginuppage(),
];

var global_NavBarPages = [MyHomePage(), Mysginuppage()];

var HomePageChildren = [];
