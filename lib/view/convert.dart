part of '/common.dart';

class ViewConvertText extends StatefulWidget {
  const ViewConvertText({Key? key}) : super(key: key);

  @override
  _ViewConvertTextState createState() => _ViewConvertTextState();
}

class _ViewConvertTextState extends State<ViewConvertText> {
  late double maxWidth = MediaQuery.of(context).size.width;
  late double maxheight = MediaQuery.of(context).size.height;

  String pattern =
      '\\d*\\n\\d{2}:\\d{2}:\\d{2},\\d{3} --> \\d{2}:\\d{2}:\\d{2},\\d{3}\\n';
  late TextEditingController ctrText = TextEditingController();
  late TextEditingController ctrPattern = TextEditingController(text: pattern);
  TStream<bool> $fieldFixed = TStream<bool>()..sink$(true);
  TStream<String> $text = TStream<String>()..sink$('');
  //
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: maxWidth * 0.95,
        height: maxheight * 0.8,
        child: Column(
          children: [
            //
            Row(
              children: [
                buildInputPattern().expand(),
                buildFixedFlagButton(),
              ],
            ).expand(),
            //
            Row(
              children: [
                buildTextFormField(controller: ctrText).expand(),
                const Icon(Icons.arrow_forward),
                buildResultText().expand(),
              ],
            ).expand(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildConvertButton(),
                buildCopyButton(),
              ],
            ).expand(),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField({TextEditingController? controller}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      height: double.infinity,
      child: TextFormField(
        controller: controller,
        maxLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
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
        String label = isFixed ? 'unfixing' : 'fixing';
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: COLOR.CHICK_YELLOW,
          ),
          child: Text(label, style: const TextStyle(color: COLOR.GREY)),
          onPressed: () {
            $fieldFixed.sink$(!isFixed);
          },
        );
      },
    );
  }

  Widget buildConvertButton() {
    RegExp exp = RegExp(ctrPattern.text);
    String label = 'convert';

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: COLOR.CHICK_YELLOW,
      ),
      child: Text(label, style: const TextStyle(color: COLOR.GREY)),
      onPressed: () {
        if (ctrText.text.length < 5) {
          showSnackBar('5자 이상 입력하세요.');
          return;
        }
        if (ctrText.text.length >= 5) {
          String convertText = ctrText.text.replaceAll(exp, '');
          $text.sink$(convertText);
          return;
        }
      },
    );
  }

  Widget buildCopyButton() {
    String label = 'copy';
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: COLOR.CHICK_YELLOW,
      ),
      child: Text(label, style: const TextStyle(color: COLOR.GREY)),
      onPressed: () {
        if ($text.lastValue.length < 5) {
          showSnackBar('5자 이상 입력하세요.');
          return;
        }

        if ($text.lastValue.length >= 5) {
          Clipboard.setData(ClipboardData(text: $text.lastValue));
          showSnackBar('copy complete');
        }
      },
    );
  }

  void showSnackBar(String label) {
    SnackBar snackBar = SnackBar(
      content: Text(label),
      duration: const Duration(seconds: 3),
    );
    // return snackBar;

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // SnackBar snackBar = const SnackBar(
  //   content: Text('copy complete'),
  //   duration: Duration(seconds: 3),
  // );

  Widget buildResultText() {
    return TStreamBuilder(
      stream: $text.browse$,
      builder: (BuildContext context, String text) {
        return Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
          ),
          child: SelectableText(
            text,
            showCursor: true,

            // onTap: () {
            // Clipboard.setData(ClipboardData(text: $text.lastValue));
            // },
          ),
        );
      },
    );
  }
}
