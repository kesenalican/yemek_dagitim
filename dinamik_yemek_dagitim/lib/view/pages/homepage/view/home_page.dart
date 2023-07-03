import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/core/themes/theme.dart';
import 'package:dinamik_yemek_dagitim/extensions/extensions.dart';
import 'package:dinamik_yemek_dagitim/view/common/title_text.dart';
import 'package:dinamik_yemek_dagitim/view/pages/homepage/model/consumer_model.dart';
import 'package:dinamik_yemek_dagitim/view/pages/homepage/service/consumer_service.dart';
import 'package:dinamik_yemek_dagitim/view/pages/homepage/viewmodel/consumer_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  List<ConsumerListModel> consumerList = [];
  late List<ConsumerListModel> searchedConsumerList = [];
  bool isSearched = false;
  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: context.paddingDefault,
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

  Widget _categoryWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          InkWell(onTap: () {}, child: persons()),
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
          children: const [
            TitleText(
              text: 'Alican Kesen',
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _search(List<ConsumerListModel>? consumerList) {
    return Card(
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
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),
                onChanged: (value) {
                  searchedConsumerList = consumerList!
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                  setState(() {
                    isSearched = true;
                  });
                },
              ),
            ),
          ),
          //const SizedBox(width: 20),
          //_icon(Icons.filter_list, color: Colors.black54)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var getConsumers = ref.watch(getConsumer);
    var viewModel = ref.watch(consumerViewModel);
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _search(viewModel.consumerList),
          //_categoryWidget(),
          getConsumers.when(
              data: (data) {
                consumerList = viewModel.consumerList!;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: context.dynamicHeight * 0.6,
                  width: AppTheme.fullWidth(context),
                  child: ListView.builder(
                    itemCount: isSearched
                        ? searchedConsumerList.length
                        : consumerList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                title: Text(
                                  isSearched
                                      ? searchedConsumerList[index].name
                                      : consumerList[index].name,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                children: [
                                  SimpleDialogOption(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: consumerInfo(
                                              index,
                                              'T.C',
                                              isSearched
                                                  ? searchedConsumerList[index]
                                                      .identityNumber
                                                  : consumerList[index]
                                                      .identityNumber),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: consumerInfo(
                                              index,
                                              'Şehir',
                                              isSearched
                                                  ? searchedConsumerList[index]
                                                      .cityName
                                                  : consumerList[index]
                                                      .cityName),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: consumerInfo(
                                              index,
                                              'İlçe',
                                              isSearched
                                                  ? searchedConsumerList[index]
                                                      .countyName
                                                  : consumerList[index]
                                                      .countyName),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: consumerInfo(
                                              index,
                                              'Mahalle',
                                              isSearched
                                                  ? searchedConsumerList[index]
                                                      .neighborhoodName
                                                  : consumerList[index]
                                                      .neighborhoodName),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: consumerInfo(
                                              index,
                                              'Cadde',
                                              isSearched
                                                  ? searchedConsumerList[index]
                                                      .street
                                                  : consumerList[index].street),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: consumerInfo(
                                              index,
                                              'Bina No',
                                              isSearched
                                                  ? searchedConsumerList[index]
                                                      .buildNo
                                                  : consumerList[index]
                                                      .buildNo),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: consumerInfo(
                                              index,
                                              'Daire No',
                                              isSearched
                                                  ? searchedConsumerList[index]
                                                          .doorNo ??
                                                      ''
                                                  : consumerList[index]
                                                          .doorNo ??
                                                      ''),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: consumerInfo(
                                              index,
                                              'Detay',
                                              isSearched
                                                  ? searchedConsumerList[index]
                                                      .detail
                                                  : consumerList[index].detail),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: consumerInfo(
                                            index,
                                            'Kişi Sayısı',
                                            isSearched
                                                ? searchedConsumerList[index]
                                                    .peopleCount
                                                    .toString()
                                                : consumerList[index]
                                                    .peopleCount
                                                    .toString(),
                                          ),
                                        ),
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
                              horizontal: 10, vertical: 4),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
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
                                      ? searchedConsumerList[index].name
                                      : consumerList[index].name,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              error: (err, stack) {
                return Center(
                  child: Text('Hata ${err.toString()}'),
                );
              },
              loading: () => const CircularProgressIndicator()),
          //_productWidget(),
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
              color: Colors.black87,
              fontWeight: FontWeight.w700,
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
        Expanded(
            flex: 2,
            child: Text(
              field,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: LightColor.subTitleTextColor),
            )),
      ],
    );
  }
}
