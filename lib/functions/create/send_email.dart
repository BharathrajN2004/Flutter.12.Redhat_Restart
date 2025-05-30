import 'package:sendgrid_mailer/sendgrid_mailer.dart';
// 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

Future<void> sendStaffEmail({
  required String imageURL,
  required String receiverEmail,
  required String name,
  required String registrationNo,
}) async {
  final mailer = Mailer(
      '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');
  final toAddress = Address(receiverEmail);
  const fromAddress = Address('advantage.redhat@gmail.com');
  const subject = 'Invitation from Vectra Pro (Redhat academy)';
  final personalization = Personalization([
    toAddress
  ], dynamicTemplateData: {
    "image_url": imageURL,
    "name": name,
    "registrationID": registrationNo,
    "app_link": "http://www.google.com",
  });

  final email = Email([personalization], fromAddress, subject,
      templateId: "d-33064115105143d18bc332f22b8cc04e");
  mailer.send(email).then((result) {
    print("error:      ${result.isError}");
    print(result.asError?.error);
  });
}

// d-49ddbc9bd2cc45e2bbcacf940b2eecfc

Future<void> sendStudentEmail({
  required String receiverEmail,
  required String name,
  required String batchID,
  required String registrationNo,
}) async {
  final mailer = Mailer(
      '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');
  final toAddress = Address(receiverEmail);
  const fromAddress = Address('advantage.redhat@gmail.com');
  const subject = 'Invitation from Vectra Pro (Redhat academy)';
  final personalization = Personalization([
    toAddress
  ], dynamicTemplateData: {
    "name": name,
    "batchID": batchID,
    "registrationID": registrationNo,
    "app_link": "http://www.google.com",
  });

  final email = Email([personalization], fromAddress, subject,
      templateId: "d-49ddbc9bd2cc45e2bbcacf940b2eecfc");
  mailer.send(email).then((result) {
    print("error:      ${result.isError}");
    print(result.asError?.error);
  });
}
