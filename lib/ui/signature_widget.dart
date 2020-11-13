import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signature/signature.dart';

class SignatureWidget extends StatelessWidget {
  Function onClick;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black87,
    exportBackgroundColor: Colors.white,
  );

  var hasSign = false;

  SignatureWidget(this.onClick);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title:
            const Text('Your signature', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              _controller.clear();
            },
            icon: Icon(Icons.replay),
          ),
          IconButton(
            onPressed: () {
              _saveSign();
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Signature(
          controller: _controller,
          backgroundColor: Colors.grey.shade100,
        ),
      ),
    );
  }

  _saveSign() async {
    if (_controller.isEmpty) {
      return;
    }
    print("pressed save");
    var data = await _controller.toPngBytes();
    onClick(data);
  }
}
