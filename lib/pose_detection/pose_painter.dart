import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vector_math/vector_math.dart' as vm;


import 'coord.dart';


class PosePainter extends CustomPainter {
  PosePainter(
      this.poses,
      this.imageSize,
      this.rotation,
      this.cameraLensDirection,
      );

  final List<Pose> poses;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;
  var isdowndog = false;

  @override
  void paint(Canvas canvas, Size size) async {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.green;

    final leftPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.yellow;

    final rightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.blueAccent;

    final Srank = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.purpleAccent;

    final Arank = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.redAccent;

    final Brank = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.blueAccent;

    final Crank = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.greenAccent;

    final Drank = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.yellowAccent;

    var g = 0.0;
    var radian = pi/180.0;
    int counter = 0;
    const int samplingInterval = 300;
    var z = 0.0;
    var anglename = {
      0 : '오른쪽 팔꿈치',
      1 : '왼쪽 팔꿈치',
      2 : '오른쪽 겨드랑이',
      3 : '왼쪽 겨드랑이',
      4 : '오른쪽 고관절',
      5 : '왼쪽 고관절',
      6 : '오른쪽 무릎',
      7 : '왼쪽 무릎',
      8 : '목'
    };
    var w  = [-9.51273227e+00, -3.32848430e+00,  3.15798734e+01,-4.01174322e+01,
      5.13610608e+01 , 4.57422785e+01 , 4.64176786e+01, -4.62281187e+01,
          -8.91498310e+01, -3.45757496e+01 , 2.77923207e+01 , 4.99065075e+01,
      2.25224563e+00 , 4.46598044e+01, -1.70695668e+01  ,1.33786390e+01,
          -3.21114333e+01, -2.29411055e+00 , 1.26409952e+01 ,-7.12760845e-02,
      2.20445431e+01 , 1.76977241e+01,  8.97812191e+00, -1.59817908e+01,
          -1.67882534e+01, -3.03639880e+00,  3.57603765e+01 ,-1.30133346e+01,
      8.05566897e-01, -1.12717693e+00];
    vm.Vector3 head = vm.Vector3(w[0],w[1],w[2]);
    vm.Vector3 body = vm.Vector3(w[3],w[4],w[5]);
    vm.Vector3 leftElbow = vm.Vector3(w[6],w[7],w[8]);
    vm.Vector3 leftHand = vm.Vector3(w[9],w[10],w[11]);
    vm.Vector3 rightElbow = vm.Vector3(w[12],w[13],w[14]);
    vm.Vector3 righttHand = vm.Vector3(w[15],w[16],w[17]);
    vm.Vector3 rightKnee = vm.Vector3(w[18],w[19],w[20]);
    vm.Vector3 leftKnee = vm.Vector3(w[21],w[22],w[23]);
    vm.Vector3 leftfoot = vm.Vector3(w[24],w[25],w[26]);
    vm.Vector3 rightfoot = vm.Vector3(w[27],w[28],w[29]);
    var b = -0.00047337167902949755;



    var angles_mean = [-0.77822538, -0.79229441 ,-0.87741574,-0.94663571 ,-0.04150215 , 0.01572251,
        -0.94498367 ,-0.97689872, -0.24132603];

    for (final pose in poses) {
      /*pose.landmarks.forEach((_, landmark) {
        canvas.drawCircle(
            Offset(
              translateX(
                landmark.x,
                size,
                imageSize,
                rotation,
                cameraLensDirection,
              ),
              translateY(
                landmark.y,
                size,
                imageSize,
                rotation,
                cameraLensDirection,
              ),
            ),
            1,
            paint);
      });

       */


      void checkArm( PoseLandmarkType type1, PoseLandmarkType type2,PoseLandmarkType type3,
          PoseLandmarkType type4, PoseLandmarkType type5,
          double standard,int anglename){

        final PoseLandmark joint1 = pose.landmarks[type1]!;
        final PoseLandmark joint2 = pose.landmarks[type2]!;
        final PoseLandmark joint3 = pose.landmarks[type3]!;
        final PoseLandmark joint4 = pose.landmarks[type4]!;
        final PoseLandmark joint5 = pose.landmarks[type5]!;

        vm.Vector3 coord1 = vm.Vector3(joint1.x-joint5.x,
            joint1.y-joint5.y,
            joint1.z-joint5.z);
        vm.Vector3 coord2 = vm.Vector3(joint4.x-joint5.x,joint4.y-joint5.y,joint4.z-joint5.z);

        // compute inner product
        double angle = vm.dot3(coord1, coord2)/coord1.length/coord2.length;
        angle-=standard;
        if(angle<0.0)
          angle*=-1;

        if (1-cos(5.0*radian) < angle) {
          canvas.drawCircle(
              Offset(
                  translateX(
                    joint5.x,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    joint5.y,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  )
              ), 100.0, Srank);
        }
        else if(1-cos(10.0*radian) < angle) {
          canvas.drawCircle(
              Offset(
                  translateX(
                    joint5.x,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    joint5.y,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  )
              ), 100.0, Arank);
        }
        else if (1-cos(15.0*radian) < angle) {
          canvas.drawCircle(
              Offset(
                  translateX(
                    joint5.x,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    joint5.y,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  )
              ), 100.0, Brank);
        }
        else if (1-cos(30.0*radian) < angle) {
          canvas.drawCircle(
              Offset(
                  translateX(
                    joint5.x,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    joint5.y,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  )
              ), 100.0, Crank);
        }
        else {
          canvas.drawCircle(
              Offset(
                  translateX(
                    joint5.x,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    joint5.y,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  )
              ), 100.0, Drank);
        }
      }

      void checkOther( PoseLandmarkType type1, PoseLandmarkType type2,PoseLandmarkType type3,
          double standard,int anglename){

        final PoseLandmark joint1 = pose.landmarks[type1]!;
        final PoseLandmark joint2 = pose.landmarks[type2]!;
        final PoseLandmark joint3 = pose.landmarks[type3]!;


        vm.Vector3 coord1 = vm.Vector3(joint1.x-joint3.x,
            joint1.y-joint3.y,
            joint1.z-joint3.z);
        vm.Vector3 coord2 = vm.Vector3(joint2.x-joint3.x,joint2.y-joint3.y,joint2.z-joint3.z);

        // compute inner product
        double angle = vm.dot3(coord1, coord2)/coord1.length/coord2.length;
        angle-=standard;
        if(angle<0.0)
          angle*=-1;

        if (1-cos(5.0*radian) < angle) {
          canvas.drawCircle(
              Offset(
                  translateX(
                    joint3.x,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    joint3.y,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  )
              ), 100.0, Srank);
        }
        else if(1-cos(10.0*radian) < angle) {
          canvas.drawCircle(
              Offset(
                  translateX(
                    joint3.x,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    joint3.y,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  )
              ), 100.0, Arank);
        }
        else if (1-cos(15.0*radian) < angle) {
          canvas.drawCircle(
              Offset(
                  translateX(
                    joint3.x,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    joint3.y,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  )
              ), 100.0, Brank);
        }
        else if (1-cos(30.0*radian) < 1-angle) {
          canvas.drawCircle(
              Offset(
                  translateX(
                    joint3.x,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    joint3.y,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  )
              ), 100.0, Crank);
        }
        else {
          canvas.drawCircle(
              Offset(
                  translateX(
                    joint3.x,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    joint3.y,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  )
              ), 100.0, Drank);
        }
      }

      void paintLine(
          PoseLandmarkType type1, PoseLandmarkType type2, Paint paintType) {
        final PoseLandmark joint1 = pose.landmarks[type1]!;
        final PoseLandmark joint2 = pose.landmarks[type2]!;

        canvas.drawLine(
            Offset(
                translateX(
                  joint1.x,
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
                translateY(
                  joint1.y,
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                )),
            Offset(
                translateX(
                  joint2.x,
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
                translateY(
                  joint2.y,
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                )),
            paintType);
      }

      double something(PoseLandmarkType type,vm.Vector3 weight,bool isbody) {
        if(isbody) {
          final PoseLandmark joint1 = pose.landmarks[11]!;
          final PoseLandmark joint2 = pose.landmarks[12]!;
          final PoseLandmark joint3 = pose.landmarks[23]!;
          final PoseLandmark joint4 = pose.landmarks[24]!;
          vm.Vector3 vec1 = vm.Vector3(joint1.x,joint1.y,joint1.z);
          vm.Vector3 vec2 = vm.Vector3(joint2.x,joint2.y,joint2.z);
          vm.Vector3 vec3 = vm.Vector3(joint3.x,joint3.y,joint3.z);
          vm.Vector3 vec4 = vm.Vector3(joint4.x,joint4.y,joint4.z);
          return vm.dot3((vec1+vec2+vec3+vec4)/4, weight);
        }
        final PoseLandmark joint1 = pose.landmarks[type]!;
        vm.Vector3 vec = vm.Vector3(joint1.x,joint1.y,joint1.z);
        return vm.dot3(vec, weight);
      }

      void checkpose() {
        z+=something(PoseLandmarkType.nose, head, false);
        z+=something(PoseLandmarkType.rightWrist, righttHand, false);
        z+=something(PoseLandmarkType.leftWrist, leftHand, false);
        z+=something(PoseLandmarkType.rightElbow, rightElbow, false);
        z+=something(PoseLandmarkType.leftElbow, leftElbow, false);
        z+=something(PoseLandmarkType.nose, body, true);
        z+=something(PoseLandmarkType.rightKnee, rightKnee, false);
        z+=something(PoseLandmarkType.leftKnee, leftKnee, false);
        z+=something(PoseLandmarkType.rightAnkle, rightfoot, false);
        z+=something(PoseLandmarkType.leftAnkle, leftfoot, false);
        z+=b;
        g = 1.0/(1+exp(-z));

        if(g>0.5) {
          isdowndog = true;
          canvas.drawCircle(
              Offset(
                  translateX(
                    pose.landmarks[PoseLandmarkType.rightHip]!.x,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    pose.landmarks[PoseLandmarkType.rightHip]!.y,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  )
              ), 100.0, Drank);
        }
        else {
          isdowndog = false;
          canvas.drawCircle(
              Offset(
                  translateX(
                    pose.landmarks[PoseLandmarkType.rightHip]!.x,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    pose.landmarks[PoseLandmarkType.rightHip]!.y,
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  )
              ), 100.0, Drank);
        }
      }

      void processFrame() {
        counter++;

        if (counter % samplingInterval == 0) {
          checkpose();
        }

        if (counter >= 10000) { // 예를 들어 10000 프레임마다 카운터를 초기화
          counter = 0;
        }
      }

      //processFrame();
      //checkpose();

      if(true) {
        //Draw angles
        // 오른쪽 팔꿈치
        checkArm(PoseLandmarkType.rightWrist,
            PoseLandmarkType.rightPinky,
            PoseLandmarkType.rightIndex,
            PoseLandmarkType.rightShoulder,
            PoseLandmarkType.rightElbow, angles_mean[0], 0);
        // 왼쪽 팔꿈치
        checkArm(PoseLandmarkType.leftWrist,
            PoseLandmarkType.leftPinky,
            PoseLandmarkType.leftIndex,
            PoseLandmarkType.leftShoulder,
            PoseLandmarkType.leftElbow, angles_mean[1], 1);
        // 오른쪽 겨드랑이
        checkOther(PoseLandmarkType.rightElbow,
            PoseLandmarkType.rightHip,
            PoseLandmarkType.rightShoulder, angles_mean[2], 2);
        // 왼쪽 겨드랑이
        checkOther(PoseLandmarkType.leftElbow,
            PoseLandmarkType.leftHip,
            PoseLandmarkType.leftShoulder, angles_mean[3], 3);
        // 오른쪽 고관절
        checkOther(PoseLandmarkType.rightShoulder,
            PoseLandmarkType.rightKnee,
            PoseLandmarkType.rightHip, angles_mean[4], 4);
        // 왼쪽 고관절
        checkOther(PoseLandmarkType.leftShoulder,
            PoseLandmarkType.leftKnee,
            PoseLandmarkType.leftHip, angles_mean[5], 5);
        // 오른쪽 무릎
        checkOther(PoseLandmarkType.rightHip,
            PoseLandmarkType.rightAnkle,
            PoseLandmarkType.rightKnee, angles_mean[6], 6);
        // 왼쪽 무릎
        checkOther(PoseLandmarkType.leftHip,
            PoseLandmarkType.leftAnkle,
            PoseLandmarkType.leftKnee, angles_mean[7], 7);
      }

      //Draw arms
      /*
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, leftPaint);
      paintLine(
          PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist, leftPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow,
          rightPaint);
      paintLine(
          PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist, rightPaint);

      //Draw Body
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder, leftPaint);
      paintLine(
          PoseLandmarkType.rightHip, PoseLandmarkType.leftHip, leftPaint);
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, leftPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip,
          rightPaint);

      //Draw legs
      paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, leftPaint);
      paintLine(
          PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle, leftPaint);
      paintLine(
          PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, rightPaint);
      paintLine(
          PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle, rightPaint);

       */



      z = 0.0;

      /*

       */
    }


  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.poses != poses;
  }
}
