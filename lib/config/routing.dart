import 'package:go_router/go_router.dart';
import 'package:transaction_mobile_app/data/models/equb_detail_model.dart';
import 'package:transaction_mobile_app/data/models/receiver_info_model.dart';
import 'package:transaction_mobile_app/data/models/user_model.dart';
import 'package:transaction_mobile_app/presentation/screens/equb_screen/components/complete_page.dart';
import 'package:transaction_mobile_app/presentation/screens/equb_screen/components/complete_page_dynamic.dart';
import 'package:transaction_mobile_app/presentation/screens/equb_screen/equb_creation_sceen.dart';
import 'package:transaction_mobile_app/presentation/screens/equb_screen/equb_admin_detail_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/equb_screen/equb_member_detail_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/equb_screen/equib_edit_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/equb_screen/dto/complete_page_dto.dart';
import 'package:transaction_mobile_app/presentation/screens/home_screen/components/contact_permission_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/login_screen/login_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/new_password_screen/new_password_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/otp_screen/otp_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/pincode_screen/confirm_pincode_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/pincode_screen/new_pincode_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/pincode_screen/pincode_login_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/pincode_screen/set_pincode_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/profile_screen/password_edit_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/profile_screen/profile_edit_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/send_invitation_screen/send_invitation_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/signup_screen/components/create_account_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/signup_screen/signup_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/splash_screen/splash_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/welcome_screen/welcome_screen.dart';
import 'package:transaction_mobile_app/presentation/screens/win_screen/win_screen.dart';

import '../presentation/screens/forget_password_screen/forget_password_screen.dart';
import '../presentation/screens/home_screen/home_screen.dart';
import '../presentation/screens/profile_upload_screen/profile_upload_screen.dart';
import '../presentation/screens/receipt_screen/receipt_screen.dart';

class RouteName {
  static const splash = 'splash_screen';
  static const home = 'home_screen';
  static const login = 'login_screen';
  static const signup = 'signup_screen';
  static const equbCreation = 'equb_creation_screen';
  // Added by Fasil
  static const equbAdminDetail = 'equb_admin_detail_screen';
  static const equbMemberDetail = 'equb_member_detail_screen';
  static const equbEdit = 'equb_edit_screen';
  static const equbActionCompleted = 'equb_action_completed_screen';

  static const welcome = 'welcome_screen';
  static const otp = 'otp_screen';
  static const createAccount = 'create_account_screen';
  static const receipt = 'receipt_screen';
  static const profileUpload = 'profile_upload_screen';
  static const contactPermission = 'contact_permission_screen';
  static const profileEdit = 'profile_edit_screen';
  static const passwordEdit = 'password_edit_screen';
  static const setPinCode = 'set_pincode_screen';
  static const confirmPinCode = 'confirm_pincode_screen';
  static const pinCode = 'pincode_screen';
  static const loginPincode = 'login_pincode_screen';
  static const completePage = 'complete_page';
  static const sendInvitation = 'send_invitation_screen';
  static const win = 'win_screen';
  static const forgetPassword = 'forget_screen';
  static const newPassword = 'new_password_screen';
  static const newPincode = 'new_pincode_screen';
}

final goRouting = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/welcome',
      name: RouteName.welcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/splash',
      name: RouteName.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      name: RouteName.home,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
            path: 'win_screen',
            name: RouteName.win,
            builder: (context, state) {
              List data = state.extra as List;
              return WinScreen(
                round: data[0],
                equbInviteeModel: data[1],
              );
            }),
        GoRoute(
          path: 'equb_creation',
          name: RouteName.equbCreation,
          builder: (context, state) => const EqubCreationScreen(),
        ),
        GoRoute(
          path: 'send_invitation',
          name: RouteName.sendInvitation,
          builder: (context, state) => const SendInvitationScreen(),
        ),
        GoRoute(
          path: 'equb_admin_detail',
          name: RouteName.equbAdminDetail,
          builder: (context, state) => EqubAdminDetailScreen(
            equbDetailModel: state.extra as EqubDetailModel,
          ),
        ),
        GoRoute(
          path: 'equb_member_detail',
          name: RouteName.equbMemberDetail,
          builder: (context, state) => EqubMemberDetailScreen(
            equbDetailModel: state.extra as EqubDetailModel,
          ),
        ),
        GoRoute(
          path: 'equb_edit',
          name: RouteName.equbEdit,
          builder: (context, state) => EqubEditScreen(
            equb: state.extra as EqubDetailModel,
          ),
        ),
        GoRoute(
          path: 'equb_action_completed',
          name: RouteName.equbActionCompleted,
          builder: (context, state) => CompletePageDynamic(
            completePageArgs: state.extra as CompletePageDto,
          ),
        ),
        GoRoute(
          path: 'receipt',
          name: RouteName.receipt,
          builder: (context, state) => ReceiptScreen(
            receiverInfo: state.extra as ReceiverInfo,
          ),
        ),
        GoRoute(
          path: 'contact_permission',
          name: RouteName.contactPermission,
          builder: (context, state) => ContactPermissionScreen(
            checkContactPermission: state.extra as Function(),
          ),
        ),
        GoRoute(
          path: 'profile_edit',
          name: RouteName.profileEdit,
          builder: (context, state) => const ProfileEditScreen(),
        ),
        GoRoute(
          path: 'password_edit',
          name: RouteName.passwordEdit,
          builder: (context, state) => const PasswordEditScreen(),
        ),
        GoRoute(
          path: 'complete_page',
          name: RouteName.completePage,
          builder: (context, state) => CompletePage(
            equbName: state.extra as String,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      name: RouteName.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/forgetPassword',
      name: RouteName.forgetPassword,
      builder: (context, state) => ForgetPasswordScreen(
        routeName: state.extra as String,
      ),
    ),
    GoRoute(
      path: '/newPassword',
      name: RouteName.newPassword,
      builder: (context, state) => NewPasswordScreen(
        userModel: state.extra as UserModel,
      ),
    ),
    GoRoute(
      path: '/newPincode',
      name: RouteName.newPincode,
      builder: (context, state) => NewPincodeScreen(
        userModel: state.extra as UserModel,
      ),
    ),
    GoRoute(
      path: '/signup',
      name: RouteName.signup,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/otp',
      name: RouteName.otp,
      builder: (context, state) => OTPScreen(
        userModel: state.extra as UserModel,
      ),
    ),
    GoRoute(
      path: '/setPincode',
      name: RouteName.setPinCode,
      builder: (context, state) => SetPincodeScreen(
        user: state.extra as UserModel,
      ),
    ),
    GoRoute(
        path: '/confirmPincode',
        name: RouteName.confirmPinCode,
        builder: (context, state) {
          List data = state.extra as List;
          return ConfirmPincodeScreen(
            user: data[0],
            pincode: data[1],
          );
        }),
    GoRoute(
      path: '/create_account',
      name: RouteName.createAccount,
      builder: (context, state) => CreateAccountScreen(
        userModel: state.extra as UserModel,
      ),
    ),
    GoRoute(
      path: '/profile_upload',
      name: RouteName.profileUpload,
      builder: (context, state) => ProfileUploadScreen(
        userModel: state.extra as UserModel,
      ),
    ),
    GoRoute(
      path: '/pincode_login',
      name: RouteName.loginPincode,
      builder: (context, state) => const PincodeLoginScreen(),
    ),
  ],
);
