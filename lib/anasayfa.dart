import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_homework5/renkler.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

final myController = TextEditingController();
bool hesaplanabilirMi = false;
bool operatorEklenebilirMi= false;

class _AnasayfaState extends State<Anasayfa> {
  //--------------------------------------------------

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${myController.text}');
  }

  //--------------------------------------------------
  final ButtonStyle style = ElevatedButton.styleFrom(
    elevation: 0.0,
    primary: Colors.red.withOpacity(0),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(2),
        ),
        side: BorderSide(color: Colors.white)),
  );

  //-*----------------------------------*-------------

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;
    final int buttonSize = (ekranGenisligi / 5).toInt();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Hesap Makinesi"),
        ),
        body: Center(
            child: Column(
          children: [
            Container(
              color: ekranArkaPlan,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 5, top: 5, right: 20),
                    child: Column(
                      children: [
                        TextField(
                          enabled: false,
                          controller: myController,
                          onChanged: (value) {
                            print('First text field: ');
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 50, color: Colors.white),
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: '',
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //-------------------------------------------
            Container(
                color: tuslarArkaPlan,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, top: 10),
                        child: Column(children: [
                          ElevatedButton(
                            onPressed: () {
                              myController.clear();
                            },
                            child: Text(
                              "C",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(), //<-- SEE HERE
                                primary: silmeTusu,
                                padding: EdgeInsets.all(25)),
                          ),
                          Tus(numara: "1"),
                          Tus(numara: "4"),
                          Tus(numara: "7"),
                          Tus(numara: "0"),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, top: 10),
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if(hesaplanabilirMi == true){
                                  var islemListesi = [];
                                  var temp ="";
                                  for(int i=0; i<myController.text.length;i++){
                                    if(myController.text[i]=="+"){
                                      islemListesi.add(temp);
                                      temp = "";
                                    }else{
                                      temp += myController.text[i];
                                    }
                                  }
                                  if(temp.length>0){
                                    islemListesi.add(temp);
                                    temp="";
                                  }
                                  print("liste = $islemListesi");
                                  //*************
                                  int toplam = 0;
                                  for(var number in islemListesi){
                                    toplam += int.parse(number);
                                  }
                                  myController.text=toplam.toString();

                                }
                              },
                              child: Text(
                                "=",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(), //<-- SEE HERE
                                  primary: Colors.blue,
                                  padding: EdgeInsets.all(25)),
                            ),
                            Tus(numara: "2"),
                            Tus(numara: "5"),
                            Tus(numara: "8"),
                            Tus(numara: ""),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, top: 10),
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if(operatorEklenebilirMi == true){
                                  print(operatorEklenebilirMi);
                                  myController.text += "+";
                                  operatorEklenebilirMi =false;
                                }
                              },
                              child: Text(
                                "+",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(), //<-- SEE HERE
                                  primary: Colors.green,
                                  padding: EdgeInsets.all(25)),
                            ),
                            Tus(numara: "3"),
                            Tus(numara: "6"),
                            Tus(numara: "9"),
                            Tus(numara: ""),
                          ],
                        ),
                      ),
                    ])),
          ],
        )));
  }
}

class Tus extends StatelessWidget {
  String numara;

  Tus({required this.numara});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Respond to button press
        if (numara.length > 0) {
          myController.text += numara;
          hesaplanabilirMi = true;
          operatorEklenebilirMi = true;
          print(numara);
        }
      },
      child: Text(
        numara,
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        primary: tuslarArkaPlan,

        padding: const EdgeInsets.fromLTRB(20, 30, 20, 42),
        //primary: Colors.red.withOpacity(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
        ),
      ),
    );
  }
}
