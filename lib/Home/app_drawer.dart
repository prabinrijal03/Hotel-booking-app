import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                height: 95,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 0.5),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 30, left: 18),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Icon(
                          Icons.person,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          Text(
                            'Hi Prabin Rijal',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text('+977-9804067179')
                        ],
                      ),
                      SizedBox(
                        width: 95,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.only(left: 18.0, bottom: 20),
            child: Text(
              'Are you a property owner?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
          ),
          InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'List Your Property',
                      style: TextStyle(fontSize: 18),
                    )),
              )),
          InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'Need Help?',
                      style: TextStyle(fontSize: 18),
                    )),
              )),
        ])
      ],
    );
  }
}
