import 'package:flutter/material.dart';
import 'package:hash/shared/components/components.dart';

Widget IconsCard(
    {required String title,
    required IconData icon1,
    required IconData icon2,
    required IconData icon3,
    required IconData icon4,
    required String title1,
    required String title2,
    required String title3,
    required String title4,
    required context}) {
  return Card(
    // margin:EdgeInsets.all(10),
    elevation: 5.0,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Icon(icon1),
                    const SizedBox(height: 10),
                    Text(title1),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Icon(icon2),
                    const SizedBox(height: 10),
                    Text(title2),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Icon(icon3),
                    const SizedBox(height: 10),
                    Text(title3),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Icon(icon4),
                    const SizedBox(height: 10),
                    Text(title4),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
