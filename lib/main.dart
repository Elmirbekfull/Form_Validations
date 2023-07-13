import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>(); //key for form
  String name = "";
  String phoneNumber = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFffffff),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Form(
          key: formKey, //key for form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.04),
              Text(
                "Форманы текшерүү",
                style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
              ),
              Text(
                "Кош келиңиз !",
                style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
              ),
              SizedBox(height: height * 0.05,),
              _CheckLoginPassword(
                onFormSubmit: _handleFormSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFormSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // Отправить данные (номер телефона, адрес, имя) на сервер или выполнить другие операции
      print('Имя: $name');
      print('Номер телефона: $phoneNumber');
      print('Электронная почта: $email');
    }
  }
}

class _CheckLoginPassword extends StatefulWidget {
  final VoidCallback onFormSubmit;

  const _CheckLoginPassword({
    Key? key,
    required this.onFormSubmit,
  }) : super(key: key);

  @override
  State<_CheckLoginPassword> createState() => _CheckLoginPasswordState();
}

class _CheckLoginPasswordState extends State<_CheckLoginPassword> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Аты жөнүңүз",
          ),
          validator: (value) {
            if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
              return "Туура аты-жөнүңүздү калтырыңыз";
            } else {
              return null;
            }
          },
          onSaved: (value) {
            setState(() {
              widget.onFormSubmit();
            });
          },
        ),
        SizedBox(height: height * 0.05),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Телефон номериңиз",
          ),
          validator: (value) {
            if (value!.isEmpty ||
                !RegExp(r'^\+996\s\d{3}\s\d{3}\s\d{3}$').hasMatch(value)) {
              return "Туура номериңизди калтырыңыз";
            } else {
              return null;
            }
          },
          onSaved: (value) {
            setState(() {
              widget.onFormSubmit();
            });
          },
        ),
        SizedBox(height: height * 0.05),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Электрондук почтаңыз",
          ),
          validator: (value) {
            if (value!.isEmpty ||
                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
              return "Туура почтаңызды калтырыңыз";
            } else {
              return null;
            }
          },
          onSaved: (value) {
            setState(() {
              widget.onFormSubmit();
            });
          },
        ),
        // SizedBox(height: height * 0.1),
        SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Катталуу", style: TextStyle(
              color: Color(0xFF363f93),
              fontSize: 22,
            ),),
          
            // ElevatedButton(
            //   onPressed: widget.onFormSubmit,
            //   child: Text('Отправить'),
            // ),
            Container(
              width: 70,
              height: 70,
              child: IconButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFF363f93),)
                ),
                onPressed: widget.onFormSubmit,
                 icon: const CircleAvatar(
                  backgroundColor: Color(0xFF363f93),
                  child: Icon(
                    Icons.chevron_right_outlined,
                     color: Colors.white,  
                     ),
                 )),
            ),
          ],
        ),
        SizedBox(height: 65,),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Кирүү", style: TextStyle(
              fontWeight: FontWeight.w600,
            ),),
            Text("Пароль түзүү", style: TextStyle(
              color: Colors.grey
            ),),
          ],
        )
      ],
    );
  }
}
