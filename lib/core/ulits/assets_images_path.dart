const String imageAssetsRoot = "assets/images/";

String addTaskImage = _getAssetsImagePath('ToDo.png');

String _getAssetsImagePath(String fileName) {
  return imageAssetsRoot + fileName;
}
