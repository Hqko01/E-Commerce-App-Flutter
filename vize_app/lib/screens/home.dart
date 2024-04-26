import 'dart:convert';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/cart/cart_page.dart';
import '../bloc/cart/fav_page.dart';
import '../bloc/client/client_cubit.dart';
import '../bloc/products/product_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

List<String> genderOptions = ['Male', 'Female'];
List _items = [];

class _HomeScreenState extends State<HomeScreen> {
  late ClientCubit clientCubit;

  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
  }

  String currentGenderOptions = genderOptions[1];

  Future<void> readJson(String category) async {
    final String response =
        await rootBundle.loadString('./assets/json/products.json');
    final data = await json.decode(response);
    setState(() {
      _items = data[category];
    });
  }

  var _categoryIndex = "";
  _onCategoryTapped(String text) {
    setState(() {
      _categoryIndex = text;
      readJson(_categoryIndex);
    });
  }

  int _selectedIndex = 0;
  int _backIndex = 0;
  _onItemTapped(int index) {
    setState(() {
      if (index == 3) {
        _selectedIndex = index;
      } else if (index == 2) {
        _selectedIndex = index;
      } else {
        _selectedIndex = index;
        _backIndex = index;
      }
    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  toggleDrawer() async {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    @override
    final List<Widget> _widgetOptions = <Widget>[
      HomeScreen(context),
      cartPage(newItem: {}),
      Container(),
      ProfileScreen(context),
    ];

    return BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: _selectedIndex == 3
            ? AppBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                leading: IconButton(
                  onPressed: () => _onItemTapped(_backIndex),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
                title: Text(
                  clientCubit.state.language == 'en'
                      ? 'Personal Profile'
                      : 'Kullanıcı Profili',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    fontFamily: AutofillHints.jobTitle,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              // Dark mode Light mode shadow renk ayarı
                              color: clientCubit.state.darkMode
                                  ? Theme.of(context).colorScheme.errorContainer
                                  : Theme.of(context).colorScheme.primary,
                              spreadRadius: 0,
                              blurRadius: 8,
                            ),
                          ],
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: IconButton(
                        onPressed: () => _items,
                        icon: Stack(
                          children: [
                            Icon(
                              Icons.edit_square,
                              size: 25,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                          ],
                        ),
                        iconSize: 25,
                      ),
                    ),
                  )
                ],
              )
            : _selectedIndex == 2
                ? AppBar(
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(25),
                      ),
                    ),
                    shadowColor: Theme.of(context).colorScheme.primary,
                    toolbarHeight: 80,
                    backgroundColor: Theme.of(context).colorScheme.error,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: IconButton(
                        onPressed: () => _onItemTapped(_backIndex),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    './assets/images/profile-photo.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Angela Alonso',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              clientCubit.state.language == 'en'
                                  ? 'Active'
                                  : 'Çevrimiçi',
                              style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 15,
                        ),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  // Dark mode Light mode shadow renk ayarı
                                  color: clientCubit.state.darkMode
                                      ? Theme.of(context)
                                          .colorScheme
                                          .errorContainer
                                      : const Color.fromARGB(255, 87, 87, 87),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                ),
                              ],
                              color: Theme.of(context).colorScheme.tertiary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50))),
                          child: IconButton(
                            onPressed: () => _items,
                            icon: Stack(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 18,
                                  color: clientCubit.state.darkMode
                                      ? Theme.of(context)
                                          .colorScheme
                                          .errorContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                        ),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  // Dark mode Light mode shadow renk ayarı
                                  color: clientCubit.state.darkMode
                                      ? Theme.of(context)
                                          .colorScheme
                                          .errorContainer
                                      : const Color.fromARGB(255, 87, 87, 87),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                ),
                              ],
                              color: Theme.of(context).colorScheme.tertiary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50))),
                          child: IconButton(
                            onPressed: () => _items,
                            icon: Stack(
                              children: [
                                Icon(
                                  Icons.videocam_sharp,
                                  size: 18,
                                  color: clientCubit.state.darkMode
                                      ? Theme.of(context)
                                          .colorScheme
                                          .errorContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : _selectedIndex == 1
                    ? AppBar(
                        automaticallyImplyLeading: false,
                        toolbarHeight: 0,
                      )
                    : _selectedIndex == 0
                        ? AppBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            leading: Builder(
                              builder: (context) => Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.notes_rounded,
                                      size: 30,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                    ),
                                    onPressed: () =>
                                        Scaffold.of(context).openDrawer(),
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            // Dark mode Light mode shadow renk ayarı
                                            color: Theme.of(context)
                                                        .colorScheme
                                                        .primary ==
                                                    const Color.fromRGBO(
                                                        250, 250, 250, 1)
                                                ? const Color.fromRGBO(
                                                    235, 235, 235, 1)
                                                : const Color.fromARGB(
                                                    255, 87, 87, 87),
                                            spreadRadius: 0,
                                            blurRadius: 8),
                                      ],
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: IconButton(
                                    onPressed: () => _items,
                                    icon: Stack(
                                      children: [
                                        const Icon(
                                          Icons.notifications_none_rounded,
                                          size: 25,
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Icon(
                                            Icons.brightness_1,
                                            size: 8,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        )
                                      ],
                                    ),
                                    iconSize: 25,
                                  ),
                                ),
                              )
                            ],
                          )
                        : AppBar(),
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 85,
                          height: 85,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    './assets/images/profile-photo.jpg',
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        Text(
                          "Angela Alonso",
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () => {
                            toggleDrawer(),
                            setState(() {
                              _selectedIndex = 0;
                            })
                          },
                          style: ButtonStyle(
                            overlayColor: clientCubit.state.darkMode
                                ? MaterialStatePropertyAll(Theme.of(context)
                                    .colorScheme
                                    .errorContainer)
                                : MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.tertiary),
                            padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(0),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: clientCubit.state.darkMode
                                      ? Theme.of(context)
                                          .colorScheme
                                          .errorContainer
                                      : Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  clientCubit.state.language == 'en'
                                      ? 'Home'
                                      : 'Ev',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: clientCubit.state.darkMode
                                        ? Theme.of(context)
                                            .colorScheme
                                            .errorContainer
                                        : Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => favPage(favItem: {}))),
                          style: ButtonStyle(
                            overlayColor: clientCubit.state.darkMode
                                ? MaterialStatePropertyAll(Theme.of(context)
                                    .colorScheme
                                    .errorContainer)
                                : MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.tertiary),
                            padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(0),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: clientCubit.state.darkMode
                                      ? Theme.of(context)
                                          .colorScheme
                                          .errorContainer
                                      : Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  clientCubit.state.language == 'en'
                                      ? 'Favorites'
                                      : 'Favoriler',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: clientCubit.state.darkMode
                                        ? Theme.of(context)
                                            .colorScheme
                                            .errorContainer
                                        : Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () => {
                            toggleDrawer(),
                            setState(() {
                              _selectedIndex = 1;
                            })
                          },
                          style: ButtonStyle(
                            overlayColor: clientCubit.state.darkMode
                                ? MaterialStatePropertyAll(Theme.of(context)
                                    .colorScheme
                                    .errorContainer)
                                : MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.tertiary),
                            padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(0),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: clientCubit.state.darkMode
                                      ? Theme.of(context)
                                          .colorScheme
                                          .errorContainer
                                      : Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  clientCubit.state.language == 'en'
                                      ? 'Cart'
                                      : 'Sepet',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: clientCubit.state.darkMode
                                        ? Theme.of(context)
                                            .colorScheme
                                            .errorContainer
                                        : Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () => {
                            toggleDrawer(),
                            setState(() {
                              _selectedIndex = 3;
                            })
                          },
                          style: ButtonStyle(
                            overlayColor: clientCubit.state.darkMode
                                ? MaterialStatePropertyAll(Theme.of(context)
                                    .colorScheme
                                    .errorContainer)
                                : MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.tertiary),
                            padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(0),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: clientCubit.state.darkMode
                                      ? Theme.of(context)
                                          .colorScheme
                                          .errorContainer
                                      : Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  clientCubit.state.language == 'en'
                                      ? 'Profile'
                                      : 'Profil',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: clientCubit.state.darkMode
                                        ? Theme.of(context)
                                            .colorScheme
                                            .errorContainer
                                        : Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  width: double.infinity,
                                  height: 200,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        if (clientCubit.state.darkMode)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: IconButton(
                                                onPressed: () {
                                                  clientCubit.changeDarkMode(
                                                      darkMode: false);
                                                },
                                                icon: Icon(Icons.sunny)),
                                          )
                                        else
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: IconButton(
                                                onPressed: () {
                                                  clientCubit.changeDarkMode(
                                                      darkMode: true);
                                                },
                                                icon: Icon(Icons.nightlight)),
                                          ),
                                      ]),
                                );
                              }),
                          style: ButtonStyle(
                            overlayColor: clientCubit.state.darkMode
                                ? MaterialStatePropertyAll(Theme.of(context)
                                    .colorScheme
                                    .errorContainer)
                                : MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.tertiary),
                            padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(0),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: clientCubit.state.darkMode
                                      ? Theme.of(context)
                                          .colorScheme
                                          .errorContainer
                                      : Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  clientCubit.state.language == 'en'
                                      ? 'Theme Mode'
                                      : 'Tema Ayarları',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: clientCubit.state.darkMode
                                        ? Theme.of(context)
                                            .colorScheme
                                            .errorContainer
                                        : Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                width: double.infinity,
                                height: 200,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: ElevatedButton(
                                            onPressed: clientCubit
                                                        .state.language ==
                                                    "en"
                                                ? null
                                                : () {
                                                    clientCubit.changeLanguage(
                                                        language: "en");
                                                  },
                                            child: Text("English")),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: ElevatedButton(
                                            onPressed: clientCubit
                                                        .state.language ==
                                                    "tr"
                                                ? null
                                                : () {
                                                    clientCubit.changeLanguage(
                                                        language: "tr");
                                                  },
                                            child: Text("Turkce")),
                                      ),
                                    ]),
                              );
                            },
                          ),
                          style: ButtonStyle(
                            overlayColor: clientCubit.state.darkMode
                                ? MaterialStatePropertyAll(Theme.of(context)
                                    .colorScheme
                                    .errorContainer)
                                : MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.tertiary),
                            padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(0),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: clientCubit.state.darkMode
                                      ? Theme.of(context)
                                          .colorScheme
                                          .errorContainer
                                      : Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  clientCubit.state.language == 'en'
                                      ? 'Language'
                                      : 'Dİl Ayarları',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: clientCubit.state.darkMode
                                        ? Theme.of(context)
                                            .colorScheme
                                            .errorContainer
                                        : Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () => {
                            GoRouter.of(context).push('/login'),
                          },
                          style: ButtonStyle(
                            overlayColor: clientCubit.state.darkMode
                                ? MaterialStatePropertyAll(Theme.of(context)
                                    .colorScheme
                                    .errorContainer)
                                : MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.tertiary),
                            padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(0),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: clientCubit.state.darkMode
                                      ? Theme.of(context)
                                          .colorScheme
                                          .errorContainer
                                      : Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  clientCubit.state.language == 'en'
                                      ? 'Log Out'
                                      : 'Çıkış Yap',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: clientCubit.state.darkMode
                                        ? Theme.of(context)
                                            .colorScheme
                                            .errorContainer
                                        : Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: _selectedIndex == 2
            ? MessageScreenBottomBar(context)
            : _selectedIndex == 1
                ? Container(
                    height: 0,
                  )
                : BottomNavBar(context),
      );
    });
  }

  // Message Screen Bottom
  Container MessageScreenBottomBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      child: Expanded(
        flex: 1,
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.only(left: 15, top: 5, bottom: 15),
                child: TextField(
                  cursorColor: Theme.of(context).colorScheme.primaryContainer,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.attachment_outlined,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      size: 25,
                    ),
                    suffixIcon: Icon(
                      Icons.tag_faces_rounded,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      size: 25,
                    ),
                    hintText: clientCubit.state.language == 'en'
                        ? "Type somnthing.."
                        : "Bir Şeyler Yaz..",
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      fontSize: 13,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  right: 15,
                  bottom: 15,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondaryContainer,
                          Theme.of(context).colorScheme.secondary
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Center(
                      child: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

// Profile Screen
  SingleChildScrollView ProfileScreen(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: 850,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: AssetImage('./assets/images/profile-photo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Column(
                  children: [
                    // Gender
                    SizedBox(
                        height: 110,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    clientCubit.state.language == 'en'
                                        ? 'Gender'
                                        : 'Cinsiyetin',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      fontFamily: AutofillHints.name,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                currentGenderOptions == 'Male'
                                                    ? clientCubit.state.darkMode
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .errorContainer
                                                        : const Color.fromARGB(
                                                            255, 255, 236, 229)
                                                    : clientCubit.state.darkMode
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .errorContainer
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .tertiary,
                                            boxShadow: [
                                              BoxShadow(
                                                // Dark mode Light mode shadow renk ayarı
                                                color:
                                                    clientCubit.state.darkMode
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .errorContainer
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                spreadRadius: 0,
                                                blurRadius: 8,
                                              ),
                                            ],
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              clientCubit.state.language == 'en'
                                                  ? 'Male'
                                                  : 'Erkek',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                fontFamily: AutofillHints.name,
                                                fontSize: 15,
                                              ),
                                            ),
                                            leading: Radio(
                                              value: genderOptions[0],
                                              groupValue: currentGenderOptions,
                                              onChanged: (value) {
                                                setState(() {
                                                  currentGenderOptions =
                                                      value.toString();
                                                });
                                              },
                                              activeColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                currentGenderOptions == 'Female'
                                                    ? clientCubit.state.darkMode
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .errorContainer
                                                        : const Color.fromARGB(
                                                            255, 255, 236, 229)
                                                    : clientCubit.state.darkMode
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .errorContainer
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .tertiary,
                                            boxShadow: [
                                              BoxShadow(
                                                // Dark mode Light mode shadow renk ayarı
                                                color:
                                                    clientCubit.state.darkMode
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .errorContainer
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                spreadRadius: 0,
                                                blurRadius: 8,
                                              ),
                                            ],
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              clientCubit.state.language == 'en'
                                                  ? 'Female'
                                                  : 'Kadın',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                fontFamily: AutofillHints.name,
                                                fontSize: 15,
                                              ),
                                            ),
                                            leading: Radio(
                                              value: genderOptions[1],
                                              groupValue: currentGenderOptions,
                                              onChanged: (value) {
                                                setState(() {
                                                  currentGenderOptions =
                                                      value.toString();
                                                });
                                              },
                                              activeColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    // Name
                    SizedBox(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 30,
                                bottom: 10,
                              ),
                              child: Text(
                                clientCubit.state.language == 'en'
                                    ? 'Name'
                                    : 'Adın',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontFamily: AutofillHints.name,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              height: 55,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                cursorColor: Theme.of(context)
                                    .colorScheme
                                    .errorContainer,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer),
                                decoration: InputDecoration(
                                  hintText: 'Angela Alonso',
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer,
                                    size: 20,
                                  ),
                                  fillColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    // Email
                    SizedBox(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 30,
                                bottom: 10,
                              ),
                              child: Text(
                                clientCubit.state.language == 'en'
                                    ? 'Email'
                                    : 'E-Posta',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontFamily: AutofillHints.name,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              height: 55,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                cursorColor: Theme.of(context)
                                    .colorScheme
                                    .errorContainer,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer),
                                decoration: InputDecoration(
                                  hintText: 'angelaalonso12@gmail.com',
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer,
                                    size: 20,
                                  ),
                                  fillColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    // Phone
                    SizedBox(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 30,
                                bottom: 10,
                              ),
                              child: Text(
                                clientCubit.state.language == 'en'
                                    ? 'Phone Number'
                                    : 'Telefon Numaran',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontFamily: AutofillHints.name,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              height: 55,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                cursorColor: Theme.of(context)
                                    .colorScheme
                                    .errorContainer,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer),
                                decoration: InputDecoration(
                                  hintText: '+905333333333',
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer,
                                    size: 20,
                                  ),
                                  fillColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    // address
                    SizedBox(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 30,
                                bottom: 10,
                              ),
                              child: Text(
                                clientCubit.state.language == 'en'
                                    ? 'Address'
                                    : 'Adresin',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  fontFamily: AutofillHints.name,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              height: 55,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                cursorColor: Theme.of(context)
                                    .colorScheme
                                    .errorContainer,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer),
                                decoration: InputDecoration(
                                  hintText:
                                      '1901 Thronridge Cir. Shilah, Hawaii 81063',
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.location_on,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer,
                                    size: 20,
                                  ),
                                  fillColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Home Screen
  SafeArea HomeScreen(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 735,
        child: Column(
          children: [
            // search ve search settings
            SearchSettings(context),
            // kategori
            Categorys(context),
            // Ürünler
            Output()
          ],
        ),
      ),
    );
  }

// Category Output
  Expanded Output() {
    return Expanded(
      flex: 8,
      child: _items.isNotEmpty
          ? Expanded(
              flex: 8,
              // Popular
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  clientCubit.state.language == 'en'
                                      ? 'Popular'
                                      : 'Popüler',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AutofillHints.name,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            flex: 6,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _items.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Card(
                                    child: _items[index]["type"] == 'popular'
                                        ? Container(
                                            width: 170,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: clientCubit
                                                            .state.darkMode
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .errorContainer
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .tertiary,
                                                    offset: Offset.zero,
                                                    blurRadius: 1,
                                                    spreadRadius: 2,
                                                    blurStyle:
                                                        BlurStyle.normal),
                                              ],
                                            ),
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: TextButton(
                                                    onPressed: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                detailPage(
                                                                    item: _items[
                                                                        index]))),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          height: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  7.5),
                                                            ),
                                                          ),
                                                          child: Image.asset(
                                                            _items[index]
                                                                ["image"],
                                                            fit: BoxFit.cover,
                                                            alignment: Alignment
                                                                .topCenter,
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 3,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    // Name
                                                                    Text(
                                                                      _items[index]
                                                                          [
                                                                          'name'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .tertiaryContainer),
                                                                    ),
                                                                    // Price
                                                                    Text(
                                                                      _items[index]
                                                                          [
                                                                          'price'],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              // Add Cart
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    TextButton(
                                                                  onPressed: () => Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              cartPage(newItem: _items[index]))),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      gradient:
                                                                          LinearGradient(
                                                                        colors: [
                                                                          Theme.of(context)
                                                                              .colorScheme
                                                                              .secondaryContainer,
                                                                          Theme.of(context)
                                                                              .colorScheme
                                                                              .secondary
                                                                        ],
                                                                        begin: Alignment
                                                                            .topCenter,
                                                                        end: Alignment
                                                                            .bottomCenter,
                                                                      ),
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            8),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          9.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .shopping_cart,
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .error,
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                    top: 10,
                                                    left: 10,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: clientCubit
                                                                .state.darkMode
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .errorContainer
                                                            : Theme.of(context)
                                                                .colorScheme
                                                                .tertiary,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                              size: 15,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              _items[index]
                                                                  ["star"],
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                color: clientCubit
                                                                        .state
                                                                        .darkMode
                                                                    ? Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .tertiary
                                                                    : Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .errorContainer,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    /* leading: Text(_items[index]["image"]), */
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                clientCubit.state.language == 'en'
                                    ? 'Products'
                                    : 'Ürünler',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AutofillHints.name,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: ListView.builder(
                                itemCount: _items.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      style: const ButtonStyle(
                                          padding: MaterialStatePropertyAll(
                                              EdgeInsets.all(0))),
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => detailPage(
                                                  item: _items[index]))),
                                      child: Container(
                                        width: double.infinity,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 20,
                                                ),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Image.asset(
                                                        _items[index]
                                                            ['image'])),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  child: Stack(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            _items[index]
                                                                ['name'],
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  AutofillHints
                                                                      .name,
                                                            ),
                                                          ),
                                                          Text(
                                                            _items[index]
                                                                ['comment'],
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .tertiaryContainer,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  AutofillHints
                                                                      .name,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                _items[index]
                                                                    ['price'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onPrimary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 13,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 30,
                                                              ),
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: clientCubit
                                                                          .state.darkMode
                                                                      ? Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary
                                                                      : Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .tertiary,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5.0),
                                                                  child: Row(
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: Colors
                                                                            .amber,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        _items[index]
                                                                            [
                                                                            "star"],
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color: clientCubit.state.darkMode
                                                                              ? Theme.of(context).colorScheme.tertiary
                                                                              : Theme.of(context).colorScheme.errorContainer,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Positioned(
                                                        top: 20,
                                                        right: 0,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondaryContainer,
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary
                                                              ],
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  8),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(9.0),
                                                            child: Icon(
                                                              Icons
                                                                  .shopping_cart,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .error,
                                                              size: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : _onCategoryTapped('shirt'),
    );
  }

