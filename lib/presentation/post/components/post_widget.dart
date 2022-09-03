import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/model/posts.dart';
import '../../detail.dart';

class PostWidget extends StatelessWidget {
  final Posts posts;

  const PostWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: size.width,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFFF2F3F7),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFffffff),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(-2, -2),
          ),
          BoxShadow(
            color: Color.fromRGBO(55, 84, 170, 0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.zero,
            minimumSize: Size(size.width, 100),
            maximumSize: Size(size.width, 100),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8),
            ),
            primary: Color(0xFFF2F3F7)
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailMachingPage('${posts.underId}')));
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.network(
                  "${posts.postImg}",
                  width: 68.0,
                  height: 68.0,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image.asset(
                      'assets/images/dummy.jpg',
                      width: 68.0,
                      height: 68.0,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                height: 68.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width - 156,
                      child: Row(
                        children: [
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              strutStyle: StrutStyle(fontSize: 16),
                              text: TextSpan(
                                text: '${posts.postTitle}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: size.width - 156,
                      child: Row(
                        children: [
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              strutStyle: StrutStyle(fontSize: 16),
                              text: TextSpan(
                                text: '${posts.promiseDate.toString().substring(5,7)}/${posts.promiseDate.toString().substring(8,10)}  |  ${posts.promiseLocation.centerName}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF757575),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
