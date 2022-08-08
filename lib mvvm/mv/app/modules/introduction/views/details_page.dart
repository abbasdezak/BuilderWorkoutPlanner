import 'package:builderworkoutplanner/models/time_helper.dart';
import 'package:builderworkoutplanner/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(body: QuestionsWidget());
  }
}

class QuestionsWidget extends StatefulWidget {
  const QuestionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  _QuestionsWidgetState createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends State<QuestionsWidget> {
  LocalStorage localStorage = LocalStorage('Settings');
  final _controller1 = new TextEditingController();
  final _controller2 = new TextEditingController();
  final _controller3 = new TextEditingController();
  final _formField = GlobalKey<FormState>();
  var initpg = 0;
  var val = 0;
  var value = false;
  @override
  void dispose() {
    // TODO: implement dispose
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Widget> wdgtList = [firstPage(size), secPage(size)];
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create better',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.height * .05,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Body together',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.height * .05,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              height: size.height * .418,
              width: size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/details_image.jpg"),
                fit: BoxFit.fill,
              )),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: size.height * .4,
            child: Container(
                width: double.infinity,
                height: size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: wdgtList[initpg]),
          )
        ],
      ),
    );
  }

  Widget Btn(Size size, String text, BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),
        width: size.width * .87,
        height: size.height * .055,
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color(Colors.blue.value.toInt()))),
            child: Text(
              '$text',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height * .025,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              print(val);
              if (val == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please Specify your gender.'),
                  ),
                );
              }
             else if (_formField.currentState!.validate()) {
                if (text == 'Lets Rock') {
                  TimeHelper.settingsSaver(
                    reps: int.parse(_controller1.text),
                    sets: int.parse(_controller2.text),
                    rest: int.parse(_controller3.text),
                  );
                  _controller1.clear();
                  _controller2.clear();
                  _controller3.clear();
                  print(localStorage.getItem('Setting'));

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                }
               else {
                TimeHelper.settingsSaver(
                    name: _controller1.text,
                    weight: int.parse(_controller2.text),
                    height: int.parse(_controller3.text),
                    gender: val);
                print(localStorage.getItem('Setting'));
                setState(() {
                  initpg = 1;
                  _controller1.clear();
                  _controller2.clear();
                  _controller3.clear();
                });
              }}
            }));
  }

  Widget firstPage(Size size) {
    return Form(
      key: _formField,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            'Personal',
            style: TextStyle(
                fontSize: size.height * .035, fontWeight: FontWeight.bold),
          ),
          TxtField('Full Name', false, _controller1, false),
          TxtField('Weight', true, _controller2, true),
          TxtField('Height', true, _controller3, true),
          RadioWidget(size),
          Btn(size, 'Next', this.context),
        ],
      ),
    );
  }

  Widget secPage(Size size) {
    return Form(
      key: _formField,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Workout',
            style: TextStyle(
                fontSize: size.height * .035, fontWeight: FontWeight.bold),
          ),
          TxtField('Reps', true, _controller1, false),
          TxtField('Sets', true, _controller2, false),
          TxtField('Rest. eg 30', true, _controller3, false),
          Btn(size, 'Lets Rock', this.context)
        ],
      ),
    );
  }

  Row RadioWidget(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Gender',
          style: TextStyle(
              fontSize: size.height * .025, fontWeight: FontWeight.bold),
        ),
        Container(
            child: Row(
          children: [
            Text('Male'),
            Radio(
              value: 1,
              groupValue: val,
              onChanged: (value) {
                setState(() {
                  val = value as int;
                });
              },
              activeColor: Colors.blue,
            ),
          ],
        )),
        Container(
            child: Row(
          children: [
            Text('Female'),
            Radio(
              value: 2,
              groupValue: val,
              onChanged: (value) {
                setState(() {
                  val = value as int;
                });
              },
              activeColor: Colors.blue,
            ),
          ],
        )),
      ],
    );
  }

  Widget TxtField(textHint, bool isInt, TextEditingController _controller,
      bool requredValid) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 15, left: 15),
      child: TextFormField(
          controller: _controller,
          validator: (String? value) {
            if (isInt) {
              if (value == null || value.isEmpty) {
                return 'Cant be empty';
              } else if (requredValid &
                  (int.parse(value) < 20 || int.parse(value) > 300)) {
                return 'Please enter valid numbers';
              } else {
                return (!value.contains(RegExp(r'^[0-9]*$')))
                    ? 'Only Numbers.'
                    : null;
              }
            } else {
              return (value == null || value.isEmpty) ? 'Cant be Empty' : null;
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            labelText: '$textHint',
          )),
    );
  }
}
