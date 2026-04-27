import 'package:flutter/material.dart';
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
                  Text("New here?",style: TextStyle(color: Colors.black)),
                  TextButton(onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccount()));
                  }, child:Text("Create an account",style: TextStyle(color: Colors.deepPurple))
                  )
                ],
              ),

              Text("Email", style: TextStyle(color: Colors.black45),textAlign: TextAlign.left,),

              TextFormField(
                validator: (String? value){
                  if(value!.isEmpty){
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
                  Text("Password", style: TextStyle(color: Colors.black45),textAlign: TextAlign.left,),
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
                validator: (String? value){
                  if(value!.isEmpty){
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
              //           if(login_key.currentState!.validate()){
              //             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              //           }
              //         }, child: Text("Log in")
              //     )
              // ),

              InkWell(
                onTap: (){
                  print("tapped Log in");
                  if(login_key.currentState!.validate()){
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
                    child: Text("Log in",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),

              Center(child: Text("OR", style: TextStyle(color: Colors.black45),textAlign: TextAlign.center,)),

              // SizedBox(
              //     width: double.infinity,
              //     child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //             backgroundColor:Colors.white,
              //             foregroundColor:Colors.deepPurple,
              //         ),
              //         onPressed:(){
              //           if(login_key.currentState!.validate()){
              //             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              //           }
              //         }, child: Row(
              //           children: [
              //             Image(image: AssetImage("assets/icons/google.png"),height: 60,),
              //             Text("Sign in with Google"),
              //           ],
              //         )
              //     )
              // ),

              InkWell(
                onTap: (){
                  print("tapped Sign in with Google");
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
            ],
          ),
        ),
      ),
    );
  }
}
