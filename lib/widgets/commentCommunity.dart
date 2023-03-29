import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:solution_challenge_v1/Model/Comment.dart';
import 'package:solution_challenge_v1/Model/languageTranslator.dart';
import 'package:solution_challenge_v1/main.dart';

import '../firebase/admin.dart';
import '../Model/post.dart';
import 'Community.dart';

class commentCommunityScreen extends StatefulWidget {
  final Post post;
  const commentCommunityScreen({super.key, required this.post});

  @override
  State<commentCommunityScreen> createState() => _commentCommunityScreenState();
}

class _commentCommunityScreenState extends State<commentCommunityScreen> {
  final commentController = TextEditingController();

  DateTime currentDate = DateTime.now();
  Language _language = Language();
  getComments(Post newPost) async {
    await userC.getAllComments(newPost);
  }

  @override
  void initState() {
    getComments(widget.post);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      stretchMaxHeight: 0.02,
      headerExpandedHeight: 0.01,
      title: Text(
        _language.tComment(),
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
          child: StreamBuilder<Object>(
              stream: FirebaseFirestore.instance
                  .collection("posts")
                  .doc(widget.post.postID)
                  .collection("comments")
                  .snapshots(),
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
                    itemCount: widget.post.comments.length == null
                        ? 1
                        : widget.post.comments.length + 1,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        thickness: 1,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AvatarImage(widget.post.profileImage),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  text: widget.post.author,
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
                                                  text:
                                                      " @${widget.post.author}",
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
                                                '${currentDate.difference(DateTime.parse(widget.post.date)).inDays} days ago',
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
                                          widget.post.title,
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
                                          widget.post.body,
                                          style: TextStyle(
                                            fontFamily: 'Figtree',
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        PostActionsRow(itemPost: widget.post),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      index -= 1;
                      widget.post.comments
                          .sort((a, b) => b.date.compareTo(a.date));
                      final item = widget.post.comments[index];

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
                                    item.body,
                                    style: TextStyle(
                                      fontFamily: 'Figtree',
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  CommentActionsRow(
                                      item: item, itemPost: widget.post),
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
        )
      ],
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode
            ? const Color.fromRGBO(255, 189, 183, 1)
            : const Color.fromRGBO(246, 145, 138, 1),
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                alignment: Alignment.bottomCenter,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),

                backgroundColor: Color.fromRGBO(224, 231, 255, 20),
                //title: const Text('Add Contact'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: commentController,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        labelText: 'Add Comment',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: const Text('Cancel',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? const Color.fromRGBO(255, 189, 183, 1)
                          : const Color.fromRGBO(246, 145, 138, 1),
                    ),
                    child: const Text('Add',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    onPressed: () async {
                      final commentField = commentController.text.trim();
                      if (commentField.isNotEmpty) {
                        await userC.createComment(
                            widget.post,
                            Comment(
                                author: currentApplicationUser!.username,
                                date: DateTime.now().toString(),
                                body: commentField,
                                numLikes: 0,
                                profileImage:
                                    currentApplicationUser!.getProfilePicture));

                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, '/commentCommunityScreen',
                            arguments: widget.post);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a comment.'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
    ;
  }
}

class PostActionsRow extends StatefulWidget {
  final Post itemPost;
  const PostActionsRow({Key? key, required this.itemPost}) : super(key: key);

  @override
  State<PostActionsRow> createState() => _PostActionsRowState();
}

class _PostActionsRowState extends State<PostActionsRow> {
  @override
  Widget build(BuildContext context) {
    return isAdmin
        ? Theme(
            data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: Colors.grey, size: 22),
                textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.grey),
                ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      currentApplicationUser!.likedPosts.any(
                              (element) => element == widget.itemPost.postID)
                          ? userC.unLikePost(widget.itemPost)
                          : userC.likePost(widget.itemPost);
                    });
                  },
                  icon: currentApplicationUser!.likedPosts
                          .any((element) => element == widget.itemPost.postID)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                  label: Text(widget.itemPost.likesCount == 0
                      ? ''
                      : widget.itemPost.likesCount.toString()),
                ),
                TextButton.icon(
                  onPressed: () {
                    deletePostPopUp(widget.itemPost);
                  },
                  icon: const Icon(Icons.delete),
                  label: Text(
                    '',
                  ),
                ),
              ],
            ),
          )
        : Theme(
            data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: Colors.grey, size: 22),
                textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.grey),
                ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      currentApplicationUser!.likedPosts.any(
                              (element) => element == widget.itemPost.postID)
                          ? userC.unLikePost(widget.itemPost)
                          : userC.likePost(widget.itemPost);
                    });
                  },
                  icon: currentApplicationUser!.likedPosts
                          .any((element) => element == widget.itemPost.postID)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                  label: Text(widget.itemPost.likesCount == 0
                      ? ''
                      : widget.itemPost.likesCount.toString()),
                ),
                TextButton.icon(
                  onPressed: () {
                    reportPostPopUp(widget.itemPost);
                  },
                  icon: const Icon(Icons.report_problem),
                  label: Text(
                    '',
                  ),
                ),
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

