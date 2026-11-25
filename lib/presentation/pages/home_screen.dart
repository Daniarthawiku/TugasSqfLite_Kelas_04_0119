import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_sqf_lite/model/barang.dart';
import 'package:tugas_sqf_lite/presentation/controller/barang_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showForm(BarangController ctr, [Barang? barang]) {
    final namaCtr = TextEditingController(text: barang?.nama ?? '');
    final stokCtr = TextEditingController(text: barang?.stok.toString() ?? '');

    Get.defaultDialog(
      title: barang == null ? "Tambah Barang" : "Edit Barang",
      content: Padding(
        padding: const EdgeInsetsGeometry.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            TextField(
              controller: namaCtr,
              decoration: const InputDecoration(labelText: "Nama Barang"),
            ),
            TextField(
              controller: stokCtr,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Stok"),
            ),
          ],
        ),
      ),
      textConfirm: "Simpan",
      textCancel: "Batal",
      onConfirm: () {
        final nama = namaCtr.text.trim();
        final stok = int.tryParse(stokCtr.text.trim());
        if (nama.isEmpty) return;
        if (stok == null) {
          Get.snackbar(
            "Error",
            "Stok harus berupa angka bulat",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
          return;
        }

        if (barang == null) {
          ctr.tambahBarang(Barang(nama: nama, stok: stok));
        } else {
          ctr.updateBarang(barang.copyWith(nama: nama, stok: stok));
        }
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctr = Get.find<BarangController>();
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(ctr),
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Text("LIST BARANG"),

          Expanded(
            child: Obx(() {
              if (ctr.barangList.isEmpty) {
                return Center(child: Text("Data Belum Ada"));
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: ctr.barangList.length,
                  itemBuilder: (context, index) {
                    final barang = ctr.barangList[index];
                    return Card(
                      child: ListTile(
                        title: Text(barang.nama),
                        subtitle: Text("Stok: ${barang.stok}"),
                        onTap: () => _showForm(ctr, barang),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => ctr.hapusBarang(barang.id!),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
