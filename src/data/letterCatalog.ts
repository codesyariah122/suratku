export type LetterCatalogItem = readonly [
  slug: string,
  title: string,
  description: string,
  icon: string,
]

export type LetterCatalogGroup = {
  name: string
  description: string
  items: LetterCatalogItem[]
}

export const letterCatalog: LetterCatalogGroup[] = [
  {
    name: 'Korespondensi eksternal',
    description: 'Komunikasi resmi dengan klien, vendor, dan mitra.',
    items: [
      ['penawaran', 'Surat Penawaran', 'Proposal harga atau layanan', '↗'],
      ['permohonan', 'Surat Permohonan', 'Permintaan resmi kepada pihak lain', '✦'],
      ['undangan', 'Surat Undangan', 'Rapat, acara, atau pertemuan', '◫'],
      ['pemberitahuan', 'Surat Pemberitahuan', 'Informasi resmi kepada pihak terkait', '◉'],
      ['kerjasama', 'Surat Kerja Sama', 'Pembuka atau tindak lanjut kemitraan', '◇'],
      ['balasan', 'Surat Balasan Resmi', 'Jawaban atas surat yang diterima', '↩'],
    ],
  },
  {
    name: 'Human Resources',
    description: 'Administrasi dan komunikasi ketenagakerjaan.',
    items: [
      ['keterangan-kerja', 'Surat Keterangan Kerja', 'Konfirmasi status karyawan', '▣'],
      ['pengangkatan', 'Surat Pengangkatan', 'Pengangkatan pegawai atau jabatan', '↑'],
      ['mutasi', 'Surat Mutasi', 'Perubahan unit atau lokasi kerja', '⇄'],
      ['promosi', 'Surat Promosi', 'Kenaikan jabatan karyawan', '△'],
      ['peringatan', 'Surat Peringatan', 'Peringatan dan tindakan disiplin', '!'],
      ['phk', 'Surat Pemutusan Kerja', 'Pemberitahuan berakhirnya hubungan kerja', '⊘'],
    ],
  },
  {
    name: 'Internal perusahaan',
    description: 'Dokumen operasional untuk organisasi dan tim.',
    items: [
      ['memo', 'Memo Internal', 'Arahan atau informasi antar divisi', 'M'],
      ['tugas', 'Surat Tugas', 'Penugasan pegawai atau tim', '✓'],
      ['keputusan', 'Surat Keputusan', 'Ketetapan resmi perusahaan', '§'],
      ['edaran', 'Surat Edaran', 'Informasi untuk banyak penerima', '◎'],
      ['kuasa', 'Surat Kuasa', 'Pelimpahan kewenangan tertentu', '⌘'],
      ['berita-acara', 'Berita Acara', 'Dokumentasi kegiatan atau serah terima', '≡'],
    ],
  },
  {
    name: 'Keuangan & komersial',
    description: 'Dokumen penagihan dan administrasi bisnis.',
    items: [
      ['tagihan', 'Surat Penagihan', 'Pengingat pembayaran invoice', 'Rp'],
      ['konfirmasi', 'Surat Konfirmasi', 'Konfirmasi transaksi atau kesepakatan', '✓'],
      ['pesanan', 'Surat Pesanan', 'Pemesanan barang atau jasa', '□'],
      ['komplain', 'Surat Keluhan Bisnis', 'Keluhan resmi kepada vendor', '!'],
      ['rekomendasi', 'Surat Rekomendasi', 'Rekomendasi profesional perusahaan', '★'],
      ['resmi', 'Surat Resmi Kosong', 'Mulai dari format formal standar', '+'],
    ],
  },
]

export const baseLetterCatalogCount = letterCatalog.reduce(
  (total, group) => total + group.items.length,
  0,
)
