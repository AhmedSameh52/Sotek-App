import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:solution_challenge_v1/Model/article.dart';
import 'package:solution_challenge_v1/main.dart';
import 'package:solution_challenge_v1/widgets/Community.dart';
import 'package:solution_challenge_v1/widgets/routeGenerator.dart';
import 'package:intl/intl.dart';

import '../Model/languageTranslator.dart';
import '../firebase/admin.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsFeedPage2 extends StatefulWidget {
  @override
  State<NewsFeedPage2> createState() => _NewsFeedPage2State();
}

class _NewsFeedPage2State extends State<NewsFeedPage2> {
  final editArticleTitleController = TextEditingController();
  final editImageUrlController = TextEditingController();

  final articleTitleController = TextEditingController();
  final imageUrlController = TextEditingController();
  final authorController = TextEditingController();
  final readTimeController = TextEditingController();
  final urlController = TextEditingController();
  Language _language = Language();
  //late int tempReadTime;
  late String url;
  @override
  void dispose() {
    editArticleTitleController.dispose();
    editImageUrlController.dispose();
    articleTitleController.dispose();
    authorController.dispose();
    readTimeController.dispose();
    urlController.dispose();
    super.dispose();
  }

  var textAuthor = TextStyle(
      fontFamily: 'Figtree',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.white : Colors.black);

  var textArticle = TextStyle(
      fontFamily: 'Figtree',
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.white : Colors.black);

  @override
  Widget build(BuildContext context) {
    Admin a1 = Admin();
    return DraggableHome(
        stretchMaxHeight: 0.02,
        headerExpandedHeight: 0.01,
        alwaysShowLeadingAndAction: true,
        alwaysShowTitle: true,
        title: Text(
          _language.tArticles(),
          style: TextStyle(
            fontFamily: 'Figtree',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        headerWidget: Container(),
        floatingActionButton: isAdmin
            ? FloatingActionButton(
                backgroundColor: const Color.fromRGBO(246, 145, 138, 1),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  injectArticle(context);
                })
            : null,

        // fetching articles from firebase
        body: [
          FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection("articles").get(),
              builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }

                List<Article> A1 = [];
                if (snapshot.data != null) {
                  snapshot.data!.docs.forEach((doc) {
                    if (doc.exists) {
                      Map<String, dynamic>? data =
                          doc.data() as Map<String, dynamic>?;
                      if (data != null) {
                        Article article = Article(
                            id: doc.id,
                            title: data['title'],
                            author: data['author'],
                            imageUrl: data['image url'],
                            link: data['link'],
                            postedOn: data['posted on'],
                            readTime: data['read time']);
                        A1.add(article);
                      }
                    }
                  });
                }

                return Column(children: [
                  ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: A1 == null ? 1 : A1.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return InkWell(
                          onTap: () async {
                            print("id");
                            print(A1[0].id);
                            url = A1[0].imageUrl;
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: isAdmin == true
                              ? Column(children: [
                                  Container(
                                      margin: const EdgeInsets.all(10),
                                      width: 400,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(A1[0].imageUrl),
                                          ))),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          A1[0].title,
                                          textAlign: TextAlign.left,
                                          style: isDarkMode
                                              ? textStyleDarkMode
                                              : textStyleNormalMode,
                                        )),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, top: 8),
                                        child: Text(
                                          A1[0].author,
                                          textAlign: TextAlign.left,
                                          style: textAuthor,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 8),
                                        child: CircleAvatar(
                                            backgroundColor: isDarkMode
                                                ? Colors.white
                                                : Colors.grey,
                                            radius: 2),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 8),
                                        child: Text(
                                          '${A1[0].readTime} min read',
                                          textAlign: TextAlign.left,
                                          style: textAuthor,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            editArticle(context, A1[0]);
                                          },
                                          icon: Icon(
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              Icons.edit)),
                                      IconButton(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          onPressed: () {
                                            deletePopUp(A1[0]);
                                          },
                                          icon: Icon(
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              Icons.delete)),
                                    ],
                                  ),
                                  const Divider(
                                    color: Color.fromRGBO(246, 145, 138, 1),
                                    indent: 10,
                                    endIndent: 10,
                                    thickness: 3,
                                  )
                                ])
                              : Column(children: [
                                  Container(
                                      margin: const EdgeInsets.all(10),
                                      width: 400,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(A1[0].imageUrl),
                                          ))),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(A1[0].title,
                                            textAlign: TextAlign.left)),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, top: 8),
                                        child: Text(A1[0].author,
                                            textAlign: TextAlign.left),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, top: 8),
                                        child: CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            radius: 2),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 8),
                                        child: Text(
                                            '${A1[0].readTime} min read',
                                            textAlign: TextAlign.left),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Color.fromRGBO(246, 167, 160, 1),
                                    indent: 10,
                                    endIndent: 10,
                                    thickness: 3,
                                  )
                                ]),
                        );
                      }
                      index -= 1;
                      final item = A1[index + 1];
                      String date = item.postedOn.substring(0, 10);

                      return Container(
                        //height: 136,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                            borderRadius: BorderRadius.circular(8.0)),
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () async {
                            url = item.link;
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: isAdmin == true
                              ? Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(children: [
                                        IconButton(
                                            iconSize: 20,
                                            onPressed: () {
                                              editArticle(context, item);
                                            },
                                            icon: Icon(
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                                Icons.edit)),
                                        const SizedBox(
                                          width: 0.5,
                                        ),
                                        IconButton(
                                            iconSize: 20,
                                            onPressed: () {
                                              deletePopUp(item);
                                            },
                                            icon: Icon(
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                                Icons.delete)),
                                      ]),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.title,
                                              style: textAuthor,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),
                                            Text("${item.author} · ${date}",
                                                style: textArticle),
                                            const SizedBox(height: 8),
                                          ],
                                        )),
                                        Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      item.imageUrl),
                                                ))),
                                      ],
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                            //substring(0, 9)
                                            "${item.author} · ${date}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption),
                                        const SizedBox(height: 8),
                                      ],
                                    )),
                                    Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  NetworkImage(item.imageUrl),
                                            ))),
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                ]);
              }))
        ]);
  }

