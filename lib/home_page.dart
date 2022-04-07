import 'dart:convert';

import 'package:dev_assignment/button_widget.dart';
import 'package:dev_assignment/categories_model.dart';
import 'package:dev_assignment/highest_rated_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget listViewWidget(List<Data> article) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: article.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(
              right: 20,
            ),
            decoration: BoxDecoration(
              color: Color(int.parse(article[index].bgcolor)),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 0.5,
                color: Colors.transparent,
              ),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(
                        top: 11,
                        right: 23,
                        left: 23,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.0),
                        image: DecorationImage(
                          image: NetworkImage(article[index].icon),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 17.0),
                Container(
                  width: 92.sp,
                  child: Text(
                    article[index].name.en,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'FirSans',
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget servicesListView() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: highestRatedData.length,
        itemBuilder: (context, index) {
          String salonIcon = highestRatedData[index]['icon'].toString();
          String salonName = highestRatedData[index]['name'].toString();
          String salonDistance = highestRatedData[index]['distance'].toString();
          String salonLocation = highestRatedData[index]['location'].toString();
          return Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(
              right: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 0.5,
                color: Colors.black,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Salon Image
                Container(
                  width: 201.0,
                  height: 108.0,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(17.0),
                    image: DecorationImage(
                      image: AssetImage(salonIcon),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 7.0),
                // Salon Name
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    salonName,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 12.0.sp,
                        color: const Color.fromRGBO(68, 66, 66, 1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                // Salon Location
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    salonLocation,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 12.0.sp,
                        color: const Color.fromRGBO(147, 147, 147, 1),
                      ),
                    ),
                  ),
                ),
                // Salon Star + Distance
                Container(
                  width: 201,
                  child: Row(
                      // Distance Line
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Star Icon
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 11.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 11.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 11.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 11.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 11.sp,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            salonLocation,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 10.0.sp,
                                color: const Color.fromRGBO(147, 147, 147, 1),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          );
        });
  }

  Future<List<Data>> getCategories() async {
    List<Data> catdata = [];
    var url = "https://anaajapp.com/api/categories";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data['data'] as List;

      catdata = rest.map<Data>((json) => Data.fromJson(json)).toList();
    }

    return catdata;
  }

  final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

  Widget buildFullName(String text) => TextField(
        autocorrect: true,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white70,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 219, 216, 216),
              width: 2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide:
                BorderSide(color: Color.fromRGBO(228, 81, 113, 1), width: 2),
          ),
        ),
      );

  Widget buildPass(String text) => TextField(
        autocorrect: true,
        obscureText: true,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          suffixIcon: const Icon(Icons.remove_red_eye_outlined),
          fillColor: Colors.white70,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 219, 216, 216),
              width: 2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide:
                BorderSide(color: Color.fromRGBO(228, 81, 113, 1), width: 2),
          ),
        ),
      );
  Widget buildConfPass(String text) => TextField(
        autocorrect: true,
        obscureText: true,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          suffixIcon: const Icon(Icons.visibility_off_outlined),
          fillColor: Colors.white70,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 219, 216, 216),
              width: 2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide:
                BorderSide(color: Color.fromRGBO(228, 81, 113, 1), width: 2),
          ),
        ),
      );

  final items = ["Male", "Gender"];
  String? value;

  DropdownMenuItem<String> buildGender(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );

  Widget buildEmail() => Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          TextFormField(
            maxLines: 1,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              const pattern =
                  r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
              final regExp = RegExp(pattern);

              if (value!.isEmpty) {
                return 'Enter an email';
              } else if (!regExp.hasMatch(value)) {
                return 'Enter a valid email';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) => setState(() => email = value!),
          ),
          IconButton(
            icon: const Icon(Icons.dialpad, color: const Color(0xfff96800)),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              // Your codes...
            },
          ),
        ],
      );

  Widget buildPassword() => TextFormField(
        maxLines: 1,
        decoration: const InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 7) {
            return 'Password must be at least 7 characters long';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => password = value!),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
      );

  Widget buildConfirmPassword() => TextFormField(
        maxLines: 1,
        decoration: const InputDecoration(
          labelText: 'Confirm Password',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value != password) {
            return 'Password is not same';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => password = value!),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
      );

  Widget buildSubmit(Key key) => Builder(
        builder: (context) => ButtonWidget(
          text: 'Submit',
          onClicked: () {
            final isValid = formKey.currentState!.validate();
            // FocusScope.of(context).unfocus();

            if (isValid) {
              formKey.currentState!.save();

              final message =
                  'Username: $username\nPassword: $password\nEmail: $email';
              final snackBar = SnackBar(
                content: Text(
                  message,
                  style: const TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.green,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          key: key,
        ),
      );

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ScreenUtilInit(
      builder: () => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Gradient Part
                Container(
                  height: 0.18.sh,
                  width: 1.sw,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(26, 50, 99, 1),
                        Color.fromRGBO(168, 97, 189, 1),
                        Color.fromRGBO(228, 81, 113, 1),
                      ],
                    ),
                  ),
                  child: Column(children: <Widget>[
                    // LCN FIRM LOGO
                    Container(
                      height: 0.07.sh,
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 18,
                            child: const Image(
                              image: AssetImage("assets/lcn_firm.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              child: const Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Profile + Location
                    Container(
                      width: 1.sw,
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Pikashi Jain",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  child: const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  child: Text(
                                    "Time Square Plaza, New York",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  child: const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ]),
                ),

                // Highest Rated
                Container(
                  height: 295.sp,
                  width: 1.sw,
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 24,
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    children: <Widget>[
                      // Highestv Rated Title
                      SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Highest Rated",
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(29, 38, 119, 1),
                                ),
                              ),
                            ),
                            Text(
                              "View All",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(29, 38, 119, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //ListView
                      Container(
                        height: 208,
                        width: 1.sw,
                        padding: const EdgeInsets.only(
                          top: 16,
                          right: 16,
                        ),
                        child: FutureBuilder<Iterable>(
                          future: getCategories(),
                          builder: (context, snapshot) {
                            return snapshot.data != null
                                ? Container(
                                    height: 176,
                                    child: servicesListView(),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        ),
                      ),

                      // List View original
                      // Container(
                      //   height: 0.5.sh,
                      //   width: 1.sw,
                      //   padding: const EdgeInsets.only(
                      //     top: 16,
                      //     right: 16,
                      //   ),
                      //   child: FutureBuilder<Iterable>(
                      //     future: getCategories(),
                      //     builder: (context, snapshot) {
                      //       return snapshot.data != null
                      //           ? listViewWidget(
                      //               List<Data>.from(snapshot.data!))
                      //           : const Center(
                      //               child: CircularProgressIndicator(),
                      //             );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),

                // Services
                Container(
                  height: 0.26.sh,
                  width: 1.sw,
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 24,
                    left: 16,
                    // right: 16,
                  ),
                  child: Column(
                    children: <Widget>[
                      // Services Title
                      SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Services",
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(29, 38, 119, 1),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                "View All",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  textStyle: const TextStyle(
                                    color: Color.fromRGBO(29, 38, 119, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // List View original
                      Container(
                        height: 0.160.sh,
                        width: 1.sw,
                        padding: const EdgeInsets.only(
                          top: 16,
                          right: 16,
                        ),
                        child: FutureBuilder<Iterable>(
                          future: getCategories(),
                          builder: (context, snapshot) {
                            return snapshot.data != null
                                ? listViewWidget(
                                    List<Data>.from(snapshot.data!))
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        ),
                      ),

                      // ListView
                      // Container(
                      //   height: 0.5.sh,
                      //   width: 1.sw,
                      //   padding: const EdgeInsets.only(
                      //     top: 16,
                      //     right: 16,
                      //   ),
                      //   child: FutureBuilder<Iterable>(
                      //     future: getCategories(),
                      //     builder: (context, snapshot) {
                      //       print(snapshot.data);
                      //       return snapshot.data != null
                      //           ? listViewWidget(
                      //               List<Data>.from(snapshot.data!))
                      //           : const Center(
                      //               child: CircularProgressIndicator(),
                      //             );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),

                // Border
                Container(
                  height: 2,
                  width: 0.8.sw,
                  margin: const EdgeInsets.only(
                    top: 38,
                    bottom: 38,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                // Form Start
                Container(
                  height: 108,
                  padding: const EdgeInsets.all(20),
                  child: buildFullName("Full Name"),
                ),
                Container(
                  height: 108,
                  padding: const EdgeInsets.all(20),
                  child: buildFullName("Email ID"),
                ),
                Container(
                  height: 108,
                  padding: const EdgeInsets.all(20),
                  child: buildPass("Password"),
                ),
                Container(
                  height: 108,
                  padding: const EdgeInsets.all(20),
                  child: buildPass("Confirm Password"),
                ),
                Container(
                  height: 108,
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                      border: Border.all(width: 2),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      items: items.map(buildGender).toList(),
                      onChanged: (value) => setState(() {
                        this.value = value;
                      }),
                    ),
                  ),
                ),
                // buildSubmit(formKey),
              ],
            ),
          ),
        ),
      ),
      designSize: Size(width, height),
    );
  }
}
