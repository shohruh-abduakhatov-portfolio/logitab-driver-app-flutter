// import 'package:flutter/material.dart';
// import 'package:driver_app_flutter/event/search_event.dart';
// import 'package:driver_app_flutter/rxbus.dart';
// import 'package:driver_app_flutter/event/route_event.dart';
// // import 'package:driver_app_flutter/widgets/cart_icon.dart';

// typedef SearchCallback = Function(String);

// class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final preferredSize = new Size.fromHeight(164.0);
//   final FocusNode focusNode;
//   final TextEditingController tfController;
//   final AnimationController animController;

//   final Animation<double> animation;
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   var showShadow;
//   var showBackButton;
//   var showSearch;
//   var showMenu;
//   String title = "";
//   String searchTitle = "";

//   var backBtnAction = RxBus.post(new RouteEvent("/"));

//   SimpleAppBar(this.title, this.scaffoldKey,
//       {this.backBtnAction,
//       this.showShadow = true,
//       this.showBackButton = false});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Theme.of(context).primaryColorDark,
//       child: Container(
//         decoration: showShadow //|| animation.value == 0.0
//             ? new BoxDecoration(
//                 color: Theme.of(context).primaryColorDark,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color.fromARGB(80, 20, 20, 20),
//                     blurRadius: 5.0, // has the effect of softening the shadow
//                     spreadRadius: 1.0, // has the effect of extending the shadow
//                     offset: Offset(
//                       0.0, // horizontal, move right 10
//                       0.0, // vertical, move down 10
//                     ),
//                   )
//                 ],
//               )
//             : null,
//         padding: const EdgeInsets.only(top: 32.0, bottom: 0.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 4.0, top: 0.0, bottom: 0.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   showBackButton && animation.value != 0.0
//                       ? new SizedBox(
//                           height: 48.0,
//                           width:
//                               animation.value > 48.0 ? 48.0 : animation.value,
//                           child: IconButton(
//                             padding: EdgeInsets.only(
//                                 left: 10.0,
//                                 right: 10.0,
//                                 bottom: 10.0,
//                                 top: 14.0),
//                             icon: Icon(
//                               Icons.arrow_back,
//                               color: Colors.white,
//                             ),
//                             onPressed: () => backBtnAction,
//                             color: Theme.of(context).primaryColorDark,
//                             iconSize: 28,
//                           ))
//                       : new SizedBox(),
//                   showMenu
//                       ? new SizedBox(
//                           height: 48.0,
//                           width:
//                               animation.value > 48.0 ? 48.0 : animation.value,
//                           child: IconButton(
//                             padding: EdgeInsets.only(
//                                 left: 14.0,
//                                 right: 14.0,
//                                 bottom: 10.0,
//                                 top: 18.0),
//                             icon: Image.asset(
//                               'assets/ic_menu.png',
//                               height: 28,
//                               color: Colors.white,
//                               fit: BoxFit.contain,
//                             ),
//                             onPressed: () =>
//                                 scaffoldKey.currentState.openDrawer(),
//                             color: Theme.of(context).primaryColorDark,
//                             iconSize: 28,
//                           ))
//                       : new SizedBox(),
//                   showMenu && showSearch
//                       ? SizedBox(
//                           width: animation.value > 28.0 ? 0.0 : 16.0,
//                           height: 58.0,
//                         )
//                       : new SizedBox(),
//                   !showSearch
//                       ? null
//                       : Flexible(
//                           child: Stack(
//                               alignment: Alignment.topCenter,
//                               children: <Widget>[
//                               Container(
//                                   margin: EdgeInsets.only(top: 8.0),
//                                   child: SizedBox(
//                                       height: 40,
//                                       child: TextField(
//                                         onSubmitted: (text) {
//                                           // FocusScope.of(context)
//                                           //     .requestFocus(new FocusNode());
//                                           // animController.reverse();
//                                         },
//                                         cursorColor:
//                                             Theme.of(context).primaryColorDark,
//                                         style: TextStyle(
//                                             color: Theme.of(context)
//                                                 .primaryColorDark,
//                                             decorationColor:
//                                                 Color.fromRGBO(0, 0, 0, 10),
//                                             fontSize: 19.0),
//                                         autocorrect: false,
//                                         controller: tfController,
//                                         decoration: InputDecoration(
//                                           contentPadding: const EdgeInsets.only(
//                                               right: 46.0,
//                                               left: 0.0,
//                                               top: 0,
//                                               bottom: 0),
//                                           prefixIcon: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 right: 10.0,
//                                                 left: 16.0,
//                                                 top: 10,
//                                                 bottom: 10),
//                                             child: Image.asset(
//                                               'assets/ic_search.png',
//                                               fit: BoxFit.contain,
//                                               color: animation.value != 0.0
//                                                   ? Colors.grey
//                                                   : Theme.of(context)
//                                                       .primaryColorDark,
//                                             ),
//                                           ),
//                                           fillColor: Colors.white,
//                                           filled: true,
//                                           hintText: " " + searchTitle,
//                                           focusedBorder: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(4.0),
//                                               borderSide: BorderSide(
//                                                   width: 1.0,
//                                                   color: Color.fromRGBO(
//                                                       0, 0, 0, 0.1))),
//                                           enabledBorder: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(4.0),
//                                               borderSide: BorderSide(
//                                                   width: 1.0,
//                                                   color: Color.fromRGBO(
//                                                       0, 0, 0, 0.1))),
//                                         ),
//                                         focusNode: focusNode,
//                                       ))),
//                               tfController.text != "" && animation.value == 0
//                                   ? Container(
//                                       alignment: Alignment.centerRight,
//                                       child: IconButton(
//                                         padding: EdgeInsets.only(
//                                             top: 16,
//                                             bottom: 12,
//                                             right: 12,
//                                             left: 12),
//                                         icon: Icon(Icons.highlight_off),
//                                         onPressed: () {
//                                           var t = tfController.text;
//                                           if (t.contains(" ")) {
//                                             t = t.substring(0, t.indexOf(" "));
//                                           } else {
//                                             t = "";
//                                           }
//                                           tfController.text = t;
//                                           FocusScope.of(context)
//                                               .requestFocus(this.focusNode);
//                                         },
//                                         color: Colors.redAccent,
//                                         iconSize: 24.0,
//                                       ))
//                                   : Container()
//                             ])),
//                   showSearch && animation.value == 0.0
//                       ? Container(
//                           alignment: Alignment.topRight,
//                           padding: EdgeInsets.only(top: 4.0),
//                           child: FlatButton(
//                             child: Text(
//                               "Отмена",
//                               style: TextStyle(
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.w500,
//                                   color: Theme.of(context).primaryColor),
//                             ),
//                             onPressed: () {
//                               FocusScope.of(context)
//                                   .requestFocus(new FocusNode());
//                               animController.reverse();
//                               RxBus.post(new SearchEvent(""));
//                             },
//                           ))
//                       : InkWell(
//                           borderRadius: BorderRadius.circular(48.0),
//                           onTap: () => openBasket(),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 16, right: 16, top: 8, bottom: 8),
//                             // child: CartIcon(),
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void openBasket() {
//     RxBus.post(new RouteEvent("/my/basket/"));
//   }
// }
