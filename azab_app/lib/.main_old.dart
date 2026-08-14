import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const AzabApp());
}

class AzabApp extends StatelessWidget {
  const AzabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AZAB - شبكة اجتماعية',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      locale: const Locale('ar', 'SA'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
      ],
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: const [
            HomePage(),
            ExplorePage(),
            NotificationsPage(),
            SettingsPage(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: 'استكشاف',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined),
              selectedIcon: Icon(Icons.notifications),
              label: 'إشعارات',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'الإعدادات',
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== HomePage ====================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Post> posts = [
    Post(
      id: 1,
      author: 'أحمد محمد',
      avatar: '👨‍💼',
      timestamp: 'منذ 10 دقائق',
      content: 'أهلاً بكم في شبكة AZAB الاجتماعية! 🎉 منصة تواصل حديثة وآمنة للجميع.',
      likes: 245,
      comments: 12,
      shares: 8,
    ),
    Post(
      id: 2,
      author: 'فاطمة علي',
      avatar: '👩‍💻',
      timestamp: 'منذ 30 دقيقة',
      content: 'اليوم يوم جميل للعمل والإنتاجية 💪 نحن نصنع الفرق معاً.',
      likes: 156,
      comments: 8,
      shares: 5,
    ),
    Post(
      id: 3,
      author: 'محمد السيد',
      avatar: '👨‍🎓',
      timestamp: 'منذ ساعة',
      content: 'اكتشفت ميزة جديدة رائعة في التطبيق! 🌟 يجب أن تجربوها.',
      likes: 320,
      comments: 25,
      shares: 12,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AZAB',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () => _showSearchDialog(context),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      child: Icon(Icons.person),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showCreatePostDialog(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Text(
                            'ماذا في بالك؟',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ...posts.map((post) => PostCard(post: post)),
        ],
      ),
    );
  }

  void _showCreatePostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إنشاء منشور جديد'),
        content: TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'اكتب ما يدور في بالك...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم نشر المنشور بنجاح ✓')),
              );
            },
            child: const Text('نشر'),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('البحث'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'ابحث عن أشخاص أو منشورات...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }
}

// ==================== PostCard ====================
class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool isLiked;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = false;
    likeCount = widget.post.likes;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Text(widget.post.avatar),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.author,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        widget.post.timestamp,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(child: Text('متابعة')),
                    const PopupMenuItem(child: Text('الإبلاغ')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.post.content,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.grey[300]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$likeCount إعجاب',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                Text(
                  '${widget.post.comments} تعليق',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                Text(
                  '${widget.post.shares} مشاركة',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            Divider(color: Colors.grey[300]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ActionButton(
                  icon: isLiked ? Icons.favorite : Icons.favorite_border,
                  label: 'إعجاب',
                  color: isLiked ? Colors.red : Colors.grey,
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                      likeCount += isLiked ? 1 : -1;
                    });
                  },
                ),
                _ActionButton(
                  icon: Icons.comment_outlined,
                  label: 'تعليق',
                  onTap: () => _showCommentDialog(context),
                ),
                _ActionButton(
                  icon: Icons.share_outlined,
                  label: 'مشاركة',
                  onTap: () => _showShareDialog(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCommentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة تعليق'),
        content: TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'اكتب تعليقك...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إضافة التعليق ✓')),
              );
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showShareDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('مشاركة المنشور'),
        content: const Text('اختر طريقة المشاركة:'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم النسخ إلى الحافظة ✓')),
              );
            },
            child: const Text('نسخ الرابط'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم المشاركة ✓')),
              );
            },
            child: const Text('مشاركة'),
          ),
        ],
      ),
    );
  }
}

