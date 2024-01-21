import 'package:flutter/material.dart';
import 'package:retaste_app/bloc/cubit/cubit/check_connection_cubit.dart';
import 'package:retaste_app/widget/check_connection_alert.dart';

void showCheckConnection(
  BuildContext context,
  CheckConnectionCubit checkConnectionCubit,
) async {
  showDialog(
    context: context,
    builder: (context) => CheckConnectionAlert(
      onPressed: () async {
        Navigator.of(context).pop();

        bool isConnected = await checkConnectionCubit.checkConnection();

        if (!isConnected) {
          // ignore: use_build_context_synchronously
          showCheckConnection(context, checkConnectionCubit);
        }
      },
    ),
  );
}
