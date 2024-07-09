import 'dart:io';

import 'package:dio/dio.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class GoogleSheetsService {
  final _spreadsheetId = 'YOUR_SPREADSHEET_ID';
  final _credentials = r'''
  {
    // Your credentials JSON
  }
  ''';

  Future<sheets.SheetsApi> _getSheetsApi() async {
    var credentials = ServiceAccountCredentials.fromJson(_credentials);
    var scopes = [sheets.SheetsApi.spreadsheetsScope];
    var client = await clientViaServiceAccount(credentials, scopes);
    return sheets.SheetsApi(client);
  }

  Future<List<List<String>>> fetchData() async {
    final sheetsApi = await _getSheetsApi();
    final response = await sheetsApi.spreadsheets.values.get(
      _spreadsheetId,
      'Sheet1!A1:B', // Adjust the range as needed
    );

    return response.values!
        .map((row) => row.map((cell) => cell.toString()).toList())
        .toList();
  }

  Future<List<List<String>>> fetchLast360Rows() async {
    final allData = await fetchData();
    final start = allData.length > 360 ? allData.length - 360 : 0;
    return allData.sublist(start);
  }
}

final String csvUrl =
    'https://script.google.com/macros/s/AKfycbxm3zAno-0plUnu6FSz2YEz54l9XCBAez99_igpvR-1iSPHI524qNFbu2Xw2TTDiMjo/exec'; // Replace with your web app URL

// void downloadCSV() async {
//   try {
//     final uri = Uri.parse(csvUrl);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Could not launch $csvUrl';
//     }
//   } catch (e) {
//     print('Error launching URL: $e');
//   }
// }

Future<void> downloadCSV() async {
  final String url =
      'https://script.google.com/macros/s/AKfycbxm3zAno-0plUnu6FSz2YEz54l9XCBAez99_igpvR-1iSPHI524qNFbu2Xw2TTDiMjo/exec'; // Replace with your web app URL
  final Dio dio = Dio();

  // Request permissions
  final status = await Permission.manageExternalStorage.request();

  if (status.isGranted) {
    try {
      // Get the directory to store the file
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String appDocPath = appDocDir.path;
      final String filePath = '$appDocPath/data.csv';

      // Download the file
      print('Starting file download...');
      final Response response = await dio.download(url, filePath);
      print('File download response: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('File downloaded successfully: $filePath');
        final result = await OpenFile.open(filePath);
        print('Open file result: ${result.message}');
      } else {
        print('Failed to download file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
  } else {
    print('Permission denied');
  }
}

final String webAppUrl =
    'https://script.google.com/macros/s/AKfycbzXGIhryXqJY9lOlm9hQKttwCTnwV1AdLDroyc3I8wyyYwTsxLZr5IXDXnkrCXcjq0D/exec'; // Replace with your web app URL

void sendEmail(String email) async {
  final response = await http.post(
    Uri.parse(webAppUrl),
    body: {'email': email},
  );

  if (response.statusCode == 200) {
    print('Email sent successfully');
  } else {
    print('Failed to send email');
  }
}
