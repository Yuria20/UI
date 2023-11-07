import 'package:flutter/material.dart';

class tt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Color(0xFFC8FCC3),
            child: Image.asset('assets/pose/downdog_example.png'),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '이곳에 사진 설명을 입력하세요.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // 시작 버튼을 눌렀을 때 수행할 동작 추가
            },
            child: Text('시작'),
          ),
        ],
      ),
    );
  }
}
