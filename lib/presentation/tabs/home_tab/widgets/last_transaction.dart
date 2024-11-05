import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transaction_mobile_app/data/models/receiver_info_model.dart';
import 'package:transaction_mobile_app/gen/colors.gen.dart';
import 'package:transaction_mobile_app/presentation/tabs/home_tab/widgets/home_transaction_tile.dart';
import 'package:transaction_mobile_app/presentation/widgets/custom_shimmer.dart';

import '../../../../bloc/transaction/transaction_bloc.dart';
import '../../../widgets/text_widget.dart';

class LastTransaction extends StatefulWidget {
  const LastTransaction({super.key});

  @override
  State<LastTransaction> createState() => _LastTransactionState();
}

class _LastTransactionState extends State<LastTransaction> {
  String? selectedDayFilter;
  List<ReceiverInfo> selectedReceiverInfo = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100.sw,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            color: Color(0xFFF7F7F7),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(44),
              topRight: Radius.circular(44),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    text: 'Last Transaction',
                    type: TextType.small,
                    weight: FontWeight.w600,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: const Color(0xFFE8E8E8)),
                    ),
                    child: BlocConsumer<TransactionBloc, TransactionState>(
                      listener: (context, state) {
                        if (state is TransactionSuccess) {
                          if (state.data.isNotEmpty) {
                            setState(() {
                              selectedDayFilter = state.data.entries.first.key;
                              selectedReceiverInfo =
                                  state.data[selectedDayFilter] ?? [];
                            });
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is TransactionSuccess) {
                          if (state.data.isEmpty) {
                            return const SizedBox(
                              width: 50,
                              height: 23,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: TextWidget(
                                    text: '---',
                                    type: TextType.small,
                                    weight: FontWeight.w300,
                                  )),
                            );
                          }
                          return FutureBuilder(
                            future: Future.delayed(const Duration(seconds: 1)),
                            builder: (_, __) => DropdownButton(
                                dropdownColor: Colors.white,
                                isDense: true,
                                underline: const SizedBox(),
                                elevation: 0,
                                value: selectedDayFilter,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded),
                                items: [
                                  for (var entery in state.data.keys)
                                    DropdownMenuItem(
                                      value: entery,
                                      child: TextWidget(
                                        text: DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.now()) ==
                                                entery
                                            ? 'Today'
                                            : (DateTime.parse(entery).day -
                                                        1) ==
                                                    DateTime.now().day
                                                ? 'Yesterday'
                                                : DateFormat('d-MMMM').format(
                                                    DateTime.parse(entery)),
                                        color: ColorName.primaryColor,
                                        fontSize: 14,
                                        weight: FontWeight.w600,
                                      ),
                                    ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedDayFilter = value ?? 'today';
                                    selectedReceiverInfo =
                                        state.data[value] ?? [];
                                  });
                                }),
                          );
                        }
                        return const SizedBox(
                          width: 50,
                          height: 23,
                          child: Align(
                              alignment: Alignment.center,
                              child: TextWidget(
                                text: '---',
                                type: TextType.small,
                                weight: FontWeight.w300,
                              )),
                        );
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        CustomShimmer(width: 100.sw, height: 55),
                        const SizedBox(height: 10),
                        CustomShimmer(width: 100.sw, height: 55),
                        const SizedBox(height: 10),
                        CustomShimmer(width: 100.sw, height: 55),
                        const SizedBox(height: 10),
                        CustomShimmer(width: 100.sw, height: 55),
                      ],
                    );
                  } else if (state is TransactionSuccess) {
                    if (state.data.isEmpty) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        child: const TextWidget(
                          text: 'No Recent Transaction History',
                          fontSize: 15,
                          weight: FontWeight.w300,
                        ),
                      );
                    } else {
                      return Column(children: [
                        for (int index = 0; index < state.data.length; index++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var transaction in selectedReceiverInfo)
                                HomeTransactionTile(receiverInfo: transaction),
                            ],
                          ),
                      ]);
                    }
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            top: 20,
            child: Align(
              child: Container(
                width: 80,
                height: 16,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: ColorName.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}