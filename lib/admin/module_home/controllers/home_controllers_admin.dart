import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../../module_config/module_config.dart';
import '../../../module_home/models/home_model.dart';

class HomeControllerAdmin extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;
  TextEditingController controllerAniversariantes = TextEditingController();
  TextEditingController controllerPastoral = TextEditingController();

  List<File>? imageFileList = [];
  List<File>? imageFinal = [];
  List<dynamic>? programacao = [];

  List<dynamic>? aniversariantes = [];

  var isLoading = false.obs;
  HomeModel? homeModel;
  Dio dio = Dio();

  File? photo;
  final ImagePicker picker = ImagePicker();
  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
  }

  Future uploadFile(tipoImagem) async {
    if (photo == null) return;
    final fileName = basename(photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(photo!);
      final urlDownload = await ref.getDownloadURL();
      programacao!.add(urlDownload);
      print(urlDownload);
    } catch (e) {
      print('error occured');
    }
  }

  fetchData() async {
    isLoading(true);
    try {
      final Response result = await dio.get(
        ConstantsEndPoint.URL_BASE + ConstantsEndPoint.URL_HOME,
      );
      if (result.statusCode == 200) {
        isLoading(false);
        final responseData = (result.data['data'] ?? []) as List;
        homeModel = HomeModel.fromJson(responseData[0]);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  putData(id, pastoral) async {
    isLoading(true);
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "pastoral": pastoral,
        "programacao": [
          {
            "foto":
                "https://firebasestorage.googleapis.com/v0/b/metodista-novo.appspot.com/o/home%2Favisos%2FPHOTO-2024-01-06-13-00-34.jpg?alt=media&token=bdc03c02-82cb-4ebf-b525-768d603f9bfb",
            "descricao": "Culto de Oração"
          },
          {
            "foto":
                "https://firebasestorage.googleapis.com/v0/b/metodista-novo.appspot.com/o/home%2Favisos%2FPHOTO-2024-01-08-13-58-55.jpg?alt=media&token=1cfbb54e-06f7-40e1-be14-f7abd15d80ce",
            "descricao":
                "Nos anos anteriores, você já participou dos 12 Dias de Oração? Não? . Então se programe e venha estar conosco hoje à partir das 19h na Casa do Pai 💒 . Hoje é o 2• Dia de 12, e estaremos Clamando pelo Mês de Fevereiro 🔥 . “DEUS NÃO FAZ NADA SENÃO EM RESPOSTA À ORAÇÃO”. John Wesley"
          }
        ],
        "aniversariantes": [
          "GRAZIELA SILVA GRAZIEL - 15/01",
          "ALEXANDRE DE ARAÚJO LOPES - 19/01",
          "ANDRÉ LUIZ DA SILVA GONÇALVES - 19/01"
        ]
      });
      final Response result = await dio.put(
          '${ConstantsEndPoint.URL_BASE}${ConstantsEndPoint.URL_HOME}/H6N579qb87osK99SoyL0',
          data: data,
          options: Options(headers: headers));
      if (result.statusCode == 200) {
        isLoading(false);
        Get.defaultDialog(
            title: 'Home Screen', middleText: 'Atualizada com Sucesso');
      } else {
        isLoading(false);
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      Get.put(fetchData());
      isLoading(false);
      Get.put(fetchData());
    }
  }
}
