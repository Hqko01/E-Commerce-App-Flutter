// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_icon/gradient_icon.dart';

import '../client/client_cubit.dart';

List favList = [];

class favPage extends StatefulWidget {
  const favPage({super.key, required this.favItem});

  final Map favItem;
  @override
  State<favPage> createState() {
    favList.contains(favItem)
        ? favList
        : favItem.isEmpty
            ? favList
            : favList.add(favItem);
    return _favPageState();
  }
}

class _favPageState extends State<favPage> {
  late ClientCubit clientCubit;

  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        title: Text(
          clientCubit.state.language == 'en' ? 'Favorite' : 'Favoriler',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryContainer,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 20),
            child: Stack(
              children: [
                Icon(
                  Icons.notifications_rounded,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  size: 25,
                ),
                const Positioned(
                    left: 13,
                    child: Icon(
                      Icons.brightness_1,
                      size: 10,
                      color: Colors.red,
                    ))
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: favList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                setState(() {
                  favList.removeAt(index);
                });
              },
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    // image and star
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    favList[index]["image"],
                                  ),
                                  fit: BoxFit.contain,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Color.fromRGBO(255, 193, 7, 1),
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        favList[index]["star"],
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .errorContainer,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // name, price, favbutton
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Name, price
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  favList[index]["name"],
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  favList[index]["price"],
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            // favbutton
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(136, 254, 224, 215),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Padding(
                                padding: const EdgeInsets.all(9),
                                child: GradientIcon(
                                  offset: Offset.zero,
                                  icon: Icons.favorite,
                                  size: 19,
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                      Theme.of(context).colorScheme.secondary
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
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
              ),
            );
          },
        ),
      )),
    );
  }
}
