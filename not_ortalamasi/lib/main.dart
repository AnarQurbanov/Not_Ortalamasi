import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Not Ortalaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  double vizeNotu = -1;
  double finalNotu = -1;
  String mesaj = "";
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var ekranU = MediaQuery.of(context).size.height;
    var ekranE = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Container(
                height: ekranU / 4,
                width: ekranU / 4,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/bookLogo.png")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder( //border rengi
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: 'Vize Notu',
                    labelStyle: TextStyle(color: Colors.blue),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen notu giriniz';
                    } else {
                      try {
                        double deger = double.parse(value);
                        if (deger < 0 || deger > 100) {
                          return "Lütfen doğru not giriniz";
                        }
                      } catch (e) {
                        return "Lütfen doğru not giriniz";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    this.vizeNotu = double.parse("$value");
                  },
                ),
              ),
              SizedBox(height: ekranU / 17),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)), //border rengi
                    labelText: 'Final Notu',
                    labelStyle: TextStyle(color: Colors.blue),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen notu giriniz';
                    } else {
                      try {
                        double deger = double.parse(value);
                        if (deger < 0 || deger > 100) {
                          return "Lütfen doğru not giriniz";
                        }
                      } catch (e) {
                        return "Lütfen doğru not giriniz";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    this.finalNotu = double.parse("$value");
                  },
                ),
              ),
              SizedBox(
                height: ekranU / 17,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50,right: 50),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      //girdiler sorunsuz ise
                      formKey.currentState!.save(); //save et
                      setState(() {
                        double ortalama = vizeNotu * 0.4 + finalNotu * 0.6;
                        if (ortalama >= 50 && finalNotu >= 50) {
                          mesaj = "Sizin ortalamanız : $ortalama\nDersi Geçtiniz";
                        } else if (finalNotu < 50) {
                          mesaj =
                              "Sizin ortalamanız : $ortalama\nFinal puanı 50'den düşük\nDersten kaldınız";
                        } else {
                          mesaj =
                              "Sizin ortalamanız : $ortalama\nDersten kaldınız";
                        }
                      });
                    }
                  },
                  child: Text("Sonucu Gör"),
                ),
              ),
              SizedBox(
                height: ekranU / 17,
              ),
              Text(
                mesaj,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: ekranU / 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
