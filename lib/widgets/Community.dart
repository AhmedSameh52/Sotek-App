import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_v1/Model/languageTranslator.dart';
import 'package:solution_challenge_v1/firebase/admin.dart';
import 'package:solution_challenge_v1/firebase/userController.dart';
import 'package:solution_challenge_v1/main.dart';

import '../Model/Comment.dart';
import '../Model/post.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  getComments(Post newPost) async {
    await userC.getAllComments(newPost);
  }

  @override
  Widget build(BuildContext context) {
    Admin a1 = Admin();
    Language _language = Language();
    final TextEditingController _searchController = TextEditingController();

    getPosts() async {
      await userC.getAllPosts();
    }

    userC.allPosts.sort((a, b) => b.date.compareTo(a.date));
    DateTime currentDate = DateTime.now();
    return DraggableHome(
      stretchMaxHeight: 0.02,
      headerExpandedHeight: 0.01,
      title: Text(
        _language.tCommunity(),
        style: TextStyle(
          fontFamily: 'Figtree',
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      alwaysShowLeadingAndAction: true,
      alwaysShowTitle: true,
      headerWidget: Container(),
      body: [
        Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            constraints: const BoxConstraints(maxWidth: 400),
            child: StreamBuilder<Object>(
                stream:
                    FirebaseFirestore.instance.collection("posts").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text(
                      'No Data...',
                    );
                  } else {
                    return ListView.separated(
                      padding: EdgeInsets.only(top: 0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          tempPosts.length == null ? 1 : tempPosts.length + 1,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 1,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Container(
                            // Add padding around the search bar
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            // Use a Material design search bar
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: TextStyle(
                                  fontFamily: 'Figtree',
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 16,
                                ),
                                // Add a clear button to the search bar
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _searchController.clear();
                                        tempPosts = userC.allPosts;
                                      });
                                    }),
                                // Add a search icon or button to the search bar
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _searchController.text.trim() == null
                                          ? tempPosts = userC.allPosts
                                          : tempPosts = userC.allPosts
                                              .where((element) =>
                                                  element.title ==
                                                  _searchController.text.trim())
                                              .toList();
                                    });
                                  },
                                ),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          );
                        }
                        index -= 1;
                        Post item = tempPosts[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AvatarImage(item.profileImage),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: item.author,
                                              style: TextStyle(
                                                fontFamily: 'Figtree',
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            TextSpan(
                                              //@ Email
                                              text: " @${item.author}",
                                              style: TextStyle(
                                                fontFamily: 'Figtree',
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ]),
                                        )),
                                        Text(
                                            '${currentDate.difference(DateTime.parse(item.date)).inDays} days ago',
                                            style: TextStyle(
                                              fontFamily: 'Figtree',
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                    Text(
                                      item.title,
                                      style: TextStyle(
                                        fontFamily: 'Figtree',
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      item.body,
                                      style: TextStyle(
                                        fontFamily: 'Figtree',
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    ActionsRow(item: item)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
          ),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newPostScreen');
        },
        backgroundColor: isDarkMode
            ? const Color.fromRGBO(255, 189, 183, 1)
            : const Color.fromRGBO(246, 145, 138, 1),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    print(currentApplicationUser.toString());
    tempPosts = userC.allPosts;
    super.initState();
  }
}

class AvatarImage extends StatelessWidget {
  late String storeImage;
  AvatarImage(String imageAsset) {
    storeImage = imageAsset;
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: AssetImage(storeImage),
      radius: 30.0,
    );
  }
}

class ActionsRow extends StatefulWidget {
  final Post item;
  const ActionsRow({Key? key, required this.item}) : super(key: key);

  @override
  State<ActionsRow> createState() => _ActionsRowState();
}

