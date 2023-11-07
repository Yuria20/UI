import 'package:flutter/material.dart';
import 'package:cabston/yogaposedecre.dart';

class posetab extends StatefulWidget {
  @override
  _posetab createState() => _posetab();
}

class _posetab extends State<posetab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Color(0xFFC8FCC3),
        padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 1개의 행에 항목을 3개씩
            mainAxisSpacing: 50,
            crossAxisSpacing: 5,
            childAspectRatio: 4/2,
          ),
          itemCount: 15,
          //padding: EdgeInsets.all(),
          itemBuilder: (BuildContext context, int index) {
            String imageAsset = 'assets/p_button/p_button${index + 1}.png';
            return ElevatedButton( // ElevatedButton 사용
              onPressed: () {

              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFC8FCC3)), // 버튼 배경색
                elevation: MaterialStateProperty.all(0), // 그림자 없음fixedSize: MaterialStateProperty.all(Size(150, 150))
              ),
              child: Ink.image(
                image: AssetImage(imageAsset), // 사용자 정의 이미지 경로
                //width: 100,// 이미지 높이 조절
                //height:100,
              ),
            );

          },
        ),
      )
    );
  }
}