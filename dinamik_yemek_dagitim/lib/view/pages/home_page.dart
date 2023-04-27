import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/core/themes/theme.dart';
import 'package:dinamik_yemek_dagitim/extensions/extensions.dart';
import 'package:dinamik_yemek_dagitim/view/common/title_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
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
              text: 'Kayaönü mahallesi',
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _productWidget() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 10),
  //     width: AppTheme.fullWidth(context),
  //     height: AppTheme.fullWidth(context) * .7,
  //     child: GridView(
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 1,
  //           childAspectRatio: 4 / 3,
  //           mainAxisSpacing: 30,
  //           crossAxisSpacing: 20),
  //       padding: EdgeInsets.only(left: 20),
  //       scrollDirection: Axis.horizontal,
  //       children: AppData.productList
  //           .map(
  //             (product) => ProductCard(
  //               product: product,
  //               onSelected: (model) {
  //                 setState(() {
  //                   AppData.productList.forEach((item) {
  //                     item.isSelected = false;
  //                   });
  //                   model.isSelected = true;
  //                 });
  //               },
  //             ),
  //           )
  //           .toList(),
  //     ),
  //   );
  // }

  Widget _search() {
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
              child: const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Kişi Ara",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),
              ),
            ),
          ),
          const SizedBox(width: 20),
          _icon(Icons.filter_list, color: Colors.black54)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 210,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _search(),
              _categoryWidget(),
              //_productWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
