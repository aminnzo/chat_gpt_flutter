import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextCard extends StatelessWidget {
  TextCard({Key? key, this.textData}) : super(key: key);

  var textData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100)),
                child: const Icon(
                  Icons.ac_unit,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  textData.text,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: textData.text));
                  },
                  child: const Icon(Icons.copy, size: 28)),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class MyTextCard extends StatelessWidget {
  MyTextCard({Key? key, this.textData}) : super(key: key);

  var textData;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                textData.text,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
