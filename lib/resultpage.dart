import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String name;
  final String gender;
  final bool isAdult;
  final bool smokes;
  final double cigarettesPerDay;

  const ResultPage({
    super.key,
    required this.name,
    required this.gender,
    required this.isAdult,
    required this.smokes,
    required this.cigarettesPerDay,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4E9D7), // açık arka plan
      appBar: AppBar(
        backgroundColor: const Color(0xFFD97D55), // kontrastlı vurgu
        title: const Text(
          "Sonuçlar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildResultRow(Icons.person, "Ad Soyad", name),
                const SizedBox(height: 12),
                _buildResultRow(Icons.wc, "Cinsiyet", gender),
                const SizedBox(height: 12),
                _buildResultRow(
                  Icons.cake,
                  "Reşit mi?",
                  isAdult ? "Evet" : "Hayır",
                ),
                const SizedBox(height: 12),
                _buildResultRow(
                  Icons.smoking_rooms,
                  "Sigara Kullanıyor mu?",
                  smokes ? "Evet" : "Hayır",
                ),
                if (smokes) ...[
                  const SizedBox(height: 12),
                  _buildResultRow(
                    Icons.local_fire_department,
                    "Günde içilen sigara",
                    "${cigarettesPerDay.round()} adet",
                  ),
                ],
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD97D55), // buton
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Geri Dön",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFB8C4A9), // ikon arka planı
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: const Color(0xFF6FA4AF)), // ana vurgu rengi
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            "$label: $value",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFFD97D55), // kontrastlı yazı
            ),
          ),
        ),
      ],
    );
  }
}
