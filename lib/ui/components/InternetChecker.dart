import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InternetChecker extends StatefulWidget{
  final Widget child;
  final String? what;

  const InternetChecker({super.key,required this.child, required this.what});

  @override
  State<InternetChecker> createState() => _InternetCheckerState();


}

class _InternetCheckerState extends State<InternetChecker> {
  bool _isConnected = true;
  late final Connectivity _connectivity;
  late final Stream<ConnectivityResult> _connectivityStream;

  @override
  void initState() {
    _connectivity=Connectivity();
    _connectivityStream=_connectivity.onConnectivityChanged;

    _checkInitialConnection();
    _connectivityStream.listen(_updateConnectionStatus);
    super.initState();
  }
  Future<void> _checkInitialConnection() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    final hasConnection = result != ConnectivityResult.none;
    if (hasConnection != _isConnected) {
      setState(() {
        _isConnected = hasConnection;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (!_isConnected)
          Positioned.fill(

            child:

            Container(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child:
                Card(
                  child: Padding(padding: EdgeInsets.all(16),child:
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Lottie.asset(
                          'assets/nonet.json',
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "No Internet Connection",
                          style: TextStyle(color: Colors.redAccent, fontSize: 24),
                        ),
                        Text(
                          "Connect to internet to use online ${widget.what}",
                          style: TextStyle(color: Colors.redAccent, fontSize: 12),
                        ),


                      ]),

                  ),


                ),
              ),
            ),


          ),
      ],
    );
  }
}
