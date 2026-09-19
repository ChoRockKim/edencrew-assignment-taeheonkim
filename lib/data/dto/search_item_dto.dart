import 'package:edencrew_assignment_starter/model/stock.dart';

class SearchItemDto {
  const SearchItemDto({
    required this.code,
    required this.name,
    required this.typeName,
    required this.nationCode,
    required this.category,
  });
  // 데이터 가공
  factory SearchItemDto.fromJson(Map<String, dynamic> json) {
    return SearchItemDto(
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      typeName: json['typeName'] as String? ?? '',
      nationCode: json['nationCode'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }

  final String code;
  final String name;
  final String typeName;
  final String nationCode;
  final String category;

  // 국내주식 & 6자리 코드만 통과
  bool get isDomesticStock {
    if (nationCode != 'KOR') return false;
    if (category != 'stock') return false;
    return RegExp(r'^\d{6}$').hasMatch(code);
  }

  // 모델 데이터로 가공
  Stock toStock() {
    return Stock(
      id: 'domestic:$code',
      name: name,
      symbol: code,
      market: typeName,
    );
  }
}
