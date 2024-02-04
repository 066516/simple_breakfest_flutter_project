import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_breakfest_flutter_project/models/category.dart';
import 'package:simple_breakfest_flutter_project/models/diet.dart';
import 'package:simple_breakfest_flutter_project/models/popular_model.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> poplarDiets = [];
  void _getCategries() {
    categories = CategoryModel.getCategories();
  }

  void _getDiets() {
    diets = DietModel.getDiets();
    poplarDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getCategries();
    _getDiets();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(children: [
        _SearchBox(),
        const SizedBox(
          height: 40,
        ),
        _CategoriesSection(),
        const SizedBox(
          height: 40,
        ),
        _dietsSection(),
        const SizedBox(
          height: 40,
        ),
        _popularDiets(),
        const SizedBox(
          height: 40,
        ),
      ]),
    );
  }

  Column _popularDiets() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Popular',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemBuilder: (context, index) {
              return Container(
                height: 115,
                decoration: BoxDecoration(
                    color: poplarDiets[index].boxIsSelected
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: poplarDiets[index].boxIsSelected
                        ? [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.07),
                                offset: const Offset(0, 10),
                                blurRadius: 40,
                                spreadRadius: 0)
                          ]
                        : []),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      poplarDiets[index].iconPath,
                      width: 65,
                      height: 65,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          poplarDiets[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        Text(
                          poplarDiets[index].level +
                              " | " +
                              poplarDiets[index].duration +
                              " | " +
                              poplarDiets[index].calorie,
                          style: const TextStyle(
                              color: Color(0xff7B6F72),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    /////////
                    GestureDetector(
                      onTap: () {
                        print('9iw');
                      },
                      child: SvgPicture.asset(
                        'assets/icons/button.svg',
                        width: 30,
                        height: 30,
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
            itemCount: poplarDiets.length,
          )
        ],
      );
  }

  Column _dietsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Recommendation \n  for Diet",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 240,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, right: 20),
              itemBuilder: (context, index) {
                return Container(
                    width: 240,
                    decoration: BoxDecoration(
                        color: diets[index].boxColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(diets[index].iconPath),
                          Column(
                            children: [
                              Text(
                                diets[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                              Text(
                                diets[index].level +
                                    " | " +
                                    diets[index].duration +
                                    " | " +
                                    diets[index].calorie,
                                style: const TextStyle(
                                    color: Color(0xff7B6F72),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Container(
                            height: 45,
                            width: 130,
                            child: Center(
                                child: Text(
                              'View',
                              style: TextStyle(
                                  color: diets[index].viewIsSelected
                                      ? Colors.white
                                      : const Color(0xffC5BBF2),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  diets[index].viewIsSelected
                                      ? const Color(0xff9DCEFF)
                                      : Colors.transparent,
                                  diets[index].viewIsSelected
                                      ? const Color(0xff92A3FD)
                                      : Colors.transparent,
                                ]),
                                borderRadius: BorderRadius.circular(20)),
                          )
                        ]));
              },
              separatorBuilder: (context, index) => const SizedBox(
                    width: 25,
                  ),
              itemCount: diets.length),
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Column _CategoriesSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text(
          'Category',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        height: 150,
        // color: Colors.green,
        child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => const SizedBox(width: 25),
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                    color: categories[index].boxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        categories[index].iconPath,

                        // width: 50,
                        // height: 50,
                      ),
                    ),
                    Text(
                      categories[index].name,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )
                  ],
                ),
              );
            }),
      )
    ]);
  }

  // ignore: non_constant_identifier_names
  Container _SearchBox() {
    return Container(
        margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          ),
        ]),
        child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(
                Icons.filter_list,
              ),
              hintText: "Search for products or brands",
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none)),
        ));
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        "Breakfest ",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/Arrow.svg',
            height: 20,
            width: 20,
          ),
          decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
            decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
