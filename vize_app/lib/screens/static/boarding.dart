import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/client/client_cubit.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  late ClientCubit clientCubit;

  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 196, 34),
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        './assets/images/boarding-image.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Başlık
                        Container(
                          child: Text(
                            clientCubit.state.language == 'en'
                                ? 'Discover Trendly New Clothes'
                                : 'Trend Olan Yeni Kıyafetleri Keşfedin',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                          ),
                        ),
                        // Açıklama
                        Container(
                          child: Text(
                            clientCubit.state.language == 'en'
                                ? 'This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of'
                                : 'Bu kitap, Rönesans döneminde çok popüler olan etik teorisi üzerine bir incelemedir. İlk satırı',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                          ),
                        ),
                        //Buton
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50))),
                          child: InkWell(
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 28,
                              color: Colors.white,
                            ),
                            onTap: () => GoRouter.of(context).push("/login"),
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
  }
}
