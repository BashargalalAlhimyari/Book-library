import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:hive/hive.dart';

// 1. اجعل الدالة Future لأن عمليات Hive قد تأخذ وقتاً (خاصة المسح)
Future<void> saveBooks(List<BookEntity> books, String boxName) async {
  var box = Hive.box<BookEntity>(boxName);

  // 2. ✅ مهم جداً: مسح البيانات القديمة لكي لا تتراكم
  await box.clear(); 

  // 3. إضافة البيانات الجديدة الطازجة
  await box.addAll(books);
}