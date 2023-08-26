import 'package:calculator_/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  //All variable for performing operations in the calculator
  var input ='';
  var output ='';
  var operation ='';
  var hideInput=false;
  var outputSize=45.0;

  onButtonClick(value){

    if(value=="AC"){
      input='';
      output='';
    }
    else if(value=="<-") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    }
    else if(value=="=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if(output.endsWith(".0")){
          output=output.substring(0,output.length-2);
        }
        input=output;
        hideInput=true;
        outputSize=55;
      }
    }
    else{
      input=input+value;
      hideInput=false;
      outputSize=45;
    }
    setState(() {

    });


  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
                          width: double.infinity,
                          padding:const EdgeInsets.all(12.0),
                          color:Colors.black12,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.end,
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                                    Text(
                                      hideInput? '' :input,
                                      style:TextStyle(
                                        fontSize: 40,
                                        color: Colors.white,
                                      ) ,
                                    ),
                               SizedBox(
                                 height: 40,
                               ),
                               Text(output,
                                 style:TextStyle(
                                   fontSize: outputSize,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.deepOrangeAccent,
                                 ) ,
                               ),
                             ],
                           ),
              ),
          ),
          //All Buttons Area
          Row(
            children: [
              button(text: "AC",txtColor: orangeColor,buttonBgColor: operatorColor),
              button(text:"<-",buttonBgColor: operatorColor),
              button(text:"%",buttonBgColor: operatorColor),
              button(text:"/",buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text:"8"),
              button(text:"9"),
              button(text:"x",buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text:"5"),
              button(text:"6"),
              button(text:"+",buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text:"2"),
              button(text:"3"),
              button(text:"-",buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "( )"),
              button(text:"0"),
              button(text:".",buttonBgColor: operatorColor),
              button(text:"=",buttonBgColor: orangeColor
              ),
            ],
          ),
        ],
      )
      

    );
  }

  Widget button({
    text, txtColor=Colors.white,buttonBgColor=buttonColor})
  {
    return Expanded(child: Container(
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)
          ),
          padding: EdgeInsets.all(22.0),
          backgroundColor: buttonBgColor,
        ),

        onPressed: () => onButtonClick(text),
        child:  Text(text,
          style: TextStyle(
            color: txtColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,

          ),),

      ),
    ),
    );
  }


}

