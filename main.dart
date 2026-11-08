import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ArmoCareApp());
}

const Color navy = Color(0xFF0875A9);
const Color blue = Color(0xFF1688B8);
const Color mint = Color(0xFF39CBB1);
const Color dark = Color(0xFF16324F);
const Color bg = Color(0xFFF4F8FB);

const String phone1 = '01626495367';
const String phone2 = '01626495366';
const String email = 'armocarelink@gmail.com';
const String address =
    'House-605, Road-09, Adabor, Baitul Aman Housing Society, Shyamoli, Dhaka';

class ArmoCareApp extends StatelessWidget {
  const ArmoCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ARMO Care Link',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: dark,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const MainDashboard(),
    );
  }
}

// ---------------- MAIN DASHBOARD ----------------

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    ServicesPage(),
    BookingPage(),
    ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        backgroundColor: Colors.white,
        indicatorColor: mint.withOpacity(.18),
        onDestinationSelected: (i) => setState(() => selectedIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: navy),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.medical_services_outlined),
            label: 'Services',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Booking',
          ),
          NavigationDestination(
            icon: Icon(Icons.support_agent_outlined),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}

// ---------------- BRAND HEADER (LOGO) ----------------

Widget brandHeader({bool compact = false}) {
  return Row(
    children: [
      Image.asset(
        'assets/logo.png',
        height: compact ? 58 : 80,
        fit: BoxFit.contain,
      ),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ARMO Care Link',
            style: TextStyle(
              fontSize: compact ? 18 : 22,
              fontWeight: FontWeight.w900,
              color: navy,
            ),
          ),
          const Text(
            'Comfort, Care, Commitment',
            style: TextStyle(fontSize: 11, color: dark),
          ),
        ],
      ),
    ],
  );
}

// ---------------- COMMON WIDGETS ----------------

Widget sectionTitle(String title, {String? subtitle}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: dark,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ]
      ],
    ),
  );
}

Widget primaryButton(
  String text,
  VoidCallback onPressed, {
  IconData icon = Icons.arrow_forward,
}) {
  return SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 19),
      label: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      ),
    ),
  );
}

Widget serviceCard(
  BuildContext context,
  String title,
  String description,
  IconData icon,
) {
  return InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ServiceDetailsPage(
            title: title,
            description: description,
            icon: icon,
          ),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6EEF3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: mint.withOpacity(.14),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: navy, size: 25),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: dark,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
          const Spacer(),
          const Row(
            children: [
              Text(
                'View Details',
                style: TextStyle(
                  color: navy,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, color: navy, size: 14),
            ],
          ),
        ],
      ),
    ),
  );
}

