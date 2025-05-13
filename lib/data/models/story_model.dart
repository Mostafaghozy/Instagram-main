class StoryModel {
  final String id;
  final String userId;
  final String imageUrl;
  final DateTime timestamp;

  StoryModel({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.timestamp,
  });

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    try {
      // طباعة المفاتيح المتوفرة في الخريطة للتصحيح
      print('📋 مفاتيح الخريطة المتاحة: ${map.keys.toList()}');

      // التعامل مع مختلف أشكال التاريخ الممكنة
      DateTime parsedTimestamp;
      final rawTimestamp = map['timestamp'];

      if (rawTimestamp is String) {
        try {
          parsedTimestamp = DateTime.parse(rawTimestamp);
        } catch (e) {
          print('❌ خطأ في تحليل التاريخ: $e');
          parsedTimestamp = DateTime.now();
        }
      } else {
        // إذا لم يكن تاريخًا صالحًا، استخدم الوقت الحالي
        parsedTimestamp = DateTime.now();
      }

      return StoryModel(
        id: map['id']?.toString() ?? '',
        userId: map['user_id']?.toString() ?? '',
        imageUrl: map['image_url']?.toString() ?? '',
        timestamp: parsedTimestamp,
      );
    } catch (e) {
      print('❌ خطأ عام في تحويل الخريطة إلى StoryModel: $e');
      // في حالة الفشل، إرجاع نموذج بقيم افتراضية
      return StoryModel(
        id: map['id']?.toString() ?? 'unknown',
        userId: map['user_id']?.toString() ?? 'unknown',
        imageUrl: map['image_url']?.toString() ?? '',
        timestamp: DateTime.now(),
      );
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'image_url': imageUrl,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'StoryModel(id: $id, userId: $userId, imageUrl: $imageUrl, timestamp: $timestamp)';
  }
}
