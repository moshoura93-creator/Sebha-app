mycodeimport 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const AthkarApp());
}

// ==========================================
// مكون التوقيع الموحد (أسفل الشمال)
// ==========================================
Widget buildFooterWatermark() {
  return const SafeArea(
    child: Padding(
      padding: EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        'لا تنسونا من صالح دعاؤكم  ـ م/محمد الشورة',
        style: TextStyle(
          fontSize: 11,
          color: Colors.white70,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

class AthkarApp extends StatelessWidget {
  const AthkarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أذكار المسلم',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFF111827),
      ),
      home: const SplashScreen(),
    );
  }
}

// ==========================================
// 1. شاشة البداية (Splash Screen)
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      _goToHome();
    });
  }

  void _goToHome() {
    if (mounted && !_navigated) {
      _navigated = true;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainHomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _goToHome,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: const Color(0xFF111827)),
            Image.network(
              'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?auto=format&fit=crop&w=1200&q=80',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.55),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(28.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '﷽',
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 18),
                          Text(
                            '« وَذَكِّرْ فَإِنَّ الذِّكْرَىٰ تَنفَعُ الْمُؤْمِنِينَ »',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    OutlinedButton.icon(
                      onPressed: _goToHome,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white54),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      icon: const Icon(Icons.arrow_forward_rounded, size: 20),
                      label: const Text('دخول التطبيق الآن', style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: buildFooterWatermark(),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. الشاشة الرئيسية (القائمة باختياراتها الـ 3)
// ==========================================
class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  Widget _buildMenuCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.25),
                shape: BoxShape.circle,
                border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white54, size: 18),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('حصن المسلم', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?auto=format&fit=crop&w=1200&q=80',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF111827)),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
              child: Container(color: Colors.black.withValues(alpha: 0.5)),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMenuCard(
                      context: context,
                      title: 'أذكار الصباح',
                      subtitle: 'نور لصباحك وبركة ليومك',
                      icon: Icons.wb_sunny_rounded,
                      color: const Color(0xFFF59E0B),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AthkarDisplayScreen(
                              title: 'أذكار الصباح',
                              athkarList: getMorningAthkar(),
                              bgUrl: 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?auto=format&fit=crop&w=1200&q=80',
                              themeColor: const Color(0xFFF59E0B),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    _buildMenuCard(
                      context: context,
                      title: 'أذكار المسلم (المسبحة)',
                      subtitle: 'تسبيح، تهليل، وتكبير بعداد ذكي',
                      icon: Icons.fingerprint_rounded,
                      color: const Color(0xFF10B981),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MuslimAthkarScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    _buildMenuCard(
                      context: context,
                      title: 'أذكار المساء',
                      subtitle: 'حفظ وسلام لليلتك',
                      icon: Icons.nightlight_round,
                      color: const Color(0xFF6366F1),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AthkarDisplayScreen(
                              title: 'أذكار المساء',
                              athkarList: getEveningAthkar(),
                              bgUrl: 'https://images.unsplash.com/photo-1509114397022-ed747cca3f65?auto=format&fit=crop&w=1200&q=80',
                              themeColor: const Color(0xFF6366F1),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: buildFooterWatermark(),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. نموذج الأذكار للصباح والمساء
// ==========================================
class AthkarItem {
  final String text;
  final String? countText;
  final int maxCount;
  int currentCount;
  final String? reward;

  AthkarItem({
    required this.text,
    this.countText,
    required this.maxCount,
    this.currentCount = 0,
    this.reward,
  });
}

List<AthkarItem> getMorningAthkar() {
  return [
    AthkarItem(
      text: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ...',
      countText: 'مرة واحدة',
      maxCount: 1,
      reward: 'من قالها حين يصبح أُجير من الجن حتى يمسي.',
    ),
    AthkarItem(
      text: 'قُلْ هُوَ اللَّهُ أَحَدٌ ۝ اللَّهُ الصَّمَدُ ۝ لَمْ يَلِدْ وَلَمْ يُولَدْ ۝ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ',
      countText: '3 مرات',
      maxCount: 3,
      reward: 'تكفيه من كل شيء.',
    ),
    AthkarItem(
      text: 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ (1) مِن شَرِّ مَا خَلَقَ (2) وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ (3) وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ (4) وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ (5) ',
      countText: '3 مرات',
      maxCount: 3,
      reward: 'الحفظ والوقاية من الشرور.',
    ),
    AthkarItem(
      text: 'قُلْ أَعُوذُ بِرَبِّ النَّاسِ (1) مَلِكِ النَّاسِ (2) إِلَٰهِ النَّاسِ (3) مِن شَرِّ الْوَسْواسِ الْخَنَّاسِ (4) الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ (5) مِنَ الْجِنَّةِ وَالنَّاسِ (6)',
      countText: '3 مرات',
      maxCount: 3,
      reward: 'التحصين من الوسواس والشر.',
    ),
    AthkarItem(
      text: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.',
      countText: 'مرة واحدة',
      maxCount: 1,
    ),
    AthkarItem(
      text: 'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ.',
      countText: 'مرة واحدة',
      maxCount: 1,
    ),
    AthkarItem(
      text: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ.',
      countText: 'مرة واحدة (سيد الاستغفار)',
      maxCount: 1,
      reward: 'من قالها موقناً بها ومات من يومه دخل الجنة.',
    ),
    AthkarItem(
      text: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ.',
      countText: '3 مرات',
      maxCount: 3,
      reward: 'لم يضره شيء حتى يمسي.',
    ),
    AthkarItem(
      text: 'رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِينًا، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا.',
      countText: '3 مرات',
      maxCount: 3,
      reward: 'كان حقاً على الله أن يرضيه يوم القيامة.',
    ),
    AthkarItem(
      text: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ.',
      countText: '100 مرة',
      maxCount: 100,
      reward: 'حُطّت خطاياه وإن كانت مثل زبد البحر.',
    ),
  ];
}

List<AthkarItem> getEveningAthkar() {
  return [
    AthkarItem(
      text: '{ اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ } ',
      countText: 'مرة واحدة',
      maxCount: 1,
      reward: 'من قالها حين يمسي أُجير من الجن حتى يصبح.',
    ),
    AthkarItem(
      text: 'قُلْ هُوَ اللَّهُ أَحَدٌ (1) اللَّهُ الصََّمَدُ (2) لَمْ يَلِدْ وَلَمْ يُولَدْ (3) وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ (4)ِ',
      countText: '3 مرات ',
      maxCount: 3,
      reward: 'تكفيه من كل شيء.',
    ),
    AthkarItem(
      text: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ...',
      countText: 'مرة واحدة',
      maxCount: 1,
    ),
    AthkarItem(
      text: 'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ الْمَصِيرُ.',
      countText: 'مرة واحدة',
      maxCount: 1,
    ),
    AthkarItem(
      text: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ... (سيد الاستغفار)',
      countText: 'مرة واحدة',
      maxCount: 1,
      reward: 'من قالها موقناً بها ومات في ليلته دخل الجنة.',
    ),
    AthkarItem(
      text: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ.',
      countText: '3 مرات',
      maxCount: 3,
      reward: 'لم تضره حمة (لدغة) في تلك الليلة.',
    ),
    AthkarItem(
      text: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ.',
      countText: '3 مرات',
      maxCount: 3,
      reward: 'لم تصبه فجأة بلاء حتى يصبح.',
    ),
    AthkarItem(
      text: 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ.',
      countText: '10 مرات',
      maxCount: 10,
      reward: 'أدركته شفاعة النبي ﷺ يوم القيامة.',
    ),
    AthkarItem(
      text: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ.',
      countText: '100 مرة',
      maxCount: 100,
      reward: 'مغفرة الذنوب وزيادة الرزق.',
    ),
  ];
}

// ==========================================
// 4. شاشة عرض الأذكار (الصباح / المساء)
// ==========================================
class AthkarDisplayScreen extends StatefulWidget {
  final String title;
  final List<AthkarItem> athkarList;
  final String bgUrl;
  final Color themeColor;

  const AthkarDisplayScreen({
    super.key,
    required this.title,
    required this.athkarList,
    required this.bgUrl,
    required this.themeColor,
  });

  @override
  State<AthkarDisplayScreen> createState() => _AthkarDisplayScreenState();
}

class _AthkarDisplayScreenState extends State<AthkarDisplayScreen> {
  int _currentIndex = 0;

  void _nextZikr() {
    HapticFeedback.lightImpact();
    setState(() {
      if (widget.athkarList[_currentIndex].currentCount < widget.athkarList[_currentIndex].maxCount) {
        widget.athkarList[_currentIndex].currentCount++;
      }

      if (widget.athkarList[_currentIndex].currentCount >= widget.athkarList[_currentIndex].maxCount) {
        if (_currentIndex < widget.athkarList.length - 1) {
          _currentIndex++;
        } else {
          _showCompletionDialog();
        }
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: const Color(0xFF1F2937),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(Icons.stars_rounded, color: widget.themeColor, size: 28),
              const SizedBox(width: 8),
              const Text('هنيئاً لك! 🎉', style: TextStyle(color: Colors.white)),
            ],
          ),
          content: Text(
            'لقد أتممت قراءة ${widget.title} بنجاح. تقبل الله طاعتكم!',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: widget.themeColor),
              child: const Text('العودة للرئيسية', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = widget.athkarList[_currentIndex];
    final progress = (_currentIndex + 1) / widget.athkarList.length;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: widget.themeColor.withValues(alpha: 0.9),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.bgUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF111827)),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(color: Colors.black.withValues(alpha: 0.65)),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white24,
                      color: widget.themeColor,
                      minHeight: 6,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'الذكر ${_currentIndex + 1} من ${widget.athkarList.length}',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Card(
                        color: Colors.white.withValues(alpha: 0.12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      currentItem.text,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        height: 1.8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (currentItem.reward != null) ...[
                                const Divider(color: Colors.white24),
                                const SizedBox(height: 8),
                                Text(
                                  currentItem.reward!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: widget.themeColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: _nextZikr,
                      child: Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.themeColor,
                          boxShadow: [
                            BoxShadow(
                              color: widget.themeColor.withValues(alpha: 0.5),
                              blurRadius: 18,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${currentItem.currentCount} / ${currentItem.maxCount}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'اضغط للعد',
                              style: TextStyle(fontSize: 12, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: buildFooterWatermark(),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 5. شاشة أذكار المسلم (المسبحة الإلكترونية)
// ==========================================
class TasbeehZikr {
  final String title;
  int count;
  int target;

  TasbeehZikr({required this.title, this.count = 0, this.target = 33});
}

class MuslimAthkarScreen extends StatefulWidget {
  const MuslimAthkarScreen({super.key});

  @override
  State<MuslimAthkarScreen> createState() => _MuslimAthkarScreenState();
}

class _MuslimAthkarScreenState extends State<MuslimAthkarScreen> {
  final List<TasbeehZikr> _tasbeehList = [
    TasbeehZikr(title: 'سُبْحَانَ اللَّهِ', target: 33),
    TasbeehZikr(title: 'الْحَمْدُ لِلَّهِ', target: 33),
    TasbeehZikr(title: 'اللَّهُ أَكْبَرُ', target: 33),
    TasbeehZikr(title: 'لَا إِلَهَ إِلَّا اللَّهُ', target: 100),
    TasbeehZikr(title: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ', target: 100),
    TasbeehZikr(title: 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ', target: 33),
    TasbeehZikr(title: 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ', target: 100),
  ];

  int _selectedIndex = 0;
  int _totalSessionCount = 0;

  void _increment() {
    HapticFeedback.lightImpact();
    setState(() {
      _tasbeehList[_selectedIndex].count++;
      _totalSessionCount++;
    });
  }

  void _reset() {
    setState(() {
      _tasbeehList[_selectedIndex].count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = _tasbeehList[_selectedIndex];
    final progress = (current.count / current.target).clamp(0.0, 1.0);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المسبحة الإلكترونية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF10B981),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh_rounded, color: Colors.white),
              tooltip: 'تصفير العداد',
              onPressed: _reset,
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              color: const Color(0xFF111827),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _tasbeehList.length,
                      itemBuilder: (context, index) {
                        final isSel = index == _selectedIndex;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ChoiceChip(
                            label: Text(
                              _tasbeehList[index].title,
                              style: TextStyle(
                                color: isSel ? Colors.white : Colors.white70,
                                fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            selected: isSel,
                            selectedColor: const Color(0xFF10B981),
                            backgroundColor: Colors.white.withValues(alpha: 0.1),
                            onSelected: (val) {
                              if (val) setState(() => _selectedIndex = index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    current.title,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'الهدف: ${current.target} مرة',
                    style: const TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _increment,
                    child: Container(
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF059669), Color(0xFF10B981)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF10B981).withValues(alpha: 0.4),
                            blurRadius: 25,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 220,
                            height: 220,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 8,
                              backgroundColor: Colors.white24,
                              color: Colors.amberAccent,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${current.count}',
                                style: const TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'اضغط للتسبيح',
                                style: TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('مجموع تسبيحات الجلسة:', style: TextStyle(color: Colors.white70)),
                        Text(
                          '$_totalSessionCount تسبيحة',
                          style: const TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: buildFooterWatermark(),
            ),
          ],
        ),
      ),
    );
  }
}
