import 'dart:convert';
import 'dart:io';

import 'package:client_information/client_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_device_identifier/mobile_device_identifier.dart';

class MyApps extends StatefulWidget {
  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  Future<String> getIPAddress() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4) {
          return addr.address;
        }
      }
    }
    return 'No IP address found';
  }

  Future<String> getPublicIPAddress() async {
    final response =
        await http.get(Uri.parse('https://api64.ipify.org?format=json'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final ipAddress = jsonData['ip'];
      return ipAddress;
    } else {
      throw Exception('Failed to get public IP address');
    }
  }

  Future<void> _getDeviceId() async {
    try {
      final _mobileDeviceIdentifier =
          await MobileDeviceIdentifier().getDeviceId();
      setState(() {
        deviceId = "${_mobileDeviceIdentifier}";
      });
    } catch (e) {
      setState(() {
        deviceId = "Failed to get Device ID";
      });
    }
  }

  String ipAddress = '';
  String deviceId = '';
  @override
  Widget build(BuildContext context) {
    print('-----DA--${DateTime.now()}');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Text('IP Address :-  ${ipAddress}'),
              SizedBox(
                height: 16,
              ),
              Text('Device Id :-  ${deviceId}'),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (GetPlatform.isIOS || GetPlatform.isAndroid) {
              ipAddress = await getIPAddress();
            } else {
              ipAddress = await getPublicIPAddress();
            }
            _getDeviceId();
            Map<String, dynamic> sessionData = {
              "ip_address'": "192.168.29.76",
              "device_id": "09C37F1D-84FE-4296-959C-4D0107BD67A3",
              "registered_user_id": "123",
              "conversations": {
                "current_conversation_id": {
                  "last_activity_datetime": "2023-09-06 11:43:35.597"
                },
                "prior_conversations": [
                  {
                    "conversation_id": "123456",
                    "datetime": "2023-09-06 11:43:35.597"
                  },
                  {
                    "conversation_id": "789456",
                    "datetime": "2023-09-06 11:43:35.597"
                  }
                ]
              },
              "interview_id": "56",
              "site_page_visits": {
                "page_url": "http://pub.dev",
                "datetime": "2023-09-06 11:43:35.597"
              }
            };
            setState(() {});
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ClientInformation? basicInfo, decoratedInfo;

  @override
  void initState() {
    super.initState();
    _fetchInfo();
  }

  void _fetchInfo() async {
    basicInfo = await ClientInformation.fetch();

    decoratedInfo = await ClientInformation.fetch(
      decorators: ClientInformationDecorators(
        deviceId: (oriInfo, value) =>
            'prefix-$value-${oriInfo.applicationName}',
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text('Client Information Example'),
      ),
      body: LayoutBuilder(builder: (context, _) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: basicInfo == null || decoratedInfo == null
                    ? _buildLoading()
                    : _buildInfoView(),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildInfoView() {
    print('-----------${basicInfo?.deviceId}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dataItemWidget('deviceId', basicInfo?.deviceId ?? 'unknown_device_id'),
        _dataItemWidget('decorated deviceId',
            decoratedInfo?.deviceId ?? 'unknown_decorated_device_id'),
      ],
    );
  }

  Widget _dataItemWidget(String key, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Wrap(
        children: [
          Text('$key: ',
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value ?? 'null',
              style: const TextStyle(fontSize: 18, color: Colors.blueAccent)),
        ],
      ),
    );
  }
}
