import 'package:expense_app/routes/app_routes.dart';
import 'package:expense_app/ui/features/auth/bloc/user_bloc.dart';
import 'package:expense_app/ui/features/auth/bloc/user_event.dart';
import 'package:expense_app/ui/features/auth/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 45),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/splash_image-logo.png",
                          height: 150,
                          width: 150,
                        ),
                        const Text(
                          "Welcome back",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      "To Login, Please Enter Your Details",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your Password",
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.visibility),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (value) {}),
                          const Text("Remember me for 30 days"),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Forgot Password'),
                                content: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'OTP code will be sent to your registered email ID.',
                                    ),
                                    SizedBox(height: 10),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Enter OTP Code'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'The code has been sent to your registered email ID.',
                                                ),
                                                const SizedBox(height: 10),
                                                const TextField(
                                                  decoration: InputDecoration(
                                                    labelText: 'OTP Code',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    // Add resend logic here
                                                  },
                                                  child: const Text(
                                                    'Didn’t receive code? Resend',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed:
                                                    () =>
                                                        Navigator.pop(context),
                                                child: const Text('Cancel'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (
                                                          context,
                                                        ) => AlertDialog(
                                                          title: const Text(
                                                            'Password reset Successflly!',
                                                          ),
                                                          content: const Text(
                                                            "Your password has been reset.",
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.popUntil(
                                                                  context,
                                                                  (route) =>
                                                                      route
                                                                          .isFirst,
                                                                );
                                                              },
                                                              child: const Text(
                                                                'OK',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                  );
                                                },
                                                child: const Text('Continue'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text('Send'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  BlocListener<UserBloc, UserState>(
                    listener: (context, state) async {
                      if (state is UserLoadingState) {
                        isLoading = true;
                        setState(() {});
                      }
                      if (state is UserSuccessState) {
                        isLoading = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Center(child: Text("Login Successful")),
                          ),
                        );
                        // var prefs = await SharedPreferences.getInstance();
                        // prefs.setInt(DBHelper.PREFS_USER_ID, state.userId);
                        Navigator.pushNamed(
                          context,
                          AppRoutes.DASHBOARD_PAGE_ROUTE,
                        );
                      }
                      if (state is UserFailureState) {
                        isLoading = false;
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Center(
                              child: Text("Error: ${state.errorMessage}"),
                            ),
                          ),
                        );
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<UserBloc>().add(
                            LoginUserEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text(
                        "Login In",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Dont have an account? Sign Up'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
