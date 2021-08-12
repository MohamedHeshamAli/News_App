import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_Screen.dart';

Widget defaultTextField({
  TextEditingController? controller,
  String? lable,
  IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  void Function()? onTab,
  Function? onChanged,
  Function? onSubmmited,
  String? Function(String?)? validator,
  TextInputType? type,
  bool readOnly = false,
  double radius = 0.0,
}) {
  return TextFormField(
    controller: controller,
    onTap: onTab,
    onChanged: (val) {
      onChanged != null ? onChanged(val) : null;
    },
    onFieldSubmitted: (val) {
      onSubmmited != null ? onSubmmited(val) : null;
    },
    validator: validator,
    keyboardType: type,
    obscureText: type == TextInputType.visiblePassword ? true : false,
    readOnly: readOnly,
    decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: () {
            suffixPressed;
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        )),
  );
}

// Widget BuildTaskIrem(
//     {String? Time, String? Title, String? date, int? id, context}) {
//   return Dismissible(
//     key: Key('$id'),
//     onDismissed: (dis) {
//       AppCubit.get(context).deleteDataBase(id: id);
//     },
//     child: Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 40,
//             child: Text(
//               "$Time",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           Expanded(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "$Title",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//                 Text(
//                   "$date",
//                   style: TextStyle(color: Colors.grey),
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.check,
//               color: Colors.blueAccent,
//             ),
//             onPressed: () {
//               AppCubit.get(context).updateDataBase(status: "done", id: id);
//             },
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.archive,
//               color: Colors.blueAccent,
//             ),
//             onPressed: () {
//               AppCubit.get(context).updateDataBase(status: "archived", id: id);
//             },
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Widget TaskBuilder({List? tasks, String? screenName}) {
//   return tasks!.length == 0
//       ? Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.menu,
//                 size: 150,
//                 color: Colors.grey,
//               ),
//               Text(
//                 "No $screenName yet",
//                 style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.grey,
//                     fontWeight: FontWeight.bold),
//               )
//             ],
//           ),
//         )
//       : ListView.separated(
//           itemBuilder: (context, indx) {
//             return BuildTaskIrem(
//                 Title: tasks[indx]["title"],
//                 date: tasks[indx]["date"],
//                 Time: tasks[indx]["time"],
//                 id: tasks[indx]["id"],
//                 context: context);
//           },
//           separatorBuilder: (ctx, ind) {
//             return MyDivider();
//           },
//           itemCount: tasks.length);
// }

Widget MyDivider() {
  return Container(
    margin: EdgeInsetsDirectional.only(start: 20, end: 20),
    color: Colors.grey,
    height: 1,
  );
}

Widget BuildArticalItim(artical, BuildContext ctx) {
  return InkWell(
    onTap: () {
      Navigator.push(
          ctx,
          MaterialPageRoute(
              builder: (context) => WebViewScreen(artical["url"])));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: artical["urlToImage"] != null
                    ? DecorationImage(
                        image: NetworkImage("${artical["urlToImage"]}"),
                        fit: BoxFit.cover)
                    : null),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${artical["title"]}",
                  style: Theme.of(ctx).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${artical["publishedAt"]}",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget ArticleBuilder(List list, BuildContext context) {
  return list.length == 0
      ? Center(
          child: CircularProgressIndicator(),
        )
      : ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              BuildArticalItim(list[index], context),
          separatorBuilder: (context, index) => MyDivider(),
          itemCount: list.length);
}
