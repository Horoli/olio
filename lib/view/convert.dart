part of '/common.dart';

class ViewConvertText extends StatefulWidget {
  const ViewConvertText({Key? key}) : super(key: key);

  @override
  _ViewConvertTextState createState() => _ViewConvertTextState();
}

class _ViewConvertTextState extends State<ViewConvertText> {
  String pattern =
      '\\d*\\n\\d{2}:\\d{2}:\\d{2},\\d{3} --> \\d{2}:\\d{2}:\\d{2},\\d{3}\\n';
  late TextEditingController ctrText = TextEditingController();
  late TextEditingController ctrPattern = TextEditingController(text: pattern);
  TStream<bool> $fieldFixed = TStream<bool>()..sink$(true);
  TStream<String> $text = TStream<String>();
  //
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(color: Colors.amber).expand(),
        Row(
          children: [
            Container(color: Colors.blue).expand(),
            Container(color: Colors.red).expand(),
          ],
        ).expand(),
        Container(color: Colors.amber).expand(),
      ],
    );
  }

  Widget buildInputPattern() {
    return TStreamBuilder(
      stream: $fieldFixed.browse$,
      builder: (BuildContext context, bool isFixed) {
        return TextFormField(
          readOnly: isFixed,
          controller: ctrPattern,
        );
      },
    );
  }

  Widget buildFixedFlagButton() {
    return TStreamBuilder(
      stream: $fieldFixed.browse$,
      builder: (BuildContext context, bool isFixed) {
        String label = isFixed ? 'fixed' : 'unfixed';
        return ElevatedButton(
          onPressed: () {
            $fieldFixed.sink$(!isFixed);
          },
          child: Text(label),
        );
      },
    );
  }

  Widget buildInput() {
    return TextFormField(
      controller: ctrText,
      maxLines: null,
    );
  }

  Widget buildConvertButton() {
    RegExp exp = RegExp(ctrPattern.text);
    return ElevatedButton(
      child: const Text('convert'),
      onPressed: () {
        String convertText = ctrText.text.replaceAll(exp, '');
        $text.sink$(convertText);
      },
    );
  }

  Widget buildCopyButton() {
    return ElevatedButton(
      child: const Text('copy'),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: $text.lastValue));
      },
    );
  }

  Widget buildResultText() {
    return TStreamBuilder(
      stream: $text.browse$,
      builder: (BuildContext context, String text) {
        return Container(
          color: Colors.white,
          child: Text('$text'),
        );
      },
    );
  }
}