// ---------------- HOME PAGE ----------------

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openBooking(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const BookingPage(standalone: true)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            brandHeader(compact: true),
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0875A9), Color(0xFF20BBAA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Professional Home Nursing Care',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'আপনার পরিবারের প্রিয়জনের যত্নে '
                    'দক্ষ ও প্রশিক্ষণপ্রাপ্ত নার্স এখন আপনার বাসায়।',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 19),
                  ElevatedButton.icon(
                    onPressed: () => openBooking(context),
                    icon: const Icon(Icons.calendar_month),
                    label: const Text('Book a Nurse'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: navy,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            sectionTitle(
              'Our Services',
              subtitle: 'আপনার প্রয়োজন অনুযায়ী হোম কেয়ার সেবা',
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0,
              children: [
                serviceCard(context, 'Elderly Care',
                    'বয়স্ক ব্যক্তির নিয়মিত যত্ন ও সহায়তা', Icons.elderly),
                serviceCard(context, 'Newborn Care', 'নবজাতক ও মায়ের যত্ন',
                    Icons.child_care),
                serviceCard(context, 'Bed Patient Care',
                    'শয্যাশায়ী রোগীর প্রয়োজনীয় সেবা', Icons.bed),
                serviceCard(context, 'Dementia Care',
                    'স্মৃতিভ্রংশ রোগীর বিশেষ যত্ন', Icons.psychology),
                serviceCard(context, 'General Caregiving',
                    'দৈনন্দিন কাজে সহযোগিতা', Icons.volunteer_activism),
                serviceCard(context, 'Other Nursing',
                    'অন্যান্য প্রয়োজনীয় নার্সিং সেবা', Icons.medical_services),
              ],
            ),
            const SizedBox(height: 25),
            sectionTitle('Why Choose Us?'),
            const FeatureTile(
              icon: Icons.verified_user,
              title: 'সরকারি সার্টিফাইড নার্স',
              subtitle: 'দক্ষ, অভিজ্ঞ ও প্রশিক্ষণপ্রাপ্ত নার্স',
            ),
            const FeatureTile(
              icon: Icons.favorite,
              title: 'যত্ন ও আন্তরিকতা',
              subtitle: 'রোগীর প্রয়োজন ও মর্যাদাকে গুরুত্ব দেওয়া',
            ),
            const FeatureTile(
              icon: Icons.access_time,
              title: 'Flexible Service',
              subtitle: '১২ ঘণ্টা ও ২৪ ঘণ্টার সেবা',
            ),
            const FeatureTile(
              icon: Icons.support_agent,
              title: '24/7 Service Support',
              subtitle: 'সার্ভিস সংক্রান্ত যোগাযোগের সুযোগ',
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(17),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle('Need a Nurse?'),
                  const Text(
                    'আপনার রোগীর প্রয়োজন অনুযায়ী নার্স পেতে '
                    'আমাদের সঙ্গে যোগাযোগ করুন।',
                    style: TextStyle(height: 1.6),
                  ),
                  const SizedBox(height: 14),
                  primaryButton('Request a Nurse', () => openBooking(context)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'ARMO Care Link\nComfort, Care, Commitment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: navy,
                  fontWeight: FontWeight.bold,
                  height: 1.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: mint, size: 28),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: dark)),
                Text(subtitle,
                    style:
                        const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- SERVICES PAGE ----------------

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  static const services = [
    ['Elderly Care', 'বয়স্ক বাবা-মা ও পরিবারের সদস্যদের যত্ন।'],
    ['Newborn Care', 'নবজাতক শিশু ও মায়ের যত্নে সহযোগিতা।'],
    ['Bed Patient Care', 'শয্যাশায়ী রোগীর দৈনন্দিন সেবা।'],
    ['Dementia Care', 'ডিমেনশিয়া রোগীর বিশেষ পরিচর্যা।'],
    ['General Caregiving', 'দৈনন্দিন প্রয়োজনীয় কাজে সহযোগিতা।'],
    ['Other Nursing Services', 'প্রয়োজন অনুযায়ী অন্যান্য নার্সিং সেবা।'],
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          brandHeader(compact: true),
          const SizedBox(height: 25),
          sectionTitle('Our Services', subtitle: 'আমাদের সকল হোম কেয়ার সেবা'),
          ...services.map(
            (s) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(Icons.health_and_safety, color: mint, size: 30),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s[0],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: dark)),
                        const SizedBox(height: 5),
                        Text(s[1],
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- SERVICE DETAILS ----------------

class ServiceDetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const ServiceDetailsPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Icon(icon, size: 80, color: navy)),
            const SizedBox(height: 25),
            Text(title,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: dark)),
            const SizedBox(height: 12),
            Text(description,
                style: const TextStyle(fontSize: 16, height: 1.7)),
            const SizedBox(height: 20),
            const Text(
              'আমাদের সরকারি সার্টিফাইড ও অভিজ্ঞ নার্সরা '
              'রোগীর অবস্থা এবং প্রয়োজন অনুযায়ী হোম কেয়ার '
              'সেবা প্রদানের জন্য প্রস্তুত।',
              style: TextStyle(height: 1.7),
            ),
            const Spacer(),
            primaryButton(
              'Book This Service',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BookingPage(standalone: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- BOOKING PAGE ----------------

class BookingPage extends StatefulWidget {
  final bool standalone;
  const BookingPage({super.key, this.standalone = false});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final mobile = TextEditingController();
  final age = TextEditingController();
  final weight = TextEditingController();
  final problem = TextEditingController();
  final location = TextEditingController();
  final extra = TextEditingController();

  String service = 'Elderly Care';
  String hours = '12 Hours';
  String duration = 'Long Term (2 Months or More)';
  String patientType = 'Normal Patient';

  bool accepted = false;

  final services = [
    'Elderly Care',
    'Newborn Care',
    'Bed Patient Care',
    'Dementia Care',
    'General Caregiving',
    'Other Nursing Services',
  ];

  @override
  void dispose() {
    name.dispose();
    mobile.dispose();
    age.dispose();
    weight.dispose();
    problem.dispose();
    location.dispose();
    extra.dispose();
    super.dispose();
  }

  Widget field(
    String label,
    TextEditingController controller, {
    String? hint,
    TextInputType keyboard = TextInputType.text,
    int lines = 1,
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: lines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE1E9EF)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE1E9EF)),
          ),
        ),
        validator: (v) {
          if (required && (v == null || v.trim().isEmpty)) {
            return 'এই তথ্যটি পূরণ করুন';
          }
          return null;
        },
      ),
    );
  }

  Widget dropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> change,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: items
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 13)),
                ))
            .toList(),
        onChanged: change,
      ),
    );
  }

  // প্রতিষ্ঠানের দেওয়া মাসিক রেঞ্জ (চূড়ান্ত মূল্য নয়)
  String get estimatedPrice {
    return hours == '12 Hours'
        ? '৳25,000 – ৳45,000+'
        : '৳30,000 – ৳50,000+';
  }

  Future<void> submitBooking() async {
    if (!formKey.currentState!.validate()) return;

    if (!accepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('অনুগ্রহ করে শর্তাবলিতে সম্মতি দিন।')),
      );
      return;
    }

    final message = '''
ARMO CARE LINK - NEW BOOKING REQUEST

Client Name: ${name.text}
Mobile: ${mobile.text}

Service: $service
Patient Type: $patientType
Patient Age: ${age.text}
Patient Weight: ${weight.text}

Patient Problem: ${problem.text}
Service Location: ${location.text}

Service Hours: $hours
Duration: $duration

Estimated Charge: $estimatedPrice

Additional Information:
${extra.text}

Please contact me regarding this booking request.
''';

    final uri = Uri.parse(
      'https://wa.me/88$phone1?text=${Uri.encodeComponent(message)}',
    );

    try {
      final launched =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('WhatsApp চালু করা যায়নি।')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('যোগাযোগ করতে সমস্যা হয়েছে।')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nurse Booking'),
        automaticallyImplyLeading: widget.standalone,
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              brandHeader(compact: true),
              const SizedBox(height: 22),
              sectionTitle(
                'Book a Professional Nurse',
                subtitle: 'নিচের তথ্যগুলো সঠিকভাবে পূরণ করুন',
              ),
              field('Client Name', name, hint: 'আপনার নাম'),
              field('Mobile Number', mobile,
                  hint: '01XXXXXXXXX', keyboard: TextInputType.phone),
              const Divider(height: 25),
              sectionTitle('Patient Information'),
              dropdown('Select Service', service, services,
                  (v) => setState(() => service = v!)),
              dropdown('Patient Condition', patientType,
                  ['Normal Patient', 'Critical Patient'],
                  (v) => setState(() => patientType = v!)),
              field('Patient Age', age,
                  hint: 'বয়স লিখুন', keyboard: TextInputType.number),
              field('Patient Weight', weight,
                  hint: 'ওজন (কেজি)', keyboard: TextInputType.number),
              field('Patient Problem', problem,
                  hint: 'রোগীর সমস্যা বিস্তারিত লিখুন', lines: 3),
              field('Service Location', location,
                  hint: 'সম্পূর্ণ ঠিকানা ও এলাকা', lines: 2),
              const Divider(height: 25),
              sectionTitle('Service Requirements'),
              dropdown('Service Hours', hours, ['12 Hours', '24 Hours'],
                  (v) => setState(() => hours = v!)),
              dropdown(
                'Service Duration',
                duration,
                [
                  'Short Term (Less Than 1 Month)',
                  'Long Term (2 Months or More)',
                ],
                (v) => setState(() => duration = v!),
              ),
              field('Additional Information', extra,
                  hint: 'অন্য কোনো বিশেষ চাহিদা থাকলে লিখুন',
                  lines: 3,
                  required: false),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: mint.withOpacity(.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: mint.withOpacity(.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Estimated Service Charge (Monthly)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: dark)),
                    const SizedBox(height: 8),
                    Text(estimatedPrice,
                        style: const TextStyle(
                            fontSize: 23,
                            color: navy,
                            fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    const Text(
                      'এটি শুধুমাত্র প্রাথমিক ধারণা। '
                      'রোগীর অবস্থা, লোকেশন, সার্ভিসের সময়কাল '
                      'ও নার্সের চাহিদা অনুযায়ী চূড়ান্ত মূল্য '
                      'নির্ধারণ করা হবে। শর্ট টার্মে দৈনিক রেট '
                      'কিছুটা বেশি হয়।',
                      style: TextStyle(fontSize: 12, height: 1.6),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              CheckboxListTile(
                value: accepted,
                onChanged: (v) => setState(() => accepted = v ?? false),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  'আমি বুঝতে পেরেছি যে এটি প্রাথমিক বুকিং অনুরোধ। '
                  'প্রতিষ্ঠানের সঙ্গে আলোচনা করে চূড়ান্ত মূল্য '
                  'ও সার্ভিস নিশ্চিত করতে হবে।',
                  style: TextStyle(fontSize: 12, height: 1.5),
                ),
              ),
              const SizedBox(height: 12),
              primaryButton('Submit Booking Request', submitBooking,
                  icon: Icons.send),
              const SizedBox(height: 12),
              const Text(
                'আপনার অনুরোধ WhatsApp-এ পাঠানো হবে। '
                'আলোচনা ও যাচাইয়ের পর বুকিং চূড়ান্ত হবে।',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- CONTACT PAGE ----------------

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> callNumber(String number) async {
    await launchUrl(Uri.parse('tel:$number'));
  }

  Future<void> openWhatsApp(String number) async {
    final uri = Uri.parse(
      'https://wa.me/88$number?text=${Uri.encodeComponent('Hello ARMO Care Link. I need home nursing care information.')}',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> openLink(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          brandHeader(),
          const SizedBox(height: 28),
          sectionTitle('Contact Us', subtitle: 'আমাদের সঙ্গে যোগাযোগ করুন'),
          contactCard(Icons.phone, 'Call Us', phone1, () => callNumber(phone1)),
          contactCard(Icons.phone_android, 'Alternative Number', phone2,
              () => callNumber(phone2)),
          contactCard(Icons.chat, 'WhatsApp', 'Chat with our team',
              () => openWhatsApp(phone1)),
          contactCard(Icons.email, 'Email', email,
              () => launchUrl(Uri.parse('mailto:$email'))),
          contactCard(Icons.location_on, 'Office Address', address, () async {
            await Clipboard.setData(const ClipboardData(text: address));
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Address copied')),
              );
            }
          }),
          const SizedBox(height: 20),
          sectionTitle('Office Hours'),
          const Text(
            'সার্ভিস: ২৪ ঘণ্টা\nঅফিস: সকাল ৯টা – সন্ধ্যা ৬টা',
            style: TextStyle(height: 2),
          ),
          const SizedBox(height: 20),
          sectionTitle('Online Platforms'),
          TextButton.icon(
            onPressed: () =>
                openLink('https://www.facebook.com/share/1EzBeWUE9d/'),
            icon: const Icon(Icons.facebook),
            label: const Text('Facebook Page'),
          ),
          TextButton.icon(
            onPressed: () => openLink('https://www.youtube.com/@armocarelink'),
            icon: const Icon(Icons.play_circle_outline),
            label: const Text('YouTube Channel'),
          ),
          TextButton.icon(
            onPressed: () => openLink('http://www.carelink.armoinitiative.com/'),
            icon: const Icon(Icons.language),
            label: const Text('Official Website'),
          ),
        ],
      ),
    );
  }

  Widget contactCard(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: navy, size: 27),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: dark)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 15, color: navy),
          ],
        ),
      ),
    );
  }
}
