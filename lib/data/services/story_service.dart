import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/story_model.dart';

class StoryService {
  final supabase = Supabase.instance.client;

  /// Upload image to Supabase Storage
  Future<String?> uploadImageToStorage(File file) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // ignore: avoid_print
      print('❌ لا يوجد مستخدم مسجل في Firebase');
      return null;
    }

    final fileName = '${const Uuid().v4()}.jpg';
    print('📤 بدء رفع الصورة: $fileName');

    try {
      // تحقق من حجم الملف وطباعته للتصحيح
      final fileSize = await file.length();
      print('📊 حجم الملف: ${(fileSize / 1024).toStringAsFixed(2)} كيلوبايت');

      final response = await supabase.storage.from('stories').upload(
            'public/$fileName',
            file,
            fileOptions: const FileOptions(upsert: true),
          );

      if (response == null) {
        print('❌ فشل الرفع: لا توجد استجابة من Supabase');
        return null;
      }

      // الحصول على الرابط العام للملف المرفوع
      final url =
          supabase.storage.from('stories').getPublicUrl('public/$fileName');
      if (url.isEmpty) {
        print('❌ فشل الحصول على الرابط العام');
        return null;
      }

      print('✅ تم الرفع بنجاح: $url');
      return url;
    } catch (e) {
      print('❌ حدث خطأ غير متوقع أثناء الرفع: $e');
      return null;
    }
  }

  /// Save story to Supabase Database
  Future<bool> saveStoryToDatabase(String imageUrl) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('❌ لا يوجد مستخدم مسجل في Firebase');
      return false;
    }

    try {
      print('💾 جاري حفظ القصة في قاعدة البيانات...');
      print('👤 معرف المستخدم: ${user.uid}');
      print('🔗 رابط الصورة: $imageUrl');

      final currentTime = DateTime.now().toIso8601String();
      print('⏰ الوقت الحالي: $currentTime');

      final data = {
        'user_id': user.uid,
        'image_url': imageUrl,
        'timestamp': currentTime,
      };

      final response = await supabase.from('stories').insert(data).select();

      if (response == null) {
        print('❌ فشل حفظ القصة في قاعدة البيانات: لا توجد استجابة');
        return false;
      }

      // احصل على معرف القصة التي تم إنشاؤها
      if (response.isNotEmpty) {
        final storyId = response[0]['id'];
        print('✅ تم حفظ القصة في قاعدة البيانات بمعرف: $storyId');
        return true;
      } else {
        print('⚠️ تم الحفظ ولكن لم يتم استرجاع معرف القصة');
        return true;
      }
    } catch (e) {
      print('❌ حدث خطأ غير متوقع أثناء حفظ القصة: $e');
      // إعادة المحاولة مرة أخرى في حالة فشل الاتصال
      if (e.toString().contains('connection') ||
          e.toString().contains('timeout')) {
        try {
          print('🔄 إعادة محاولة حفظ القصة...');
          await Future.delayed(const Duration(seconds: 1));
          final response = await supabase.from('stories').insert({
            'user_id': user.uid,
            'image_url': imageUrl,
            'timestamp': DateTime.now().toIso8601String(),
          });
          print('✅ نجحت إعادة المحاولة: ${response != null}');
          return response != null;
        } catch (retryError) {
          print('❌ فشلت إعادة المحاولة: $retryError');
          return false;
        }
      }
      return false;
    }
  }

  /// Fetch all stories as List<StoryModel>
  Future<List<StoryModel>> fetchStories() async {
    try {
      print('🔍 جاري البحث عن القصص...');

      // استخدام select().order() بدلاً من select()
      final response = await supabase
          .from('stories')
          .select()
          .order('timestamp', ascending: false);

      if (response == null) {
        debugPrint('❌ فشل في جلب القصص: لا توجد استجابة');
        return [];
      }

      print('📊 تم العثور على ${(response as List).length} قصة');

      final stories = (response as List).map((story) {
        try {
          // طباعة بيانات كل قصة للتصحيح
          print(
              '📱 معرف القصة: ${story['id']}, الرابط: ${story['image_url']}, الوقت: ${story['timestamp']}');
          return StoryModel.fromMap(story);
        } catch (e) {
          print('❌ خطأ في تحويل بيانات القصة: $e');
          print('❓ بيانات القصة التي تسببت في الخطأ: $story');
          // إنشاء كائن StoryModel افتراضي في حالة حدوث خطأ
          return StoryModel(
            id: story['id'] ?? 'error',
            userId: story['user_id'] ?? 'unknown',
            imageUrl: story['image_url'] ?? '',
            timestamp:
                DateTime.tryParse(story['timestamp'] ?? '') ?? DateTime.now(),
          );
        }
      }).toList();

      return stories;
    } catch (e) {
      print('❌ حدث خطأ غير متوقع أثناء جلب القصص: $e');
      return [];
    }
  }
}
