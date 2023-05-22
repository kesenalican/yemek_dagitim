import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/core/themes/theme.dart';
import 'package:dinamik_yemek_dagitim/extensions/extensions.dart';
import 'package:dinamik_yemek_dagitim/view/common/title_text.dart';
import 'package:dinamik_yemek_dagitim/view/pages/willbeDelivered/model/deliver_model.dart';
import 'package:dinamik_yemek_dagitim/view/pages/willbeDelivered/service/delivered_service.dart';
import 'package:dinamik_yemek_dagitim/view/pages/willbeDelivered/viewmodel/deliver_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WillBeDelivered extends ConsumerStatefulWidget {
  const WillBeDelivered({super.key});

  @override
  ConsumerState<WillBeDelivered> createState() => _WillBeDeliveredState();
}

class _WillBeDeliveredState extends ConsumerState<WillBeDelivered> {
  List<DeliverList> deliverList = [];
  late List<DeliverList> searchedDeliverList = [];
  bool isSearched = false;
  var orderDate = DateTime.now();
  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).colorScheme.onBackground,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }

  Widget _search(List<DeliverList>? deliverList) {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Kişi Ara",
                      hintStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, bottom: 0, top: 5),
                      prefixIcon: Icon(Icons.search, color: Colors.black54)),
                  onChanged: (value) {
                    searchedDeliverList = deliverList!
                        .where((element) => element.consumerName
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                    setState(() {
                      isSearched = true;
                    });
                  }),
            ),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () async {
              await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: LightColor.orange,
                              onPrimary: Colors.white,
                              onSurface: LightColor.orange,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: LightColor.orange,
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                      lastDate: DateTime(2050))
                  .then((secilenTarih) {
                setState(() {
                  orderDate = secilenTarih!;
                  setState(() {});
                });
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                  color: Theme.of(context).colorScheme.onBackground,
                  boxShadow: AppTheme.shadow),
              child: const Icon(
                Icons.date_range,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container persons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: LightColor.background,
          border: Border.all(
            color: Colors.green.shade700,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xfffbf2ef),
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(5, 5),
            ),
          ],
        ),
        child: const Row(
          children: [
            TitleText(
              text: 'Blabla falan',
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          persons(),
          persons(),
          persons(),
          persons(),
          persons(),
          persons(),
          persons(),
          persons(),
          persons(),
          persons(),
          persons(),
        ],
        // children: AppData.categoryList
        //     .map(
        //       (category) => ProductIcon(
        //         model: category,
        //         onSelected: (model) {
        //           setState(() {
        //             AppData.categoryList.forEach((item) {
        //               item.isSelected = false;
        //             });
        //             model.isSelected = true;
        //           });
        //         },
        //       ),
        //     )
        //     .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var getDelivery = ref.watch(getDeliveryList(orderDate.toIso8601String()));
    var viewModel = ref.watch(deliverViewModel);
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _search(viewModel.deliverList),
          getDelivery.when(
              data: (data) {
                if (viewModel.deliverList != null) {
                  deliverList = viewModel.deliverList!;
                }
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: context.dynamicHeight * 0.6,
                  width: AppTheme.fullWidth(context),
                  child: deliverList.isNotEmpty
                      ? ListView.builder(
                          itemCount: isSearched
                              ? searchedDeliverList.length
                              : deliverList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      title: Text(
                                        isSearched
                                            ? searchedDeliverList[index]
                                                .nameOfUser
                                            : deliverList[index].nameOfUser,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      children: [
                                        SimpleDialogOption(
                                          child: Column(
                                            children: [
                                              consumerInfo(
                                                  index,
                                                  'T.C',
                                                  isSearched
                                                      ? searchedDeliverList[
                                                              index]
                                                          .consumerId
                                                          .toString()
                                                      : deliverList[index]
                                                          .consumerId
                                                          .toString()),
                                              consumerInfo(
                                                  index,
                                                  'Adı',
                                                  isSearched
                                                      ? searchedDeliverList[
                                                              index]
                                                          .consumerName
                                                      : deliverList[index]
                                                          .consumerName),
                                              consumerInfo(
                                                  index,
                                                  'Tarih',
                                                  isSearched
                                                      ? '${searchedDeliverList[index].createDate.year}/${searchedDeliverList[index].createDate.month}/${searchedDeliverList[index].createDate.day}'
                                                      : '${deliverList[index].createDate.year}/${deliverList[index].createDate.month}/${deliverList[index].createDate.day}'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: LightColor.background,
                                    border: Border.all(
                                      color: LightColor.orange,
                                      width: 2,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xfffbf2ef),
                                        blurRadius: 10,
                                        spreadRadius: 5,
                                        offset: Offset(5, 5),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      TitleText(
                                        text: isSearched
                                            ? searchedDeliverList[index]
                                                .consumerName
                                            : deliverList[index].consumerName,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            'Bugüne ait dağıtım listesi bulunamadı',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                );
              },
              error: (err, stack) {
                return Center(
                  child: Text('Hata ${err.toString()}'),
                );
              },
              loading: () => const CircularProgressIndicator()),
        ],
      ),
    );
  }

  Row consumerInfo(int index, String fieldName, String field) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            fieldName,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: Text(
            ':',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(flex: 2, child: Text(field)),
      ],
    );
  }
}
