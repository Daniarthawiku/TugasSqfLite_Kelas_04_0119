import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_sqf_lite/data/repo/barang_repo.dart';
import 'package:tugas_sqf_lite/model/barang.dart';

class BarangController extends GetxController {
  final BarangRepo repo;
  BarangController(this.repo);

  var barangList = <Barang>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBarang();
  }

  Future<void> getBarang() async {
    try {
      barangList.value = await repo.getAllBarang();
      Get.snackbar("Sukses", "Berhasil");
    } catch (e) {
      Get.snackbar("Error", "Gagal", colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  Future<void> tambahBarang(Barang barang) async {
    try {
      await repo.insert(barang);
      await getBarang();
      Get.snackbar(
        "Sukses",
        "Barang dengan nama ${barang.nama} Berhasil ditambahkan",
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> updateBarang(Barang barang) async {
    try {
      await repo.update(barang);
      await getBarang();
      Get.snackbar(
        "Sukses",
        "Barang ${barang.nama} berhasil diubah",
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> hapusBarang(int id) async {
    try {
      await repo.delete(id);
      await getBarang();
      Get.snackbar(
        "Sukses",
        "Barang berhasil dihapus",
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
