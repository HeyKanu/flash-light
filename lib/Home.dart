import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volume_flash_plugin/volume_flash_plugin.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  bool onOff = false;
  bool disco = false;
  bool mod_simple = true;
  double gap = 40;

  void set() async {
    await VolumeFlashPlugin.toggleFlashlight(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    set();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Flash light",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  child: Center(
                    child: Stack(
                      children: [
                        Positioned(
                          top: 9,
                          left: 17,
                          child: Container(
                            height: 40,
                            width: 46,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: onOff ? Colors.yellow : Colors.black,
                                    blurRadius: 7000,
                                    spreadRadius: 10,
                                  )
                                ]),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (mod_simple) {
                              await VolumeFlashPlugin.toggleFlashlight(onOff);
                              setState(() {
                                onOff = onOff ? false : true;
                              });
                            } else {
                              disco = disco ? false : true;
                              if (disco == false) {
                                await VolumeFlashPlugin.toggleFlashlight(true);
                                onOff = true;
                                setState(() {});
                              }
                              while (disco && mod_simple == false) {
                                await VolumeFlashPlugin.toggleFlashlight(
                                    onOff == false ? true : false);
                                await Future.delayed(
                                    Duration(milliseconds: gap.round()));
                                setState(() {
                                  onOff = onOff ? false : true;
                                });
                              }
                            }
                          },
                          child: Icon(
                            onOff ? Icons.lightbulb : Icons.lightbulb_outline,
                            size: 80,
                            color: onOff
                                ? Colors.yellow
                                : Color.fromARGB(255, 77, 76, 76),
                            // color: Color.fromARGB(255, 77, 76, 76),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            // height: 200,
            width: double.infinity,
            // color: Colors.amber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Mode",
                  style: TextStyle(color: Colors.white),
                ),
                Visibility(
                    visible: mod_simple ? false : true,
                    child: Slider(
                      min: 40,
                      max: 500,
                      value: gap,
                      onChanged: (value) {
                        setState(() {
                          gap = value;
                          print(gap.round());
                        });
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          setState(() {
                            set();
                            onOff = false;
                            mod_simple = true;
                          });
                        },
                        child: Text("Simpal mode")),
                    OutlinedButton(
                        onPressed: () {
                          setState(() {
                            set();
                            onOff = false;
                            mod_simple = false;
                          });
                        },
                        child: Text("Disco mode"))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
