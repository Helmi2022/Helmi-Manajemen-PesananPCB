import 'dart:io';
import 'dart:collection';
class PesananPCB {
  String namaPelanggan;
  String nomorTelepon;
  String alamat;
  String namaProyek;
  double luasPCB;
  String bahan;

  PesananPCB(this.namaPelanggan, this.nomorTelepon, this.alamat, this.namaProyek, this.luasPCB, this.bahan);

  double hitungBiaya() {
    double biayaPerCm2;
    switch (bahan.toLowerCase()) {
      case 'fr4':
        biayaPerCm2 = 500;
        break;
      case 'aluminium':
        biayaPerCm2 = 600;
        break;
      case 'fr2':
        biayaPerCm2 = 300;
        break;
      default:
        biayaPerCm2 = 500;
        break;
    }
    return luasPCB * biayaPerCm2;
  }

  @override
  String toString() {
    return 'Nama Pelanggan: $namaPelanggan\nNomor Telepon: $nomorTelepon\nAlamat: $alamat\nNama Proyek: $namaProyek\nLuas PCB: $luasPCB cm2\nBahan: $bahan\nBiaya Produksi: ${hitungBiaya()}';
  }
}

void tambahPesanan(List<PesananPCB> daftarPesanan, Map<String, PesananPCB> pesananMap, Queue<PesananPCB> pesananQueue) {
  stdout.write('Masukkan Nama Pelanggan: ');
  String? namaPelanggan = stdin.readLineSync();
  stdout.write('Masukkan Nomor Telepon: ');
  String? nomorTelepon = stdin.readLineSync();
  stdout.write('Masukkan Alamat: ');
  String? alamat = stdin.readLineSync();
  stdout.write('Masukkan Nama Proyek: ');
  String? namaProyek = stdin.readLineSync();
  stdout.write('Masukkan Luas PCB (cm2): ');
  double? luasPCB = double.tryParse(stdin.readLineSync()!);
  stdout.write('Masukkan Bahan (FR4/Aluminium/FR2): ');
  String? bahan = stdin.readLineSync();

  if (namaPelanggan != null && nomorTelepon != null && alamat != null && namaProyek != null && luasPCB != null && bahan != null) {
    PesananPCB pesanan = PesananPCB(namaPelanggan, nomorTelepon, alamat, namaProyek, luasPCB, bahan);
    daftarPesanan.add(pesanan);
    pesananMap[namaPelanggan] = pesanan;
    pesananQueue.add(pesanan);
    print('Pesanan berhasil ditambahkan.');
  } else {
    print('Data tidak valid.');
  }
}

void lihatSemuaPesanan(Queue<PesananPCB> pesananQueue) {
  if (pesananQueue.isEmpty) {
    print('Tidak ada pesanan.');
  } else {
    for (var pesanan in pesananQueue) {
      print(pesanan);
      print('---------------------');
    }
  }
}

void cariPesanan(Map<String, PesananPCB> pesananMap) {
  stdout.write('Masukkan Nama Pelanggan yang dicari: ');
  String? namaPelanggan = stdin.readLineSync();
  if (namaPelanggan != null && pesananMap.containsKey(namaPelanggan)) {
    print(pesananMap[namaPelanggan]);
  } else {
    print('Pesanan tidak ditemukan.');
  }
}
void perbaruiPesanan(List<PesananPCB> daftarPesanan, Map<String, PesananPCB> pesananMap) {
  stdout.write('Masukkan Nama Pelanggan yang akan diperbarui: ');
  String? namaPelanggan = stdin.readLineSync();
  if (namaPelanggan != null && pesananMap.containsKey(namaPelanggan)) {
    PesananPCB pesanan = pesananMap[namaPelanggan]!;
    stdout.write('Masukkan Nomor Telepon baru: ');
    String? nomorTelepon = stdin.readLineSync();
    stdout.write('Masukkan Alamat baru: ');
    String? alamat = stdin.readLineSync();
    stdout.write('Masukkan Nama Proyek baru: ');
    String? namaProyek = stdin.readLineSync();
    stdout.write('Masukkan Luas PCB baru (cm2): ');
    double? luasPCB = double.tryParse(stdin.readLineSync()!);
    stdout.write('Masukkan Bahan baru (FR4/Aluminium/Flex): ');
    String? bahan = stdin.readLineSync();

    if (nomorTelepon != null && alamat != null && namaProyek != null && luasPCB != null && bahan != null) {
      pesanan.nomorTelepon = nomorTelepon;
      pesanan.alamat = alamat;
      pesanan.namaProyek = namaProyek;
      pesanan.luasPCB = luasPCB;
      pesanan.bahan = bahan;
      print('Pesanan berhasil diperbarui.');
    } else {
      print('Data tidak valid.');
    }
  } else {
    print('Pesanan tidak ditemukan.');
  }
}

void hapusPesanan(List<PesananPCB> daftarPesanan, Map<String, PesananPCB> pesananMap, Queue<PesananPCB> pesananQueue) {
  stdout.write('Masukkan Nama Pelanggan yang akan dihapus: ');
  String? namaPelanggan = stdin.readLineSync();
  if (namaPelanggan != null && pesananMap.containsKey(namaPelanggan)) {
    PesananPCB pesanan = pesananMap[namaPelanggan]!;
    daftarPesanan.remove(pesanan);
    pesananMap.remove(namaPelanggan);
    pesananQueue.remove(pesanan);
    print('Pesanan berhasil dihapus.');
  } else {
    print('Pesanan tidak ditemukan.');
  }
}
void main() {
  List<PesananPCB> daftarPesanan = [];
  Map<String, PesananPCB> pesananMap = {};
  Queue<PesananPCB> pesananQueue = Queue();

  while (true) {
    print('\nManajemen Pesanan PCB');
    print('1. Tambah Pesanan');
    print('2. Lihat Semua Pesanan');
    print('3. Cari Pesanan');
    print('4. Perbarui Pesanan');
    print('5. Hapus Pesanan');
    print('6. Keluar');
    stdout.write('Pilih menu: ');
    String? pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1':
        tambahPesanan(daftarPesanan, pesananMap, pesananQueue);
        break;
      case '2':
        lihatSemuaPesanan(pesananQueue);
        break;
      case '3':
        cariPesanan(pesananMap);
        break;
      case '4':
        perbaruiPesanan(daftarPesanan, pesananMap);
        break;
      case '5':
        hapusPesanan(daftarPesanan, pesananMap, pesananQueue);
        break;
      case '6':
        exit(0);
      default:
        print('Pilihan tidak valid.');
    }
  }
}
