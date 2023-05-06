
import 'package:get/get.dart';

class HomeController extends GetxController  {

  var navigationBarIndex = 0.obs;

  set index(int index) => navigationBarIndex.value = index;
}

class HomeModel{

  HomeModel({required this.navigationBarIndex});

  int navigationBarIndex;

}