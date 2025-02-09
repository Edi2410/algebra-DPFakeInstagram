import 'package:dp_project/core/style/style_extensions.dart';
import 'package:dp_project/feature/logging/presentation/widget/error_logs_data.dart';
import 'package:dp_project/feature/logging/presentation/widget/info_logs_data.dart';
import 'package:flutter/material.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Logs Screen',
          style: context.textAppBar
              .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: const <Widget>[
            Tab(text: 'Info Logs'),
            Tab(text: 'Error Logs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const <Widget>[
          InfoLogsData(),
          ErrorLogsData(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