class CommentActionsRow extends StatefulWidget {
  final Comment item;
  final Post itemPost;
  const CommentActionsRow(
      {Key? key, required this.item, required this.itemPost})
      : super(key: key);

  @override
  State<CommentActionsRow> createState() => _CommentActionsRowState();
}

class _CommentActionsRowState extends State<CommentActionsRow> {
  @override
  Widget build(BuildContext context) {
    return (isAdmin || widget.item.author == userC.currentUser.username)
        ? Theme(
            data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: Colors.grey, size: 22),
                textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.grey),
                ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      currentApplicationUser!.likedComments
                              .contains(widget.item.commentID)
                          ? userC.unLikeComment(widget.item, widget.itemPost)
                          : userC.likeComment(widget.item, widget.itemPost);
                    });
                  },
                  icon: currentApplicationUser!.likedComments
                          .any((element) => element == widget.item.commentID)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                  label: Text(widget.item.numLikes == 0
                      ? ''
                      : widget.item.numLikes.toString()),
                ),
                TextButton.icon(
                  onPressed: () {
                    deleteCommentPopUp(widget.itemPost, widget.item);
                  },
                  icon: const Icon(Icons.delete),
                  label: Text(
                    '',
                  ),
                )
              ],
            ),
          )
        : Theme(
            data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: Colors.grey, size: 22),
                textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.grey),
                ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      currentApplicationUser!.likedComments.any(
                              (element) => element == widget.item.commentID)
                          ? userC.unLikeComment(widget.item, widget.itemPost)
                          : userC.likeComment(widget.item, widget.itemPost);
                    });
                  },
                  icon: currentApplicationUser!.likedComments
                          .any((element) => element == widget.item.commentID)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                  label: Text(widget.item.numLikes == 0
                      ? ''
                      : widget.item.numLikes.toString()),
                ),
                TextButton.icon(
                  onPressed: () {
                    reportCommentPopUp(widget.itemPost, widget.item);
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

  Future<bool> deleteCommentPopUp(Post postItem, Comment commentItem) async {
    Admin a1 = Admin();
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromRGBO(224, 231, 255, 20),
            title: const Text('Are you sure?'),
            content: const Text('Do you want to delete the comment?'),
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
                      a1.deleteComment(postItem, commentItem);
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, "/commentCommunityScreen",
                          arguments: postItem);
                    });
                  },
                  child: const Text('Yes')),
            ],
          ),
        )) ??
        false;
  }

  Future<bool> reportCommentPopUp(Post postItem, Comment commentItem) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromRGBO(224, 231, 255, 20),
            title: const Text('Are you sure?'),
            content: const Text('Do you want to report the comment?'),
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
                          'You Just Reported The Comment!',
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
