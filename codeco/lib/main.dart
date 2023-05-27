import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'codeco',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('ホーム'),
      ),
      child: SafeArea(
        child: _MyHomePageState(),
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
  'G'
];

class _MyHomePageState extends StatelessWidget {
  const _MyHomePageState({super.key});

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
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
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) => CupertinoPageScaffold(
              child: SingleChildScrollView(
                  child: Column(children: [
            Container(
              height: 150,
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  width: 350,
                  height: 50,
                  child: CupertinoSearchTextField(
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
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        borderRadius: BorderRadius.circular(20),
                        child: Text(
                          '期限が近い順',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        onPressed: () {
                          print('Tap 期限が近い順');
                        },
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                        width: 100,
                        height: 30,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          borderRadius: BorderRadius.circular(20),
                          child: Text(
                            'お気に入り',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          onPressed: () {
                            print('Tap お気に入り');
                          },
                          color: Colors.blue,
                        )),
                    SizedBox(
                        width: 100,
                        height: 30,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          borderRadius: BorderRadius.circular(20),
                          child: Text(
                            '五十音順',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          onPressed: () {
                            print('Tap 五十音順');
                          },
                          color: Colors.blue,
                        )),
                  ],
                ),
              ]),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return CupertinoListTile(
                    title: Text(
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
                      children: [
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
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
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
                                  child: Text(
                                    'QRコードを表示',
                                    style: TextStyle(
                                      color: Color(0xFF191970),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    print('Tap 五十音順');
                                  },
                                  color: CupertinoColors.systemGrey5,
                                )),
                            // 余白
                            SizedBox(width: 15),
                            SizedBox(
                                width: 80,
                                height: 28,
                                child: CupertinoButton(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.zero,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Text(
                                    '使った！',
                                    style: TextStyle(
                                      color: Color(0xFF191970),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    print('Tap 五十音順');
                                  },
                                  color: CupertinoColors.systemGrey5,
                                )),
                          ],
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(15),
                  );
                }),
          ]))),
        );
      });
}
