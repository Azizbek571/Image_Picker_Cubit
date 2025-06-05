import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_cubit/cubit/image_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider<ImageCubit>(
        create: (context) => ImageCubit(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text("Image picker"),
      ),
      body: BlocBuilder<ImageCubit, ImageState>(
        builder:(context,state){
          if (state is ImageInitialState) {
            return Center(child: ElevatedButton(onPressed: (){
              context.read<ImageCubit>().pickImage();
             }, child: Text("Pick Image")
             ),
             );
            
          }
          else if (state is ImageLoadedState)
          {
          return  Center(child: Column(children: [ 
              Image.file(File(state.imagePath), height:200 ,),
              SizedBox(height: 16),
            ElevatedButton(onPressed: (){ 
                    context.read<ImageCubit>().reset();
            }, child: Text("Pick another image"))
            ],
            )  ,
            );
          }
          else if (state is ImageErrorState ){
       return      Center(child: Column(children: [ 
            Text(state.errorMessage),
              SizedBox(height: 16),
            ElevatedButton(onPressed: (){ 
                    context.read<ImageCubit>().reset();
            }, child: Text("Try again"))
            ],
            )  ,
            );
          }
          return Container();
        } )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
