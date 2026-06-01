import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_management/screens/create_account.dart';
import 'package:task_management/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen ({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final login_key = GlobalKey<FormState>();
  bool isClick = true;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (login_key.currentState!.validate()) {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      print("🔍 Attempting login with email: $email, password: $password");

      // Get the users database
      final usersBox = Hive.box("usersBox");

      print("📦 Total registered users: ${usersBox.length}");

      // Check if user exists with this email and password
      bool userExists = false;
      for (int i = 0; i < usersBox.length; i++) {
        final user = usersBox.getAt(i);
        print("User $i: Email=${user['email']}, Password=${user['password']}");
        if (user['email'] == email && user['password'] == password) {
          userExists = true;
          print("✅ Credentials match!");
          break;
        }
      }

      if (userExists) {
        print("✅ Login successful!");
        // Save login state
        final authBox = Hive.box("authBox");
        authBox.put("isLoggedIn", true);
        authBox.put("userEmail", email);

        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const HomeScreen())
        );
      } else {
        print("❌ Invalid credentials!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid email or password"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: login_key,
          child: Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Title(
                color: Colors.blue,
                child: Text(
                  "Sign in to Task Manager",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              Row(
                children: [
                  Text("New here?", style: TextStyle(color: Colors.black)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccount()));
                    },
                    child: Text("Create an account", style: TextStyle(color: Colors.deepPurple))
                  )
                ],
              ),

              Text("Email", style: TextStyle(color: Colors.black45), textAlign: TextAlign.left,),

              TextFormField(
                controller: emailController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                    borderRadius: BorderRadius.circular(7)
                  ),
                  hintText: "Email address",
                  hintStyle: TextStyle(color: Colors.black45),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Password", style: TextStyle(color: Colors.black45), textAlign: TextAlign.left,),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),

              TextFormField(
                controller: passwordController,
                obscureText: isClick,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                    borderRadius: BorderRadius.circular(7)
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.black45),
                  suffixIcon: IconButton(
                    icon: Icon(isClick ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    onPressed: () {
                      setState(() {
                        isClick = !isClick;
                      });
                    },
                  ),
                ),
              ),

              InkWell(
                onTap: _login,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.deepPurple
                  ),
                  child: Center(
                    child: Text("Log in", style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),

              Center(child: Text("OR", style: TextStyle(color: Colors.black45), textAlign: TextAlign.center,)),

              InkWell(
                onTap: () {
                  print("tapped Sign in with Google");
                  final authBox = Hive.box("authBox");
                  authBox.put("isLoggedIn", true);
                  authBox.put("userEmail", "google_user");
                  
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => const HomeScreen())
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.black45),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Image(image: AssetImage("assets/icons/google.png"), height: 60,),
                        Text("Sign in with Google", style: TextStyle(color: Colors.deepPurple),),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
