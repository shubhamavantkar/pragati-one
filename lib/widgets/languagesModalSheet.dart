import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/constants/languages.dart';
import 'package:pragati/widgets/languageCard.dart';

class LanguageModalSheet extends StatelessWidget {
  const LanguageModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey.withValues(alpha: 0.5),
              child: Image.asset(
                'assets/cross.png',
                height: 12,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 4),
                ],
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Select Language',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 35,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: const WidgetStatePropertyAll(0),
                              iconColor:
                                  const WidgetStatePropertyAll(Colors.white),
                              backgroundColor:
                                  WidgetStatePropertyAll(primaryColor),
                            ),
                            onPressed: () {},
                            child: Image.asset(
                              'assets/tick.png',
                              height: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: languages.length,
                        itemBuilder: (context, index) {
                          String language = languages.keys.elementAt(index);
                          String imagePath = languages[language]!;
                          return LanguageCard(
                            imageLocation: imagePath,
                            language: language,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
