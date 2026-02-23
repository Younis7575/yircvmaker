import 'package:appwrite/appwrite.dart';
import '../config/environment.dart';

class AppwriteService {

  static Client client = Client()
      .setEndpoint(Environment.appwritePublicEndpoint)
      .setProject(Environment.appwriteProjectId)
      .setSelfSigned(status: true);

  static Account account = Account(client);

  static Databases databases = Databases(client);

  static Storage storage = Storage(client);
}