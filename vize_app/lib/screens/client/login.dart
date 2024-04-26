import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/client/client_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late ClientCubit clientCubit;

  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('./assets/images/login-image.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
          ),
        ),
        Expanded(
            flex: 2,
            // Klavye açıldığında taşmayı engellemek için scroll özelliğini kullandım
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        clientCubit.state.language == 'en'
                            ? 'Welcome back. Angela You`ve been missed'
                            : 'Tekrardan Hoşgeldin. Angale Seni özledik!',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    // input form alanı
                    child: Container(
                      child: Column(
                        children: [
                          // mail input
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  clientCubit.state.language == 'en'
                                      ? ' Email'
                                      : 'E-posta',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 55,
                                  child: TextField(
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .errorContainer,
                                    ),
                                    cursorColor: Theme.of(context)
                                        .colorScheme
                                        .errorContainer,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        size: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .errorContainer,
                                      ),
                                      hintText:
                                          clientCubit.state.language == 'en'
                                              ? 'youremail@gmail.com'
                                              : 'epostan@gmail.com',
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .errorContainer,
                                      ),
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // password input
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  clientCubit.state.language == 'en'
                                      ? 'Password'
                                      : 'Şifre',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 55,
                                  child: TextField(
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .errorContainer,
                                    ),
                                    // Girilen değeri gizleme
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    cursorColor: Theme.of(context)
                                        .colorScheme
                                        .errorContainer,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.visibility_off_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .errorContainer,
                                        size: 20,
                                      ),
                                      suffixIconColor: Theme.of(context)
                                          .colorScheme
                                          .tertiaryContainer,
                                      hintText:
                                          clientCubit.state.language == 'en'
                                              ? 'Password'
                                              : 'Şifre',
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .errorContainer,
                                      ),
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // button
                          Container(
                            width: double.infinity,
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
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            // Log In butonu
                            child: ElevatedButton(
                                onPressed: () =>
                                    GoRouter.of(context).push('/home'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent),
                                child: Text(
                                  clientCubit.state.language == 'en'
                                      ? 'Log In'
                                      : 'Giriş Yap',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // create account or forgot password
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  clientCubit.state.language == 'en'
                                      ? 'Create Account'
                                      : 'Hesap Oluştur',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer),
                                ),
                                Text(
                                  clientCubit.state.language == 'en'
                                      ? 'Or'
                                      : 'Ya Da',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiaryContainer),
                                ),
                                Text(
                                  clientCubit.state.language == 'en'
                                      ? 'Forgot Password'
                                      : 'Parolamı Unuttum',
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ))
      ]),
    );
  }
}
