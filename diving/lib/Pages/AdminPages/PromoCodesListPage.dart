import 'package:diving/Pages/AdminPages/CreateNewPromoCodePage.dart';
import 'package:flutter/material.dart';
import '../../Controllers/PromoCodeController.dart';
import '../../Controllers/UserController.dart';
import '../../Models/PromoCode.dart';
import '../../Models/User.dart';
import '../../Repository/PromoCodeRepository.dart';
import '../../Repository/UserRepository.dart';
import 'AdminHomePage.dart';
import 'EditingPromoCodeInfoPage.dart';


class PromoCodesListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PromoCodesListPageState();
  }
  final User user;
  PromoCodesListPage(this.user);
}

class _PromoCodesListPageState extends State<PromoCodesListPage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";
  var curLanguage = "Українська";

  final idController = TextEditingController(text: "");
  final promoCodeController = PromoCodeController(PromoCodeRepository());
  final userController = UserController(UserRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
          centerTitle: true,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return AdminHomePage(widget.user);
                    }), (route) => false);
              },
              icon: const Icon(Icons.arrow_back),
            );
          }),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                    value: ukrLanguage,
                    child: Text(
                      ukrLanguage,
                      style: TextStyle(color: Colors.white),
                    )),
                PopupMenuItem(
                  child:
                  Text(engLanguage, style: TextStyle(color: Colors.white)),
                  value: engLanguage,
                )
              ],
              onSelected: (String newValue) {
                setState(() {
                  curLanguage = newValue;
                });
              },
              color: Colors.black,
              child: Icon(Icons.location_on),
            ),
            IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
                icon: const Icon(Icons.search))
          ],
          title: const Text('ProDiver Admin'),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.indigo,
                  Colors.red,
                ],
              )),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 500,
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                        future: promoCodeController.getPromoCodesList(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Text('Loading...');
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                final promoCode = snapshot.data[i] as PromoCode;
                                return Card(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.pushAndRemoveUntil(context,
                                            MaterialPageRoute(builder: (BuildContext context) {
                                              return EditingPromoCodeInfoPage(widget.user,promoCode);
                                            }), (route) => false);
                                      },
                                      child: ListTile(
                                          title: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: Text('Id: ${promoCode.id}'),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerRight,
                                                child: Text('PromoCode: ${promoCode.promoCode}'),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Text('Discount: ${promoCode.discount}'),
                                                  alignment: Alignment.centerRight,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.centerRight,
                                                  child: Text('Is active: ${promoCode.isActive}'),
                                                ),
                                              ),
                                            ],
                                          ),
                                      ),

                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }),
                  ),
                ),
                Container(
                  height: 40,
                  width: 250,
                  margin: EdgeInsetsDirectional.fromSTEB(100, 35, 100, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () async{
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return CreateNewPromoCodePage(widget.user);
                          }), (route) => false);
                    },
                    child: Text('Create new promo code',style: TextStyle(color: Colors.white, fontSize: 15),),
                  ),
                ),
                Container(
                  height: 40,
                  width: 250,
                  margin: EdgeInsetsDirectional.fromSTEB(100, 35, 100, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () async{
                      showDialog(context: context,
                          builder: (context) => SimpleDialog(
                            title: Text("Do you really want to delete this promo code?"),
                            contentPadding: const EdgeInsets.all(20.0),
                            children: [
                              TextFormField(controller: idController),
                              TextButton(onPressed: () async{
                                if(idController.text != "0"){
                                  await promoCodeController.deletePromoCode(int.parse(idController.text));
                                }
                                Navigator.of(context).pop();
                              }, child: const Text("Delete")),
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                              }, child: const Text("Cancel"))
                            ],
                          )
                      );
                    },
                    child: Text('Delete promo code by id',style: TextStyle(color: Colors.white, fontSize: 15),),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Trainee',
    'Intermediate',
    'Pro'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var course in searchTerms) {
      if (course.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(course);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var course in searchTerms) {
      if (course.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(course);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
