import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = 'home';

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
          )
        ],
      ),
      body: Container(
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
                    children: const [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 30.0,
                        color: Color.fromARGB(255, 218, 217, 217),
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        'cesarjaviersanchhdz@gmail.com',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 218, 217, 217),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
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
              height: MediaQuery.of(context).size.height * 0.58,
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          /* String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#673AB7 ',
            'Cancelar',
            true,
            ScanMode.QR,
          ); */
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
