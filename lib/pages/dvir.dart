import 'package:driver_app_flutter/event/route_event.dart';
import 'package:driver_app_flutter/models/dvir.dart';
import 'package:driver_app_flutter/rxbus.dart';
import 'package:driver_app_flutter/ui/dvir_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DVIRPage extends StatefulWidget {
  @override
  _DVIRPageState createState() => _DVIRPageState();
}

class _DVIRPageState extends State<DVIRPage> {
  List<DVIR> dvirList;

  @override
  void initState() {
    super.initState();
    RxBus.post(RouteEvent("/dvir/"));
    dvirList = loadData();
  }

  onDvirDelete(id) {
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
          child: dvirList != null
              ? Container(
                  padding: EdgeInsets.only(right: 15, left: 15),
                  child: ListView.builder(
                    itemCount: dvirList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return new DVIRItemWidget(
                        dvirList[index],
                        onDelete: onDvirDelete,
                        onEdit: onDvirEdit,
                      );
                    },
                  ))
              : Column()),
    );
  }

  onDvirEdit(id) {
    print(id);
    RxBus.post(RouteEvent(
        MyRoute.DVIR_EDIT,
        new DVIR(1, "asd", "weq", "120", "DEFECT", null, new DateTime.now(),
            "samarkand, uzbekistan")));
  }

  List<DVIR> loadData() {
    // API.editRequestsList().then((response) {
    //   if (!mounted) return;
    //   if (response.statusCode == 401) {
    //     Navigator.of(context).pushNamedAndRemoveUntil(
    //         '/login/', (Route<dynamic> route) => false);
    //     return;
    //   }
    //   if (response.statusCode != 200) return;
    //   var parsed = jsonDecode(response.body)['data'];

    //   List<DVIR> _dvirList = List();
    //   for (final i in parsed) {
    //     _dvirList.add(DVIR.fromJson(i));
    //   }
    //   setState(() {
    //     dvirList = _dvirList;
    //   });
    // }).catchError((onError) => print(onError));
    List<DVIR> _d = [
      new DVIR(1, "", null, "123", "", "", new DateTime.now(),
          "samarkand, uzbekistan"),
      new DVIR(1, "asd", "weq", "123", "123", null, new DateTime.now(),
          "samarkand, uzbekistan"),
    ];
    return _d;
  }
}
