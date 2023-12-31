import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_fruits_and_vegetables_app/models/ProductModel.dart';
import 'package:online_fruits_and_vegetables_app/models/categories.dart';
import 'package:online_fruits_and_vegetables_app/presentation/details_screen/item_details_screen.dart';
import 'package:online_fruits_and_vegetables_app/widgets/slider1.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../helper/apiHelper.dart';
import '../theme/app_style.dart';
import '../utils/color_constant.dart';
import '../utils/image_constant.dart';
import '../utils/math_utils.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/CustomTextBox.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Categories> categories = <Categories>[];
  List<Autogenerated> productModel = <Autogenerated>[];
  bool loading = true;
  bool loadingP = true;
  var index = 0;
  int selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  getProductsFromCategory(String id) async {
    GetProductFromCategory getProductFromCategory = GetProductFromCategory();
    await getProductFromCategory.getProductsFromCategory(id);

    setState(() {
      productModel.clear();
      productModel = getProductFromCategory.list;
      loading = false;
    });
  }

  getCategories() async {
    GetCategory getCategory = GetCategory();
    await getCategory.getCategory();
    await getCategory.getProducts();
    categories = getCategory.category;
    productModel = getCategory.list;

    setState(() {
      loading = false;
      loadingP = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Icon(
                        color: Colors.black,
                        Icons.clear_all_rounded,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: CustomTextBox(
                    hint: "Search",
                    prefix: Icon(Icons.search, color: Colors.black),
                    suffix: Icon(
                      Icons.filter_list_outlined,
                      color: Colors.black38,
                    ),
                  ),
                ), //search
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: CarouselSlider(
                    items: [
                      //1st Image of Slider
                      Container(
                        child: const Slider1(),
                      ),
                      Container(
                        child: const Slider2(),
                      ),
                      Container(
                        child: const Slider3(),
                      ),
                    ],

                    //Slider Container properties
                    options: CarouselOptions(
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      scrollPhysics: PageScrollPhysics(),
                      autoPlayAnimationDuration: Duration(milliseconds: 4),
                      height: screenSize.height * 0.22,
                      viewportFraction: 1,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Our Categories",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(color: ColorConstant.whiteA700),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              loading
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              200,
                                      alignment: Alignment.center,
                                      child: const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.black,
                                        ),
                                      ),
                                    )
                                  // : Container(height:MediaQuery.of(context).size.height*2,color:Colors.blue),
                                  : Container(
                                      height: 35,
                                      child: ListView.builder(
                                        itemCount: categories.length,
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: index ==
                                                            selectedCategory
                                                        ? ColorConstant
                                                            .kSecondaryColor
                                                        : ColorConstant
                                                            .kbgColor),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        loading = true;
                                                        getProductsFromCategory(
                                                            categories[index]
                                                                .id
                                                                .toString());

                                                        selectedCategory =
                                                            index;
                                                      });
                                                    },
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        categories[index].name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5
                                                            ?.copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: index ==
                                                                      selectedCategory
                                                                  ? ColorConstant
                                                                      .kTextColor
                                                                  : Colors.black
                                                                      .withOpacity(
                                                                          0.4),
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10, top: 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Products",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              loadingP
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              200,
                                      alignment: Alignment.center,
                                      child: const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.black,
                                        ),
                                      ),
                                    )
                                  // : Container(height:MediaQuery.of(context).size.height*2,color:Colors.blue),
                                  : Container(
                                      height: 500,
                                      child: ResponsiveGridList(
                                        horizontalGridMargin: 10,
                                        verticalGridMargin: 50,
                                        minItemWidth: 100,
                                        minItemsPerRow: 2,
                                        maxItemsPerRow: 2,
                                        children: List.generate(
                                          productModel.length,
                                          (index) => GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ItemDetailsSreen(
                                                    item: productModel[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: IntrinsicWidth(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorConstant.black900,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        10.00,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Card(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    elevation: 0,
                                                    margin: EdgeInsets.all(0),
                                                    color:
                                                        ColorConstant.whiteA700,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        getHorizontalSize(
                                                          10.00,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              top:
                                                                  getVerticalSize(
                                                                11.00,
                                                              ),
                                                              right:
                                                                  getHorizontalSize(
                                                                10.00,
                                                              ),
                                                              bottom:
                                                                  getVerticalSize(
                                                                11.00,
                                                              ),
                                                            ),
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      Container(
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          getHorizontalSize(
                                                                        10.00,
                                                                      ),
                                                                      top:
                                                                          getVerticalSize(
                                                                        10.00,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            left:
                                                                                getHorizontalSize(
                                                                              16.09,
                                                                            ),
                                                                            right:
                                                                                getHorizontalSize(
                                                                              13.99,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl: productModel[index].images.isNotEmpty
                                                                                ? productModel[index].images[0].src
                                                                                : "https://i.postimg.cc/rF26WZpy/img-image-126-X199.png",
                                                                            height:
                                                                                getVerticalSize(
                                                                              192.00,
                                                                            ),
                                                                            width:
                                                                                getHorizontalSize(
                                                                              186.00,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              top: getVerticalSize(
                                                                                8.17,
                                                                              ),
                                                                              bottom: getVerticalSize(
                                                                                0.01,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Text(
                                                                                  productModel[index].name.toString(),
                                                                                  style: AppStyle.txtMontserratMedium16.copyWith(
                                                                                    fontSize: getFontSize(
                                                                                      14,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(
                                                                                    top: getVerticalSize(
                                                                                      6.26,
                                                                                    ),
                                                                                    right: getHorizontalSize(
                                                                                      10.00,
                                                                                    ),
                                                                                  ),
                                                                                  child:      Align(
                                                                                    alignment: Alignment.center,
                                                                                    child: Text.rich(
                                                                                      TextSpan(
                                                                                      text: '',

                                                                                      children: <TextSpan>[
                                                                                        TextSpan(
                                                                                          text:productModel[index].regularPrice.toString()==""?"":" ₹ " +productModel[index].regularPrice.toString(),
                                                                                          style: const TextStyle(
                                                                                            color: Colors.grey,
                                                                                            decoration: TextDecoration.lineThrough,
                                                                                          ),
                                                                                        ),
                                                                                        TextSpan(
                                                                                          text:"   ₹ "+ productModel[index].price.toString(),
                                                                                          style: TextStyle(fontWeight: FontWeight.bold)
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    ),
                                                                                  )

                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        right:
                                                                            getHorizontalSize(
                                                                          10.00,
                                                                        ),
                                                                        bottom:
                                                                            getVerticalSize(
                                                                          10.00,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        decoration: const BoxDecoration(
                                                                            color:
                                                                                ColorConstant.kSecondaryColor,
                                                                            borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
                                                                        height:
                                                                            getVerticalSize(
                                                                          41.00,
                                                                        ),
                                                                        width:
                                                                            getHorizontalSize(
                                                                          68.17,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left:
                                                                  getHorizontalSize(
                                                                7.00,
                                                              ),
                                                              top:
                                                                  getVerticalSize(
                                                                20.00,
                                                              ),
                                                              right:
                                                                  getHorizontalSize(
                                                                10.00,
                                                              ),
                                                              bottom:
                                                                  getVerticalSize(
                                                                14.00,
                                                              ),
                                                            ),
                                                            child: Container(
                                                              child: Text(
                                                                "${calculatepersentage(productModel[index].price.toString(), productModel[index].regularPrice.toString())} %",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .txtMontserratSemiBold14WhiteA700
                                                                    .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      getFontSize(
                                                                    14,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                            ],
                          )
                        ])),
              ]),
            )));
  }

  String calculatepersentage(String price, String regular_price) {
    String per = "0";
    Double perD;
    if (price == "" || regular_price == "") {
      per = "0";
    } else {
      per = (((int.parse(regular_price) - int.parse(price)) /
                  int.parse(regular_price)) *
              100)
          .toString();
    }
    return per;
  }
}
