import 'package:flutter/material.dart';
import 'package:learn_flutter/utils/hexcolor.dart';

void main() {
  runApp(new MaterialApp(home: BillSplitter()));
}

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercent = 0;
  int _personCount = 1;
  double _billAmount = 0.0;
  final Color _purple = HexColor("#6908D6");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.1), //Colors.purpleAccent.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Total Per Person',
                          style: TextStyle(
                              color: _purple,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${calculateTotalPerPerson(_billAmount, _personCount, _tipPercent)} Rubai',
                          style: TextStyle(
                              color: _purple,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.blueGrey.shade100,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: _purple),
                    decoration: InputDecoration(
                        prefixText: "Bill Amount:  ",
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exc) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Split",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCount > 1) {
                                  _personCount--;
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.1)),
                              child: Center(
                                  child: Text("-",
                                      style: TextStyle(
                                          color: _purple,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ),
                          Text("$_personCount",
                              style: TextStyle(
                                  color: _purple,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCount >= 1) {
                                  _personCount++;
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.1)),
                              child: Center(
                                  child: Text("+",
                                      style: TextStyle(
                                          color: _purple,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tip",
                          style: TextStyle(color: Colors.grey.shade700)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${(calculateTotalTip(_billAmount, _personCount, _tipPercent)).toStringAsFixed(2)}",
                          style: TextStyle(
                              color: _purple,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("$_tipPercent%",
                          style: TextStyle(
                              color: _purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0)),
                      Slider(
                          min: 0,
                          max: 100,
                          divisions: 20,
                          activeColor: _purple,
                          inactiveColor: Colors.grey.shade700,
                          value: _tipPercent.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              _tipPercent = value.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercent) {
    double totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercent) + billAmount) / splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercent) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
    } else {
      totalTip = billAmount * tipPercent / 100;
    }
    return totalTip;
  }
}
