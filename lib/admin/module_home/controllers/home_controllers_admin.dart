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
  List<File>? imageFileList = [];
  List<File>? imageFinal = [];
  List<dynamic>? fotosCulto = [];
  List<dynamic>? avisos = [];
  List<dynamic>? aniversariantes = [];
  List<dynamic>? campanhas = [];

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
      if (tipoImagem == 'fotosCulto') {
        fotosCulto!.add(urlDownload);
      } else if (tipoImagem == 'campanha') {
        campanhas!.add(urlDownload);
      } else if (tipoImagem == 'avisos') {
        avisos!.add(urlDownload);
      }
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

  putData(avisos, campanhas, fotosculto, aniversariantes, id) async {
    isLoading(true);
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "avisos": avisos,
        "campanhas": campanhas,
        "fotosCultos": fotosCulto,
        "aniversariantes": aniversariantes
      });
      final Response result = await dio.put(
          '${ConstantsEndPoint.URL_BASE}${ConstantsEndPoint.URL_HOME}/${id}',
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
