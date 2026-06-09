import   'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_management/screens/home_screen.dart';
import 'login_screen.dart';
class CreateAccount extends StatefulWidget {
  CreateAccount({super.key});
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}
class _CreateAccountState extends State<CreateAccount> {
  final create_key = GlobalKey<FormState>();
  bool isEnter = true;
  bool isTick = false;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void _createAccount() {
    if (create_key.currentState!.validate()) {
      if (!isTick) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please agree to Terms & Conditions"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      final String firstName = firstNameController.text.trim();
      final String lastName = lastNameController.text.trim();
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final usersBox = Hive.box("usersBox");
      bool emailExists = false;
      for (int i = 0; i < usersBox.length; i++) {
        final user = usersBox.getAt(i);
        if (user['email'] == email) {
          emailExists = true;
          break;
        }
      }
      if (emailExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Email already registered"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      usersBox.add({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      });
      print("✅ Account created successfully!");
      print("Email: $email, Password: $password");
      final authBox = Hive.box("authBox");
      authBox.put("isLoggedIn", false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account created successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding:EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: create_key,
              child: Column(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Title(
                    color: Colors.blue,
                    child: Text(
                      "Create an account",
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
                      Text("Already have an account?",style: TextStyle(color: Colors.black)),
                      TextButton(onPressed:(){
                        final authBox=Hive.box("authBox");
                        authBox.put("isLoggedIn",true);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      }, child:Text("Log in",style: TextStyle(color: Colors.deepPurple))
                      )
                    ],
                  ),
                  Row(
                    spacing: 15,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "First Name is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black45),
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              hintText: "First Name",
                              hintStyle: TextStyle(color: Colors.black45),
                          ),
                        ),
                      ),

                      Expanded(
                        child: TextFormField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Last Name is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black45),
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              hintText: "Last Name",
                              hintStyle: TextStyle(color: Colors.black45),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (String? value) {
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
                        borderRadius: BorderRadius.circular(7),
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.black45),
                    ),
                  ),
                  TextFormField(
                      controller: passwordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        if (value.length < 8) {
                          return "Password must be at least 8 characters";
                        }
                        return null;
                      },       obscureText: isEnter,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        hintText: "Enter your password",
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
                        hintStyle: TextStyle(color: Colors.black45),
                      )
                  ),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isTick = !isTick;
                          });
                        },
                        icon: isTick
                            ? Icon(Icons.check_box_outlined, color: Colors.deepPurple)
                            : Icon(Icons.check_box_outline_blank, color: Colors.grey),
                      ),

                      Text(" I agree to the", style: TextStyle(color: Colors.black45),),

                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Terms & Conditions",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),

                    ],
                  ),

                  InkWell(
                    onTap: (){
                      _createAccount();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.deepPurple
                      ),
                      child: Center(
                        child: Text("Create Account",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                  Center(child: Text("Or register with", style: TextStyle(color: Colors.black45),textAlign: TextAlign.center,)),
                  Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: InkWell(
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
                              const Text("Google",style: TextStyle(color: Colors.deepPurple),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: InkWell(
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
                              Image(image: AssetImage("assets/icons/apple.png"),height: 24,),
                              const SizedBox(width: 6),
                              const Text("Apple",style: TextStyle(color: Colors.deepPurple),),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}