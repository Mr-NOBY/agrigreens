import 'package:agrigreens/repository/auth_repository/auth_repo.dart';
import 'package:agrigreens/services/google_sheets_service.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                sendEmail("eo54872@gmail.com");
              },
              child: Text('Send Mail'),
            ),
          ),
          // Divider(),
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                downloadCSV();
              },
              child: Text('Download CSV'),
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            color: Colors.blueGrey,
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                AuthRepo.instance.logout();
              },
              child: Text('Log out'),
            ),
          ),
        ],
      ),
    );
  }
}
