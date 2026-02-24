import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class PaymentController extends GetxController {

  var trxId="".obs;
  var imagePath="".obs;

  final box=GetStorage();

  void pickImage() async{

    final picker=ImagePicker();

    final file=await picker.pickImage(
        source: ImageSource.gallery);

    if(file!=null){

      imagePath.value=file.path;

    }

  }


  void submitOrder(String name,String image){

    List orders=box.read("orders")??[];

    orders.add({

      "name":name,
      "image":image,
      "trx":trxId.value,
      "status":"Pending"

    });

    box.write("orders",orders);

  }

}