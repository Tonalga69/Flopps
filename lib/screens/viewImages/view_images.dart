import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ViewImages extends StatelessWidget {
  const ViewImages({super.key, required this.imageUrl, required this.title});

  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(title),
        ),
        body: Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.black),
          child: Hero(
            tag: imageUrl,
            child: SizedBox(
                child: CircleAvatar(
                    radius: double.infinity,
                    child: CachedNetworkImage(imageUrl: imageUrl)),),
          ),
        ));
  }
}