class _ActionsRowState extends State<ActionsRow> {
  Future<List<Comment>> getComments(Post item) async {
    return await userC.getAllComments(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    int lengthOfFile = 0;
    return (isAdmin || widget.item.author == userC.currentUser.username)
        ? Theme(
            data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: Colors.grey, size: 22),
                textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.grey),
                ))),
            child: FutureBuilder<Object>(
                future: getComments(widget.item),
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            currentApplicationUser!.likedPosts.any(
                                    (element) => element == widget.item.postID)
                                ? userC.unLikePost(widget.item)
                                : userC.likePost(widget.item);
                          });
                        },
                        icon: currentApplicationUser!.likedPosts
                                .any((element) => element == widget.item.postID)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_outline,
                                color: Colors.grey,
                              ),
                        label: Text(widget.item.likesCount == 0
                            ? ''
                            : widget.item.likesCount.toString()),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          await userC.getAllComments(widget.item);
                          Navigator.pushNamed(
                                  context, '/commentCommunityScreen',
                                  arguments: widget.item)
                              .then((_) {
                            // This block runs when you have returned back to the 1st Page from 2nd.
                            setState(() {
                              // Call setState to refresh the page.
                            });
                          });
                        },
                        icon: const Icon(Icons.mode_comment_outlined),
                        label: Text(widget.item.comments.length == 0
                            ? ''
                            : widget.item.comments.length.toString()),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          deletePostPopUp(widget.item);
                        },
                        icon: const Icon(Icons.delete),
                        label: Text(
                          '',
                        ),
                      )
                    ],
                  );
                }),
          )
        : Theme(
            data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: Colors.grey, size: 22),
                textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.grey),
                ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      currentApplicationUser!.likedPosts
                              .any((element) => element == widget.item.postID)
                          ? userC.unLikePost(widget.item)
                          : userC.likePost(widget.item);
                    });
                  },
                  icon: currentApplicationUser!.likedPosts
                          .any((element) => element == widget.item.postID)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                  label: Text(widget.item.likesCount == 0
                      ? ''
                      : widget.item.likesCount.toString()),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/commentCommunityScreen',
                            arguments: widget.item)
                        .then((_) {
                      // This block runs when you have returned back to the 1st Page from 2nd.
                      setState(() {
                        // Call setState to refresh the page.
                      });
                    });
                  },
                  icon: const Icon(Icons.mode_comment_outlined),
                  label: Text(widget.item.comments.length.toString() == 0
                      ? ''
                      : widget.item.comments.length.toString()),
                ),
                TextButton.icon(
                  onPressed: () {
                    reportPostPopUp(widget.item);
                  },
                  icon: const Icon(Icons.report_problem),
                  label: Text(
                    '',
                  ),
                )
              ],
            ),
          );
  }

  Future<bool> deletePostPopUp(Post item) async {
    Admin a1 = Admin();
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromRGBO(224, 231, 255, 20),
            title: const Text('Are you sure?'),
            content: const Text('Do you want to delete the post?'),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode
                        ? const Color.fromRGBO(255, 189, 183, 1)
                        : const Color.fromRGBO(246, 145, 138, 1),
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
                      backgroundColor: isDarkMode
                          ? const Color.fromRGBO(255, 189, 183, 1)
                          : const Color.fromRGBO(246, 145, 138, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                  onPressed: () {
                    setState(() {
                      a1.deletePost(item);
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, "/communityScreen");
                    });
                  },
                  child: const Text('Yes')),
            ],
          ),
        )) ??
        false;
  }

  Future<bool> reportPostPopUp(Post postItem) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromRGBO(224, 231, 255, 20),
            title: const Text('Are you sure?'),
            content: const Text('Do you want to report the post?'),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode
                        ? const Color.fromRGBO(255, 189, 183, 1)
                        : const Color.fromRGBO(246, 145, 138, 1),
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
                      backgroundColor: isDarkMode
                          ? const Color.fromRGBO(255, 189, 183, 1)
                          : const Color.fromRGBO(246, 145, 138, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'You Just Reported The Post!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                  child: const Text('Yes')),
            ],
          ),
        )) ??
        false;
  }
}
