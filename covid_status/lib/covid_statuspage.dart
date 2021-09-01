import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'box_status.dart';

class CovidStatus extends StatefulWidget {
  const CovidStatus({Key? key}) : super(key: key);

  @override
  _CovidStatusState createState() => _CovidStatusState();
}

class _CovidStatusState extends State<CovidStatus> {
  TextEditingController date = TextEditingController();
  TextEditingController newcase = TextEditingController();
  TextEditingController totalCase = TextEditingController();
  TextEditingController newCaseExcludeaboard = TextEditingController();
  TextEditingController totalCaseExcludeaboard = TextEditingController();
  TextEditingController updateDate = TextEditingController();
  @override
  void initState() {
    super.initState();

    date.text = "-";
    newcase.text = '-';
    totalCase.text = '-';
    newCaseExcludeaboard.text = '-';
    totalCaseExcludeaboard.text = '-';
    updateDate.text = '-';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid status'),
        actions: [
          IconButton(
              onPressed: () {
                print('get data covid');
                getCovidData();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BoxStatus(
                  head: 'date',
                  data: date,
                ),
                BoxStatus(
                  data: newcase,
                  head: 'New Case',
                ),
                BoxStatus(
                  head: 'Total Case',
                  data: totalCase,
                ),
                BoxStatus(
                  data: newCaseExcludeaboard,
                  head: 'New case excluded',
                ),
                BoxStatus(
                  head: 'Total case excluded',
                  data: totalCaseExcludeaboard,
                ),
                BoxStatus(
                  data: updateDate,
                  head: 'Update',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

//https://covid19.ddc.moph.go.th/api/Cases/today-cases-all
  Future getCovidData() async {
    var url = Uri.https('covid19.ddc.moph.go.th', '/api/Cases/today-cases-all');
    var response = await http.get(url);
    print(response.body);

    var result = json.decode(response.body);
    var _date = result[0]["txn_date"].toString();
    var _new_case = result[0]["new_case"];
    var _total_case = result[0]["total_case"];
    var _new_case_excludeabroad = result[0]["new_case_excludeabroad"];
    var _total_case_excludebroad = result[0]["total_case_excludeabroad"];
    var _update_date = result[0]["update_date"].toString();

    var formatter = NumberFormat('###,###,###');
    setState(() {
      date.text = _date;
      newcase.text = formatter.format(_new_case);
      totalCase.text = formatter.format(_total_case);
      newCaseExcludeaboard.text = formatter.format(_new_case_excludeabroad);
      totalCaseExcludeaboard.text = formatter.format(_total_case_excludebroad);
      updateDate.text = _update_date;
    });
  }
}
