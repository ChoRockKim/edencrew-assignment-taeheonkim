import 'dart:convert';
import 'package:http/http.dart' as http;

class NaverApi {
  static const String _acHost = 'ac.stock.naver.com';

  Future<List<dynamic>> search(String query) async {
    final Uri uri = Uri.https(_acHost, '/ac', <String, String>{
      'q': query,
      'target': 'stock,ipo,index,marketindicator',
    });

    final http.Response response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('검색 실패: ${response.statusCode}');
    }

    final Map<String, dynamic> body =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    return body['items'] as List<dynamic>? ?? <dynamic>[];
  }
}
