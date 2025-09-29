import 'package:flutter/material.dart';
import 'package:flutter_kisilikanketi/resultpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kişilik Anketi',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4E9D7), // Açık arka plan
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD97D55), // vurgu rengi
          primary: const Color(0xFFD97D55),
          secondary: const Color(0xFF6FA4AF),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFB8C4A9).withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          labelStyle: const TextStyle(color: Color(0xFF6FA4AF)),
        ),
      ),
      home: const MyHomePage(title: 'Kişilik Anketi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();

  String? _selectedGender;
  bool _isAdult = false;
  bool _smoke = false;
  double _cigarettesPerDay = 0;

  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD97D55),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ad Soyad
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Adınız ve Soyadınız",
              ),
            ),
            const SizedBox(height: 30),

            // Cinsiyet Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Cinsiyetinizi Seçiniz",
              ),
              value: _selectedGender,
              items: ["Erkek", "Kadın", "Diğer"].map((gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 40),

            // Reşit misiniz?
            CheckboxListTile(
              title: const Text("Reşit misiniz?"),
              activeColor: const Color(0xFFD97D55),
              checkColor: Colors.white,
              value: _isAdult,
              onChanged: (val) {
                setState(() {
                  _isAdult = val ?? false;
                });
              },
            ),

            // Sigara
            SwitchListTile(
              title: const Text("Sigara kullanıyor musunuz?"),
              activeColor: const Color(0xFFD97D55),
              value: _smoke,
              onChanged: (val) {
                setState(() {
                  _smoke = val;
                  if (!_smoke) _cigarettesPerDay = 0;
                });
              },
            ),

            // Sigara kullanıyorsa Slider
            if (_smoke) ...[
              const SizedBox(height: 10),
              const Text("Günde kaç tane sigara içiyorsunuz?"),
              Slider(
                value: _cigarettesPerDay,
                min: 0,
                max: 40,
                divisions: 40,
                activeColor: const Color(0xFF6FA4AF),
                inactiveColor: const Color(0xFFB8C4A9),
                label: _cigarettesPerDay.round().toString(),
                onChanged: (val) {
                  setState(() {
                    _cigarettesPerDay = val;
                  });
                },
              ),
            ],

            const SizedBox(height: 20),

            // Gönder Butonu
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD97D55),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(
                        name: _nameController.text,
                        gender: _selectedGender ?? "Seçilmedi",
                        isAdult: _isAdult,
                        smokes: _smoke,
                        cigarettesPerDay: _cigarettesPerDay,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Bilgilerimi Gönder",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Bilgiler Container
            if (_submitted)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF6FA4AF).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ad Soyad: ${_nameController.text}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Cinsiyet: ${_selectedGender ?? 'Seçilmedi'}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Reşit mi: ${_isAdult ? 'Evet' : 'Hayır'}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Sigara: ${_smoke ? 'Evet' : 'Hayır'}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    if (_smoke)
                      Text(
                        "Günde içilen sigara: ${_cigarettesPerDay.round()}",
                        style: const TextStyle(color: Colors.white),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
