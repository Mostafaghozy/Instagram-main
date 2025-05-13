import 'dart:io';
import '../data/models/story_model.dart';
import '../data/services/story_service.dart';

class StoryRepository {
  final StoryService _service = StoryService();

  Future<void> uploadStory(File file) async {
    final url = await _service.uploadImageToStorage(file);
    if (url != null) {
      await _service.saveStoryToDatabase(url);
    }
  }

  Future<List<StoryModel>> getStories() async {
    final storiesData = await _service.fetchStories();
    return storiesData
        .map((data) => StoryModel.fromMap(data as Map<String, dynamic>))
        .toList();
  }
}
