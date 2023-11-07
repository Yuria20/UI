class YogaPose {
  final String name;
  final String imageAsset;
  final String description;

  YogaPose({
    required this.name,
    required this.imageAsset,
    required this.description,
  });
}
// 자세 정보를 저장한 리스트
List<YogaPose> yogaPoses = [
  YogaPose(
    name: '다운독',
    imageAsset: 'assets/p_button/p_button1.png',
    description: '다운독 자세 설명',
  ),
  YogaPose(
    name: '스플릿',
    imageAsset: 'assets/p_button/p_button2.png',
    description: '스플릿 자세 설명',
  ),
  // 다른 자세들을 추가할 수 있습니다.
];
