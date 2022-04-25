import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ably_flutter/ably_flutter.dart';
import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:login_to_do_list_app/src/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ClientOptions clientOptions;

  late Realtime realtime;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    clientOptions = ably.ClientOptions.fromKey(
      'PkMSVg.C1fX1Q:-M3Cq1rjMPRz91-E03VLi4z4skbf8FY5eqdaGKB69RI',
    );
    realtime = ably.Realtime(options: clientOptions);
    realtime.connection
        .on(ably.ConnectionEvent.connected)
        .listen((ably.ConnectionStateChange stateChange) async {
      switch (stateChange.current) {
        case ably.ConnectionState.connected:
          // Successful connection
          print('Connected to Ably!');
          break;
        case ably.ConnectionState.failed:
          // Failed connection
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authServive = Provider.of<AuthService>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Scan QR Code',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              letterSpacing: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authServive.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: authServive.readEmail(),
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 81, 45, 143),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.account_circle_outlined,
                            size: 30.0,
                            color: Color.fromARGB(255, 218, 217, 217),
                          ),
                          const SizedBox(width: 15.0),
                          Text(
                            "${snapshot.data}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 218, 217, 217),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Escanea el código QR que aparece en la pantalla del navegador para darle acceso a tu cuenta a ese dispositivo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromARGB(255, 189, 189, 189),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  padding: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/qr.png',
                      width: 275.0,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          var localAuth = LocalAuthentication();
          bool canCheckBiometrics = await localAuth.canCheckBiometrics;
          if (canCheckBiometrics) {
            bool didAuthenticate = await localAuth.authenticate(
              localizedReason:
                  'Por favor coloca tu huella dactilar para poder escanear el QR',
              options: const AuthenticationOptions(
                biometricOnly: true,
              ),
            );
            if (didAuthenticate) {
              String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                '#673ab7',
                'Cancelar',
                true,
                ScanMode.QR,
              );
              final channel = realtime.channels.get('quickstart');
              await channel.publish(name: 'home', data: barcodeScanRes);
            }
          }
        },
        child: const Icon(
          Icons.qr_code_scanner,
          color: Colors.deepPurple,
        ),
        elevation: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
