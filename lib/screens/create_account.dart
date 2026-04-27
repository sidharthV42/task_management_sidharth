import 'package:flutter/material.dart';
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
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
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black45),
                              borderRadius: BorderRadius.circular(7)
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.black45),
                      )
                  ),

                  TextFormField(
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      obscureText: isEnter,
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
                            ? Icon(Icons.check_box_outline_blank, color: Colors.grey)
                            : Icon(Icons.check_box_outlined, color: Colors.deepPurple),
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
                      print("tapped Create Account");
                      if(create_key.currentState!.validate()){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                      }
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

                  // SizedBox(
                  //     width: double.infinity,
                  //     child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //             backgroundColor:Colors.deepPurple,
                  //             foregroundColor:Colors.white
                  //         ),
                  //         onPressed:(){
                  //           if(create_key.currentState!.validate()){
                  //             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  //           }
                  //         }, child: Text("Create Account")
                  //     )
                  // ),

                  Center(child: Text("Or register with", style: TextStyle(color: Colors.black45),textAlign: TextAlign.center,)),

              Row(
                spacing: 15,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        print("tapped Sign in with GOOGLE");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
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
                              Image(image: AssetImage("assets/icons/google.png"),height: 60,),
                              Text("Sign in with Google",style: TextStyle(color: Colors.deepPurple),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: InkWell(
                      onTap: (){
                        print("tapped Sign in with APPLE");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
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
                              Image(image: AssetImage("assets/icons/apple.png"),height: 60,),
                              Text("Sign in with Apple",style: TextStyle(color: Colors.deepPurple),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: SizedBox(
                  //       width: double.infinity,
                  //       child: ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor:Colors.white,
                  //             foregroundColor:Colors.deepPurple,
                  //           ),
                  //           onPressed:(){}, child: Row(
                  //         children: [
                  //           Image(image: AssetImage("assets/icons/google.png"),height: 60,),
                  //           Text("Sign in with Google"),
                  //         ],
                  //       )
                  //       )
                  //   ),
                  // ),
                  //
                  // Expanded(
                  //   child: SizedBox(
                  //       width: double.infinity,
                  //       child: ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor:Colors.white,
                  //             foregroundColor:Colors.deepPurple,
                  //           ),
                  //           onPressed:(){}, child: Row(
                  //         children: [
                  //           Image(image: AssetImage("assets/icons/apple.png"),height: 60,),
                  //           Text("Sign in with Apple"),
                  //         ],
                  //       )
                  //       )
                  //   ),
                  // ),
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
