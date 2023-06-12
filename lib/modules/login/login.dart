import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash/modules/home/home.dart';
import 'package:hash/shared/components/components.dart';
import 'package:hash/shared/cubit/shop_login_cubit/cubit.dart';
import 'package:hash/shared/cubit/shop_login_cubit/states.dart';
import 'package:hash/shared/network/local/cache_helper.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController activationCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (BuildContext context, Object? state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              showToast(
                text: state.loginModel.message,
                state: ToastStates.success,
              );
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data?.token)
                  .then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              });
              print(state.loginModel.message);
            } else {
              showToast(
                text: state.loginModel.message,
                state: ToastStates.error,
              );
              print(state.loginModel.message);
            }
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.grey,
                              fontSize: 30),
                        ),
                        const Text(
                          " قم بتسجيل الدخول للشراء بالجملة ",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.grey,
                              fontSize: 10),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          icon: Icons.person,
                          label: 'name',
                          controller: name,
                          inputType: TextInputType.text,
                          validate: (value) {
                            if (value.isEmpty) {
                              return "قم بإدخال الاسم بالأول";
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        defaultFormField(
                            validate: (value) {
                              if (value.isEmpty) {
                                return "قم بإدخال الاسم بالأول";
                              }
                            },
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            icon: Icons.lock,
                            label: 'password',
                            controller: password,
                            inputType: TextInputType.visiblePassword,
                            suffix: ShopLoginCubit.get(context).suffix,
                            suffixOnTap: () => ShopLoginCubit.get(context)
                                .changePasswordVisibility()),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          validate: (value) {
                            if (value.isEmpty) {
                              return "قم بإدخال الاسم بالأول";
                            }
                          },
                          icon: Icons.security,
                          label: 'activation code',
                          controller: activationCode,
                          inputType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (BuildContext context) {
                            return defaultButton(
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: name.text,
                                        password: password.text);
                                  }
                                },
                                text: "text");
                          },
                          fallback: (BuildContext context) {
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            const Text(
                              " ليس لديك مفتاح تفعيل؟",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey,
                                  fontSize: 10),
                            ),
                            defaultTextButton(
                                controller: activationCode,
                                function: () {},
                                text: " الحصول على كود التفعيل")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
