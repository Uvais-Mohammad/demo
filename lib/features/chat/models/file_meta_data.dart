class FileMetaData {
  String? fileName;
  int? fileSize;
  String? fileType;
  int? duration;
  String? thumbnail;

  FileMetaData(
      {this.fileName,
      this.fileSize,
      this.fileType,
      this.duration,
      this.thumbnail});

  FileMetaData.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    fileSize = json['fileSize'];
    fileType = json['fileType'];
    duration = json['duration'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['fileSize'] = this.fileSize;
    data['fileType'] = this.fileType;
    data['duration'] = this.duration;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}