part of '/common.dart';

Future<LottoInfo> fetchLotto() async {
  String url =
      'https://cors-anywhere.herokuapp.com/https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=931';

  String url_2 =
      'https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=931';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    //
    return LottoInfo.fromJson(jsonDecode(response.body));
  } else {
    //
    throw Exception('failed to load Data');
  }
}
