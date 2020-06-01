import 'package:diariosaude/pages/child_detail_page.dart';
import 'package:flutter/material.dart';

class ChildColum extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final String name;
  final String age;
  final String image;

  ChildColum({
    this.icon,
    this.iconBackgroundColor,
    this.name,
    this.age,
    this.image = 'https://cdn.mindful.org/YesBrain.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ChildDetailPage(
                  name: name,
                  age: age,
                  image: image,
                )));
      },
      title: Text(name),
      subtitle: Text(age),
      leading: Hero(
          tag: name,
          child: CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(image),
          )),
      trailing: Icon(
        Icons.arrow_right,
      ),
    );

    // return FlatButton(
    //     onPressed: () {},
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: <Widget>[
    //         CircleAvatar(
    //           radius: 20.0,
    //           backgroundImage: NetworkImage(),
    //         ),
    //         SizedBox(width: 10.0),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text(
    //               name,
    //               style: TextStyle(
    //                 fontSize: 16.0,
    //                 fontWeight: FontWeight.w700,
    //               ),
    //             ),
    //             Text(
    //               age,
    //               style: TextStyle(
    //                   fontSize: 14.0,
    //                   fontWeight: FontWeight.w500,
    //                   color: Colors.black45),
    //             ),
    //           ],
    //         )
    //       ],
    //     ));
  }
}
