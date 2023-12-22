import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});
Shimmer box(){
  return  Shimmer.fromColors(baseColor: Colors.black.withOpacity(0.6), highlightColor: Colors.white, child: Container(
    height: 15,
    width: 95,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
      color: Colors.black.withOpacity(0.2),
    ),
  ),);
}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 240,
      width: 200,
      child: Column(
        children: [
          Shimmer.fromColors(baseColor: Colors.black.withOpacity(0.6), highlightColor: Colors.white, child: Container(
            height: 140,
            width: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.2),
            ),
          ),),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              box(),
              box(),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Column(children: [
                box(),
                const SizedBox(height: 10,),
                box(),
              ],),
              const SizedBox(width: 30,),
              Shimmer.fromColors(baseColor: Colors.black.withOpacity(0.6), highlightColor: Colors.white, child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.2),
                ),
              ),),
            ],
          )
        ],
      ),
    );
  }
}