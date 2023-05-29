import 'package:codeco/add_qrcode.dart';
import 'package:codeco/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'codeco',
      home: MyHomePage(),
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  final itemCount = 8;

  final List<Widget> _pages = [
    SettingsPage(),
    AddQrCodePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('ホーム'),
      ),
      child: SafeArea(
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            iconSize: 24,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'ホーム',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.qrcode),
                label: 'QR追加',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings_solid),
                label: '設定',
              ),
            ],
            currentIndex: selectedIndex,
            onTap: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          tabBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return const MyQRList();
              case 1:
                return AddQrCodePage();
              default:
                return const SettingsPage();
            }
          },
        ),
      ),
    );
  }
}

class MyQRList extends StatefulWidget {
  const MyQRList({Key? key}) : super(key: key);

  @override
  State<MyQRList> createState() => _MyQRListState();
}

class _MyQRListState extends State<MyQRList> {
  final itemCount = 8;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: 350,
                    height: 50,
                    child: const CupertinoSearchTextField(
                      placeholder: 'キーワードを入力して検索',
                      placeholderStyle: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey2,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ChoiceChipArea(),
                    ],
                  ),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return CupertinoListTile(
                  title: const Text(
                    'ここにタイトルが入ります',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Image.asset(
                    'assets/images/no-image.jpeg',
                    height: 120,
                    width: 80,
                  ),
                  leadingSize: 70,
                  trailing: Wrap(
                    spacing: 8,
                    children: const [
                      Icon(Icons.edit,
                          size: 20, color: CupertinoColors.systemGrey),
                      Icon(Icons.delete,
                          size: 20, color: CupertinoColors.systemGrey),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          '有効期限：2023/12/31',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 28,
                            child: CupertinoButton(
                              alignment: Alignment.center,
                              padding: EdgeInsets.zero,
                              borderRadius: BorderRadius.circular(20),
                              onPressed: () {
                                print('Tap 五十音順');
                              },
                              color: CupertinoColors.systemGrey5,
                              child: const Text(
                                'QRコードを表示',
                                style: TextStyle(
                                  color: Color(0xFF191970),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          SizedBox(
                            width: 80,
                            height: 28,
                            child: CupertinoButton(
                              alignment: Alignment.center,
                              padding: EdgeInsets.zero,
                              borderRadius: BorderRadius.circular(20),
                              onPressed: () {
                                print('Tap 五十音順');
                              },
                              color: CupertinoColors.systemGrey5,
                              child: const Text(
                                '使った！',
                                style: TextStyle(
                                  color: Color(0xFF191970),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(15),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 0.5);
              },
              itemCount: itemCount + 2,
            ),
          ],
        ),
      ),
    );
  }
}

final List<String> entries = <String>[
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
];

class ChoiceChipArea extends StatefulWidget {
  @override
  _ChoiceChipAreaState createState() => _ChoiceChipAreaState();
}

class _ChoiceChipAreaState extends State<ChoiceChipArea> {
  int? selectedChipIndex = 0;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: 350,
            child: Wrap(
              spacing: 8.0,
              children: [
                ChoiceChip(
                  label: const Text('期限が近い順'),
                  selected: selectedChipIndex == 0,
                  selectedColor: const Color(0xFFFFC0CB),
                  backgroundColor: CupertinoColors.systemGrey5,
                  onSelected: (selected) {
                    setState(() {
                      selectedChipIndex = selected ? 0 : 0;
                    });
                  },
                  labelStyle: TextStyle(
                    color: selectedChipIndex == 0
                        ? const Color(0xFFDC143C)
                        : const Color(0xFF333333),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text('五十音順'),
                  selected: selectedChipIndex == 1,
                  selectedColor: const Color(0xFFFFC0CB),
                  backgroundColor: CupertinoColors.systemGrey5,
                  onSelected: (selected) {
                    setState(() {
                      selectedChipIndex = selected ? 1 : 1;
                    });
                  },
                  labelStyle: TextStyle(
                    color: selectedChipIndex == 1
                        ? const Color(0xFFDC143C)
                        : const Color(0xFF333333),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text('お気に入り'),
                  selected: selectedChipIndex == 2,
                  selectedColor: const Color(0xFFFFC0CB),
                  backgroundColor: CupertinoColors.systemGrey5,
                  onSelected: (selected) {
                    setState(() {
                      selectedChipIndex = selected ? 2 : 2;
                    });
                  },
                  labelStyle: TextStyle(
                    color: selectedChipIndex == 2
                        ? const Color(0xFFDC143C)
                        : const Color(0xFF333333),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
