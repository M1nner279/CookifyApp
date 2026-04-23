import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class PhotoController extends ChangeNotifier {
  PhotoController();

  final _photos = <XFile>[];

  List<XFile> get photos => List.unmodifiable(_photos);
  bool get isEmpty => _photos.isEmpty;

  void add(XFile photo) {
    _photos.add(photo);
    notifyListeners();
  }

  void addAll(List<XFile> photos) {
    _photos.addAll(photos);
    notifyListeners();
  }

  void remove(XFile photo) {
    _photos.remove(photo);
    notifyListeners();
  }

  void clear() {
    _photos.clear();
    notifyListeners();
  }
}
