import 'dart:io';

enum AttachmentType {
  document("DOCUMENT"),
  image("IMAGE"),
  audio("AUDIO"),
  video("VIDEO");

  const AttachmentType(this.value);
  final String value;

  factory AttachmentType.fromValue(String value) {
    final res = AttachmentType.values.where(
      (element) => element.value == value,
    );

    if (res.isEmpty) {
      throw 'ValueError: $value is not a valid attachment type';
    }

    return res.first;
  }
}

enum UploadStatus {
  notUploading("NOT_UPLOADING"),
  uploading("UPLOADING"),
  uploaded("UPLOADED");

  const UploadStatus(this.value);
  final String value;
  factory UploadStatus.fromValue(String value) {
    final res = UploadStatus.values.where(
      (element) => element.value == value,
    );

    if (res.isEmpty) {
      throw 'ValueError: $value is not a valid upload status';
    }

    return res.first;
  }
}

class Attachment {
  final String fileName;
  final String fileSize;
  final AttachmentType type;
  UploadStatus uploadStatus;
  String url;
  File? file;

  Attachment({
    required this.type,
    required this.url,
    required this.fileName,
    required this.fileSize,
    this.uploadStatus = UploadStatus.uploading,
    this.file,
  });

  factory Attachment.fromMap(Map<String, dynamic> data) {
    return Attachment(
      url: data["url"],
      fileName: data["fileName"],
      fileSize: data["fileSize"],
      type: AttachmentType.fromValue(data["type"]),
      uploadStatus:
          UploadStatus.fromValue(data["uploadStatus"] ?? "NOT_UPLOADING"),
    );
  }

  @override
  String toString() {
    return fileName;
  }

  Map<String, dynamic> toMap() {
    return {
      "url": url,
      "fileName": fileName,
      "fileSize": fileSize,
      "type": type.value,
      "uploadStatus": uploadStatus.value,
    };
  }
}