// Edit Article Function
  Future<void> editArticle(BuildContext context, Article article) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Admin a1 = Admin();

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Column(
              children: [
                Text(
                  "Edit Article",
                  style: textAppBar,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  controller: editArticleTitleController,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(248, 225, 210, 1),
                    filled: true,
                    labelText: 'Enter new title',
                    hintText: 'Please Enter new title',
                    prefixIcon: const ImageIcon(AssetImage(
                        'assets/images/signUp_screen_images/name.png')),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  controller: editImageUrlController,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(248, 225, 210, 1),
                    filled: true,
                    labelText: 'Enter new Image Url',
                    hintText: 'Please Enter Url',
                    prefixIcon: const ImageIcon(AssetImage(
                        'assets/images/signUp_screen_images/name.png')),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),

                //SizedBox(height: height * 0.03,),
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromRGBO(246, 145, 138, 1),
            actions: <Widget>[
              Center(
                child: SizedBox(
                  // Sign in button, Used sizedbox to adjust the button's size
                  width: 110,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        a1.editArticle(article, editArticleTitleController.text,
                            editImageUrlController.text);
                        Navigator.pop(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(246, 145, 138, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

// Add Article Function
  Future<void> injectArticle(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Admin a1 = Admin();
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Column(
              children: [
                Text("Add Article", style: textAppBar),
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  controller: articleTitleController,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(248, 225, 210, 1),
                    filled: true,
                    labelText: 'Enter title',
                    hintText: 'Please Enter title',
                    prefixIcon: const Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  controller: authorController,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(248, 225, 210, 1),
                    filled: true,
                    labelText: 'Enter Author Name ',
                    hintText: 'Please Enter Author Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  controller: urlController,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(248, 225, 210, 1),
                    filled: true,
                    labelText: 'Enter Article URL',
                    hintText: 'Please Enter Article URL',
                    prefixIcon: const Icon(Icons.link),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  controller: imageUrlController,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(248, 225, 210, 1),
                    filled: true,
                    labelText: 'Enter Image URL',
                    hintText: 'Please Enter Image URL',
                    prefixIcon: const Icon(Icons.link),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: readTimeController,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(248, 225, 210, 1),
                    filled: true,
                    labelText: 'Enter Article Read Time',
                    hintText: 'Please Enter Article Read Time',
                    prefixIcon: const Icon(Icons.numbers),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),

                //SizedBox(height: height * 0.03,),
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromRGBO(246, 145, 138, 1),
            actions: <Widget>[
              Center(
                child: SizedBox(
                  // Sign in button, Used sizedbox to adjust the button's size
                  width: 110,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        a1.addArticle(
                            articleTitleController.text,
                            imageUrlController.text,
                            authorController.text,
                            DateTime.now().toString(),
                            urlController.text,
                            int.parse(readTimeController.text
                                .trim())); // hardcoded 0 for now
                        Navigator.pop(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        )),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(246, 145, 138, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<bool> deletePopUp(Article item) async {
    Admin a1 = Admin();
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromRGBO(224, 231, 255, 20),
            title: const Text('Are you sure?'),
            content: const Text('Do you want to delete the article?'),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(253, 135, 221, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                onPressed: () {
                  Navigator.pop(context);
                }, //SIGN OUT
                child: const Text('No'),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(253, 135, 221, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                  onPressed: () {
                    setState(() {
                      a1.deleteArticle(item);
                      Navigator.pop(context);
                      FirebaseFirestore.instance.collection("articles").get();
                    });
                  },
                  child: const Text('Yes')),
            ],
          ),
        )) ??
        false;
  }
}
