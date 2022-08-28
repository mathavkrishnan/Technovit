import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Onboard.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:pinput/pinput.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  var x = 0;
  bool showspiner = false;
  late String otp;
  String? verificationcode;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  final focusedPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  ).copyDecorationWith(
    border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
    borderRadius: BorderRadius.circular(8),
  );

  final submittedPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  ).copyWith(
    decoration: PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    ).decoration?.copyWith(
      color: Color.fromRGBO(234, 239, 243, 1),
    ),
  );

  late String smsCode;

  Future verifyphone()async{
    setState(() {
      showspiner = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential cred)async{
          await FirebaseAuth.instance.signInWithCredential(cred).then((value)async{
            print("login success");
          });
        },
        phoneNumber: '+91'+'$x',
        verificationFailed: (FirebaseAuthException e){
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken){
          setState(() {
            verificationcode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID){
          setState(() {
            verificationcode = verificationID;
          });
        },
        timeout: const Duration(seconds: 60)
    );
    setState(() {
      showspiner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspiner,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            // Box decoration takes a gradient
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Colors.green.shade800,
                Colors.white,
                Colors.green.shade800,
                Colors.green.shade800,
              ],
            ),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1,
          child: Align(
            alignment: AlignmentDirectional(0, 1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 192),
                        child: Image.asset(
                          'assets/images/123.png',
                          width: 300,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x3600000F),
                          offset: Offset(0, -1),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  'Phone Sign In',
                                  style: TextStyle(color: Colors.grey,fontSize: 24,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onChanged: (value){
                                    x = int.parse(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Your Phone Number...',

                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    contentPadding:
                                    EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 2, 2, 2),
                                child: MaterialButton(
                                  minWidth: 10,
                                  height: 20,
                                  color: Colors.grey.shade100,
                                  child: Icon(
                                    Icons.done,
                                    color: Color(0xFF06681E),
                                    size: 30,
                                  ),
                                  onPressed: () async{
                                    try{
                                      await verifyphone();
                                    }
                                    catch(e){

                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Pinput(
                                  length: 6,
                                  defaultPinTheme: defaultPinTheme,
                                  focusedPinTheme: focusedPinTheme,
                                  submittedPinTheme: submittedPinTheme,
                                  validator: (s) {
                                    otp = s!;
                                    return s == otp ? null : "not match";
                                  },
                                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                  showCursor: true,
                                  onCompleted: (pin) => print(pin),
                                )
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 32),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
                                  child: MaterialButton(
                                    onPressed: () async{
                                      setState(() {
                                        showspiner = true;
                                      });
                                      FirebaseAuth auth = FirebaseAuth.instance;
                                      var _credential = PhoneAuthProvider.credential(verificationId: verificationcode!, smsCode: otp);
                                      auth.signInWithCredential(_credential).then((value) async {
                                        await Navigator.push(context,MaterialPageRoute(builder: (context) =>OnboardWidget(),));
                                      }
                                      );
                                      setState(() {
                                        showspiner = false;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                                    color: Colors.green.shade900,
                                    child: Text('Sign In',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                    elevation: 2,
                                    minWidth: 200.0,
                                    height: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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