// Category Selector
  Expanded Categorys(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 90,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: clientCubit.state.darkMode
                          ? Theme.of(context).colorScheme.errorContainer
                          : Theme.of(context).colorScheme.tertiary,
                      offset: Offset.zero,
                      blurRadius: 1,
                      spreadRadius: 2,
                      blurStyle: BlurStyle.normal),
                ],
                border: _categoryIndex == "shirt"
                    ? Border.all(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        width: 0.5,
                        style: BorderStyle.solid,
                      )
                    : Border.all(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        width: 1,
                        style: BorderStyle.none,
                      ),
              ),
              child: TextButton(
                onPressed: () => _onCategoryTapped('shirt'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(7.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Theme.of(context).colorScheme.primary ==
                                const Color.fromRGBO(250, 250, 250, 1)
                            ? Image.asset(
                                './assets/icons/shirt_icon_black.png',
                              )
                            : Image.asset(
                                './assets/icons/shirt_icon_white.png',
                              ),
                      ),
                    ),
                    Container(
                      child: Text(
                        clientCubit.state.language == 'en'
                            ? 'Shirt'
                            : 'T-shirt',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 90,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: clientCubit.state.darkMode
                          ? Theme.of(context).colorScheme.errorContainer
                          : Theme.of(context).colorScheme.tertiary,
                      offset: Offset.zero,
                      blurRadius: 1,
                      spreadRadius: 2,
                      blurStyle: BlurStyle.normal),
                ],
                border: _categoryIndex == "pants"
                    ? Border.all(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        width: 0.5,
                        style: BorderStyle.solid,
                      )
                    : Border.all(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        width: 1,
                        style: BorderStyle.none,
                      ),
              ),
              child: TextButton(
                onPressed: () => _onCategoryTapped('pants'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(7.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Theme.of(context).colorScheme.primary ==
                                const Color.fromRGBO(250, 250, 250, 1)
                            ? Image.asset(
                                './assets/icons/pant_icon_black.png',
                              )
                            : Image.asset(
                                './assets/icons/pant_icon_white.png',
                              ),
                      ),
                    ),
                    Container(
                      child: Text(
                        clientCubit.state.language == 'en'
                            ? 'Pants'
                            : 'Pantolon',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 90,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: clientCubit.state.darkMode
                          ? Theme.of(context).colorScheme.errorContainer
                          : Theme.of(context).colorScheme.tertiary,
                      offset: Offset.zero,
                      blurRadius: 1,
                      spreadRadius: 2,
                      blurStyle: BlurStyle.normal),
                ],
                border: _categoryIndex == "shos"
                    ? Border.all(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        width: 0.5,
                        style: BorderStyle.solid,
                      )
                    : Border.all(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        width: 1,
                        style: BorderStyle.none,
                      ),
              ),
              child: TextButton(
                onPressed: () => _onCategoryTapped('shos'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(7.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Theme.of(context).colorScheme.primary ==
                                const Color.fromRGBO(250, 250, 250, 1)
                            ? Image.asset(
                                './assets/icons/shos_icon_black.png',
                              )
                            : Image.asset(
                                './assets/icons/shos_icon_white.png',
                              ),
                      ),
                    ),
                    Container(
                      child: Text(
                        clientCubit.state.language == 'en'
                            ? 'Shos'
                            : 'Ayakkabı',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 90,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: clientCubit.state.darkMode
                          ? Theme.of(context).colorScheme.errorContainer
                          : Theme.of(context).colorScheme.tertiary,
                      offset: Offset.zero,
                      blurRadius: 1,
                      spreadRadius: 2,
                      blurStyle: BlurStyle.normal),
                ],
                border: _categoryIndex == "dress"
                    ? Border.all(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        width: 0.5,
                        style: BorderStyle.solid,
                      )
                    : Border.all(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        width: 1,
                        style: BorderStyle.none,
                      ),
              ),
              child: TextButton(
                onPressed: () => _onCategoryTapped('dress'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(7.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Theme.of(context).colorScheme.primary ==
                                const Color.fromRGBO(250, 250, 250, 1)
                            ? Image.asset(
                                './assets/icons/dress_icon_black.png',
                              )
                            : Image.asset(
                                './assets/icons/dress_icon_white.png',
                              ),
                      ),
                    ),
                    Container(
                      child: Text(
                        clientCubit.state.language == 'en' ? 'Dress' : 'Elbise',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Search And Search Settings
  Expanded SearchSettings(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // search
            Expanded(
              flex: 10,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: clientCubit.state.darkMode
                            ? Theme.of(context).colorScheme.errorContainer
                            : Theme.of(context).colorScheme.tertiary,
                        offset: Offset.zero,
                        blurRadius: 1,
                        spreadRadius: 2,
                        blurStyle: BlurStyle.normal),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    hintText:
                        clientCubit.state.language == 'en' ? "Search" : "Ara",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            // search settings
            Expanded(
              flex: 2,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: clientCubit.state.darkMode
                            ? Theme.of(context).colorScheme.errorContainer
                            : Theme.of(context).colorScheme.tertiary,
                        offset: Offset.zero,
                        blurRadius: 1,
                        spreadRadius: 2,
                        blurStyle: BlurStyle.normal),
                  ],
                ),
                child: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//BottomNavBar
  Container BottomNavBar(BuildContext context) {
    return Container(
        height: 75,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                // Dark mode Light mode shadow renk ayarı
                color: Theme.of(context).colorScheme.primary ==
                        const Color.fromRGBO(250, 250, 250, 1)
                    ? const Color.fromRGBO(225, 225, 225, 1)
                    : const Color.fromARGB(255, 87, 87, 87),
                spreadRadius: 0,
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            currentIndex: _selectedIndex,
            onTap: (index) => _onItemTapped(index),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: GradientIcon(
                  offset: Offset.zero,
                  icon: Icons.home_rounded,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiaryContainer,
                      Theme.of(context).colorScheme.tertiaryContainer
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  size: 30,
                ),
                activeIcon: GradientIcon(
                  offset: Offset.zero,
                  icon: Icons.home_rounded,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondaryContainer,
                      Theme.of(context).colorScheme.secondary
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  size: 30,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: GradientIcon(
                  offset: Offset.zero,
                  icon: Icons.shopping_cart,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiaryContainer,
                      Theme.of(context).colorScheme.tertiaryContainer
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  size: 30,
                ),
                activeIcon: GradientIcon(
                  offset: Offset.zero,
                  icon: Icons.shopping_cart,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondaryContainer,
                      Theme.of(context).colorScheme.secondary
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  size: 30,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: GradientIcon(
                  offset: Offset.zero,
                  icon: Icons.message,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiaryContainer,
                      Theme.of(context).colorScheme.tertiaryContainer
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  size: 30,
                ),
                activeIcon: GradientIcon(
                  offset: Offset.zero,
                  icon: Icons.message,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondaryContainer,
                      Theme.of(context).colorScheme.secondary
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  size: 30,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: GradientIcon(
                  offset: Offset.zero,
                  icon: Icons.person,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiaryContainer,
                      Theme.of(context).colorScheme.tertiaryContainer
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  size: 30,
                ),
                activeIcon: GradientIcon(
                  offset: Offset.zero,
                  icon: Icons.person,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondaryContainer,
                      Theme.of(context).colorScheme.secondary
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  size: 30,
                ),
                label: "",
              ),
            ],
          ),
        ));
  }
}
