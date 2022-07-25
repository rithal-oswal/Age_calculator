import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}
class _HomePage extends State<HomePage> {
  TextEditingController dateInput = TextEditingController();
  var name;
  var email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Age Calculator"),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              child: Form(
                key: _formKey,
                child: Container(
                    padding: EdgeInsets.all(15),
                    //height: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      children: [
                        Text("*Please enter the below details*"),
                        SizedBox(height: 20.0),
                        TextFormField(
                          onChanged:(value){
                            name=value;
                          },
                          keyboardType: TextInputType.name,
                          validator: (value){
                            if (value!.isEmpty){
                              return 'name is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              hintText: 'Enter your full name',
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueGrey)
                              )
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          onChanged:(value){
                            email=value;
                          },
                          validator: (value){
                            if (value!.isEmpty){
                              return 'email is required';
                            }
                            else  if( !RegExp(
                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(value!)) {
                              return 'Please enter a valid email Address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'email',
                              hintText: 'Enter your emailid',
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueGrey)
                              )
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(

                          controller: dateInput,
                          validator: (value){
                            if (value!.isEmpty){
                              return 'BirthDate is required';
                            }
                            return null;
                          },
                          //editing controller of this TextField
                          decoration: InputDecoration(
                            //icon of text field
                              border: OutlineInputBorder(),
                              //icon: Icon(Icons.calendar_today),
                              labelText: 'BirthDate',
                              hintText: 'Enter your Birthdate',
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueGrey)
                              )
                          ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            var pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100));
                            if (pickedDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                dateInput.text = formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                        ),
                        SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) =>  calculate(name:name,dob:dateInput.text,email:email)));
                          },
                          child: Container(

                            height: 45,
                            child: Material(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.blue[800],
                              elevation: 7,
                              child: Center(
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ));
  }
}
// ignore: camel_case_types
class calculate extends StatefulWidget {
  final name,email,dob;
  const calculate({Key? key,this.name,this.dob,this.email}) : super(key: key);
  @override
  State<calculate> createState() => _calculateState();
}

// ignore: camel_case_types
class _calculateState extends State<calculate> {
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
  Widget build(BuildContext context) {
    DateTime age2 = new DateFormat("yyyy-MM-dd").parse(widget.dob);
    var a=calculateAge(age2);
    print (age2);
    print(a);
    return Scaffold(
      appBar: AppBar(
        title: Text("Age Calculator"),
      ),
      body:ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("\nFull Name:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.blue,
                  ),
                ),
                Text("${widget.name}\n",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black87,
                  ),
                ),
                Text("Email Address:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.blue,
                  ),
                ),
                Text("${widget.email}\n",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    Text("Date of Birth:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Colors.blue,
                      ),
                    ),
                    Text("\t\t\t${widget.dob}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("\nAge:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Colors.blue,
                      ),
                    ),
                    Text("\n\t\t\t$a years old",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Center(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    child: Text(
                      'OKAY',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) =>  HomePage()));
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
