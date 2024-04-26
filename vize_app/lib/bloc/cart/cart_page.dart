import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../client/client_cubit.dart';

List cartList = [];

class cartPage extends StatefulWidget {
  const cartPage({super.key, required this.newItem});

  final Map newItem;

  @override
  State<cartPage> createState() {
    newItem.isEmpty ? int : cartList.add(newItem);
    return _cartPageState();
  }
}

class _cartPageState extends State<cartPage> {
  late ClientCubit clientCubit;

  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
  }

  double priceUpdate() {
    String price = "";
    double total = 0.0;
    for (int i = 0; i < cartList.length; i++) {
      price = cartList[i]["price"].toString().replaceAll(r'$', '');
      total = total + int.parse(price);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: TextButton(
          // Go back
          onPressed: () => GoRouter.of(context).pop(),
          style: const ButtonStyle(
              overlayColor: MaterialStatePropertyAll(Colors.transparent)),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).colorScheme.primary,
                    offset: Offset.zero,
                    blurRadius: 1,
                    spreadRadius: 1,
                    blurStyle: BlurStyle.normal),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        title: Text(
          clientCubit.state.language == 'en' ? 'Cart' : 'Sepet',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          cartList.isNotEmpty
              ? Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              cartList.removeAt(index);
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.error,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              cartList[index]['image'],
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            cartList[index]["name"],
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Size: 8 UK',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiaryContainer,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondaryContainer,
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondary
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(6),
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      size: 17,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondaryContainer,
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondary
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(6),
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      size: 17,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                cartList[index]["price"],
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primaryContainer,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Expanded(
                  flex: 8,
                  child: Container(),
                ),
          Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      clientCubit.state.language == 'en' ? 'Total' : 'Toplam',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '\$${priceUpdate().toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontWeight: FontWeight.bold,
                        fontSize: 21.5,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      )),
      bottomNavigationBar: TextButton(
        onPressed: () => cartList,
        style: const ButtonStyle(
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
        ),
        child: Container(
          height: 60,
          margin: const EdgeInsets.only(
            bottom: 20,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.secondaryContainer,
                  Theme.of(context).colorScheme.secondary
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Center(
            child: Text(
              clientCubit.state.language == 'en' ? 'Check Out' : 'Onayla',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
