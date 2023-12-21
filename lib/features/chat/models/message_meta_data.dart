class MessageMetaData {
  String? replyId;
  int? isForward;
  String? fileName;
  int? fileSize;
  String? fileType;
  int? duration;

  MessageMetaData({
    this.fileName,
    this.fileSize,
    this.fileType,
    this.duration,
    this.replyId,
    this.isForward,
  });

  MessageMetaData.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    fileSize = json['fileSize'];
    fileType = json['fileType'];
    fileType = json['fileType'];
    replyId = json['replyId'];
    isForward = json['isForward'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['fileSize'] = this.fileSize;
    data['fileType'] = this.fileType;
    data['duration'] = this.duration;
    data['replyId'] = this.replyId;
    data['isForward'] = this.isForward;
    data['duration'] = this.duration;
    return data;
  }
}
