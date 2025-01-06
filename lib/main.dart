import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/common/dimens/dimens.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
          brightness: Brightness.light,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  fontSize: normalSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              foregroundColor: MaterialStateProperty.all(Colors.black87),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  fontSize: normalSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              foregroundColor: MaterialStateProperty.all(Colors.black87),
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.lightBlue,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              )),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.black87),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black87, width: 1)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red, width: 1)),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black87, width: 1),
            ),
          )),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lightBlue,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              TextStyle(
                fontSize: normalSize,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              TextStyle(
                fontSize: normalSize,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: IconThemeData(
            color: Colors.lightBlue,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(
            color: Colors.white70, // Set the label color globally
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white70, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white70, width: 1),
          ),
        ),
      ),
    ),
  );
}