// ==================== ExplorePage ====================
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('استكشاف'),
        centerTitle: true,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'ابحث عن مستخدمين أو هاشتاجات...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'الترندات',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            5,
            (index) => Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text('#ترند${index + 1}'),
                subtitle: Text('${(index + 1) * 1000} منشور'),
                trailing: const Icon(Icons.trending_up),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'حسابات مقترحة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            4,
            (index) => Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(['👨‍💼', '👩‍💻', '👨‍🎓', '👩‍🎨'][index]),
                ),
                title: Text('المستخدم ${index + 1}'),
                subtitle: const Text('@username'),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('متابعة'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== NotificationsPage ====================
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'user': 'أحمد محمد',
        'action': 'أعجب بمنشورك',
        'time': 'منذ 5 دقائق',
        'icon': Icons.favorite,
      },
      {
        'user': 'فاطمة علي',
        'action': 'علق على منشورك',
        'time': 'منذ 20 دقيقة',
        'icon': Icons.comment,
      },
      {
        'user': 'محمد السيد',
        'action': 'بدأ متابعتك',
        'time': 'منذ 1 ساعة',
        'icon': Icons.person_add,
      },
      {
        'user': 'سارة أحمد',
        'action': 'شارك منشورك',
        'time': 'منذ 2 ساعة',
        'icon': Icons.share,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات'),
        centerTitle: true,
        elevation: 1,
      ),
      body: ListView(
        children: notifications.map(
          (notification) => ListTile(
            leading: CircleAvatar(
              child: Icon(notification['icon'] as IconData),
            ),
            title: Text(notification['user'] as String),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification['action'] as String),
                Text(
                  notification['time'] as String,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            trailing: const Icon(Icons.chevron_left),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'تم الضغط على إشعار من ${notification['user']}'),
                ),
              );
            },
          ),
        ).toList(),
      ),
    );
  }
}

// ==================== SettingsPage ====================
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _privateAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات والملف الشخصي'),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 60),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'أحمد محمد',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '@ahmad.mohammed',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'مرحباً بك في شبكة AZAB الاجتماعية! 🌟',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(label: 'المتابعات', value: '150'),
                      _StatItem(label: 'المتابعون', value: '325'),
                      _StatItem(label: 'المنشورات', value: '42'),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الإعدادات',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('الوضع الليلي'),
                    subtitle: const Text('تفعيل الوضع الليلي'),
                    value: _darkMode,
                    onChanged: (value) {
                      setState(() {
                        _darkMode = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('الإشعارات'),
                    subtitle: const Text('تلقي إشعارات التطبيق'),
                    value: _notifications,
                    onChanged: (value) {
                      setState(() {
                        _notifications = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('حساب خاص'),
                    subtitle: const Text('جعل حسابك خاص'),
                    value: _privateAccount,
                    onChanged: (value) {
                      setState(() {
                        _privateAccount = value;
                      });
                    },
                  ),
                  const Divider(),
                  _OptionTile(
                    icon: Icons.edit,
                    label: 'تعديل الملف الشخصي',
                    onTap: () {},
                  ),
                  _OptionTile(
                    icon: Icons.lock,
                    label: 'الخصوصية والأمان',
                    onTap: () {},
                  ),
                  _OptionTile(
                    icon: Icons.help,
                    label: 'المساعدة والدعم',
                    onTap: () {},
                  ),
                  _OptionTile(
                    icon: Icons.info,
                    label: 'حول التطبيق',
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'AZAB',
                        applicationVersion: '1.0.0',
                        children: [
                          const Text(
                              'شبكة اجتماعية حديثة وآمنة للجميع 🌍'),
                        ],
                      );
                    },
                  ),
                  _OptionTile(
                    icon: Icons.logout,
                    label: 'تسجيل الخروج',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('تسجيل الخروج'),
                          content: const Text('هل تريد تسجيل الخروج؟'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('إلغاء'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('خروج'),
                            ),
                          ],
                        ),
                      );
                    },
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

// ==================== Helper Widgets ====================
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color ?? Colors.grey, size: 20),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color ?? Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.chevron_left, size: 20),
      onTap: onTap,
    );
  }
}

// ==================== Model ====================
class Post {
  final int id;
  final String author;
  final String avatar;
  final String timestamp;
  final String content;
  final int likes;
  final int comments;
  final int shares;

  Post({
    required this.id,
    required this.author,
    required this.avatar,
    required this.timestamp,
    required this.content,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}
