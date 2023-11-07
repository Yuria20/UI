import 'package:flutter/material.dart';
import 'package:cabston/helo.dart';

class challengers extends StatefulWidget {
  @override
  _challengers createState() => _challengers();
}

class _challengers extends State<challengers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFC8FCC3),
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              //width: 10, // 가로 간격 조절
              height: 10, // 세로 간격 조절
            ),
            Expanded(
              flex: 1, // 첫 번째 Expanded 위젯
              child: InkWell(
                onTap: () {
                  // 첫 번째 이미지 버튼을 눌렀을 때 수행할 동작 추가
                },
                child: Image.asset(
                  'assets/chellen/recomand_button.png',
                  //width: 100, // 이미지의 가로 크기
                  //height: 100, // 이미지의 세로 크기
                ),
              ),
            ),
            SizedBox(
              //width: 10, // 가로 간격 조절
              height: 50, // 세로 간격 조절
            ),
            Expanded(
              flex: 1, // 두 번째 Expanded 위젯
              child: InkWell(
                onTap: () {
                  // 두 번째 이미지 버튼을 눌렀을 때 수행할 동작 추가
                },
                child: Image.asset(
                  'assets/chellen/custom_button.png',
                  //width: 100, // 이미지의 가로 크기
                  //height: 100, // 이미지의 세로 크기
                ),
              ),
            ),
            SizedBox(
              //width: 10, // 가로 간격 조절
              height: 50, // 세로 간격 조절
            ),
            Expanded(
              flex: 1, // 세 번째 Expanded 위젯
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => tt(),
                      ),
                  );
                },
                child: Image.asset(
                  'assets/chellen/ranking_button.png',
                  //width: 100, // 이미지의 가로 크기
                  //height: 100, // 이미지의 세로 크기
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}