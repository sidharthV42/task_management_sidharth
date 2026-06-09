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
  bool isEnter = true;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String? errorMessage;
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
      final usersBox = Hive.box("usersBox");
      bool emailFound = false;
      bool passwordCorrect = false;
      for (int i = 0; i < usersBox.length; i++) {
        final user = usersBox.getAt(i);
        if (user['email'] == email){emailFound=true;
          if (user['password'] == password) {
          passwordCorrect = true;
          final authBox= Hive.box("authBox");
          authBox.put("isLoggedIn",true);
          authBox.put("userEmail",email);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("You are logged in successfully"),
              backgroundColor: Colors.green,
            ),);
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const HomeScreen()));
          break;
        }
      }
      }
      if (!emailFound) {
        // Save login state
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Email not registered"),
backgroundColor: Colors.red,
),);
  }
      else if(!passwordCorrect) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Wrong password"),
backgroundColor: Colors.red,
),);
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
                  "Sign in to Write it",
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
                  Text("New here?",style: TextStyle(color: Colors.black)),
                  TextButton(onPressed:(){
                    final authBox=Hive.box("authBox");
                    authBox.put("isLoggedIn",true);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CreateAccount()));
                  }, child:Text("Create an account",style: TextStyle(color: Colors.deepPurple))
                  )
                ],
              ),
              Text("Email", style: TextStyle(color: Colors.black45),textAlign: TextAlign.left,),
              TextFormField(
                controller: emailController,
                validator: (String? value){
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!value.contains("@gmail.com")) {
                    return "Enter a valid email";
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
                  Text("Password", style: TextStyle(color: Colors.black45),textAlign: TextAlign.left,),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("This function not work currently!"),
                          backgroundColor: Colors.red,
                        ),);
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),

              TextFormField(
                controller: passwordController,
                validator: (String? value){
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  return null;
                },   obscureText: isEnter,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.black45),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isEnter = !isEnter;
                      });
                    },
                    icon: Icon(isEnter
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                  ),
                  suffixIconColor: Colors.black45,
                ),
              ),
              InkWell(
                  onTap: () {
                    _login();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.deepPurple,
                    ),
                    child: const Center(
                      child: Text(
                        "Log in",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              Center(child: Text("OR", style: TextStyle(color: Colors.black45),textAlign: TextAlign.center,)),
              InkWell(
                  onTap: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                    content: Text("This function not work currently!"),
                    backgroundColor: Colors.red,
                    ),);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: Colors.black45),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage("assets/icons/google.png"),height: 24,),
                        const SizedBox(width: 6),
                        const Text(" Sign in with Google",style: TextStyle(color: Colors.deepPurple),),
                      ],
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