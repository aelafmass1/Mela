import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:transaction_mobile_app/gen/assets.gen.dart';
import 'package:transaction_mobile_app/gen/colors.gen.dart';
import 'package:transaction_mobile_app/presentation/screens/transfer/widgets/enter_amount_section.dart';
import 'package:transaction_mobile_app/presentation/screens/transfer/widgets/note_section.dart';
import 'package:transaction_mobile_app/presentation/screens/transfer/widgets/search_btn.dart';
import 'package:transaction_mobile_app/presentation/screens/transfer/widgets/transfer_to_section.dart';
import 'package:transaction_mobile_app/presentation/screens/transfer/widgets/transfer_app_bar.dart';
import 'package:transaction_mobile_app/presentation/widgets/button_widget.dart';
import 'package:transaction_mobile_app/presentation/widgets/card_widget.dart';
import 'package:transaction_mobile_app/presentation/widgets/text_widget.dart';
import '../../../../../../config/routing.dart';
import '../../../widgets/check_details_section.dart';
import '../../../widgets/recents_section.dart';
import '../../../widgets/wallet_card.dart';
import '../../../widgets/amount_input.dart';
import '../../../widgets/note_input.dart';
import '../recents/recent_sent_user_vertical_list.dart';
import '../recents/recent_sent_users_horizontal_list.dart';

class TransferMoney extends StatefulWidget {
  const TransferMoney({super.key});
  @override
  State<TransferMoney> createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  final amountKey = GlobalKey<FormFieldState>();
  final noteKey = GlobalKey<FormFieldState>();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  String selectedCurrency = 'USD';
  double facilityFee = 12.08;
  double bankFee = 94.28;
  ValueNotifier<String?> pickedUser = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pickedUser,
        builder: (context, value, child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                const TransferAppBar(),
                const SliverToBoxAdapter(child: SizedBox(height: 14)),
                SearchBtn(onTap: () async {
                  final res = await context.pushNamed(RouteName.userSearch);
                  if (res != null) {
                    pickedUser.value = res as String?;
                  }
                }),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 14,
                  ),
                ),
                if (pickedUser.value == null)
                  const RecentsSentUsersHorizontalList(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 14,
                        ),
                        if (pickedUser.value != null)
                          Column(
                            children: [
                              TransferToUserSection(
                                onChangePressed: () {
                                  pickedUser.value = null;
                                },
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                            ],
                          ),
                        const EnterAmountSection(),
                        Row(
                          children: [
                            const Text("Make sure that this recipient have a "),
                            TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero),
                                onPressed: () {},
                                child: const Text("Mela Account."))
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const NoteSection(),
                        const SizedBox(
                          height: 24,
                        ),
                        const CheckDetailsSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16),
              child: ButtonWidget(
                child: const TextWidget(
                  text: 'Transfer Money',
                  color: Colors.white,
                ),
                onPressed: () {
                  // Handle transfer
                },
              ),
            ),
          );
        });
  }
}
