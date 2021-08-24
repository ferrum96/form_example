import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_example/model/user.dart';

class UserInfoPage extends StatelessWidget {
  User? userInfo;

  UserInfoPage({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(
                '${userInfo!.name}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: userInfo!.story!.isNotEmpty
                  ? Text('${userInfo!.story}')
                  : null,
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              trailing: userInfo!.country != null
                  ? Text('${userInfo!.country}')
                  : null,
            ),
            ListTile(
              title: Text(
                '${userInfo!.phone}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: Icon(
                Icons.phone,
                color: Colors.black,
              ),
            ),
            Container(
              child: userInfo!.email!.isNotEmpty
                  ? ListTile(
                      title: Text(
                        '${userInfo!.email}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: Icon(
                        Icons.mail_outline,
                        color: Colors.black,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
