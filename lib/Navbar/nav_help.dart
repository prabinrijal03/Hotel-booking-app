import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 43),
                  child: SizedBox(
                    child: Column(
                      children: [
                        Text(
                          'Support',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "You can contact us for any queries",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /*  Positioned(
                      top: 16,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          value.getHotels();
                        },
                      )), */
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Column(
              children: [
                Image.asset("assets/images/p.png"),
                const Row(children: [
                  Text(
                    "Customer Support: ",
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(
                    "9804067179",
                    style: TextStyle(fontSize: 22, color: Colors.red),
                  ),
                ]),
                const Row(
                  children: [
                    Text(
                      "Email: ",
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      "prabinrijal03@gmail.com",
                      style: TextStyle(fontSize: 22, color: Colors.red),
                    ),
                  ],
                ),
                const Row(children: [
                  Text(
                    "Whatsapp: ",
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(
                    "9842099472",
                    style: TextStyle(fontSize: 22, color: Colors.red),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
