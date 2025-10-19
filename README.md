# Deploy Your First Robot on OpenMind Fabric Portal (Linux)

Bu rehberde, Linux üzerinde OM1 agent kurulumunu adım adım öğrenip kurulum yapabileceksiniz..

---

## 1- UV Kurulumu:

```bash
wget https://astral.sh/uv/install.sh
chmod +x install.sh
./install.sh
```

---

## 2- Gerekli Sistem Paketlerinin Kurulumu:

```bash
sudo apt-get update
sudo apt-get install portaudio19-dev python-all-dev -y
```
```bash
sudo apt-get update
sudo apt-get install ffmpeg -y
```

---

## 3- OM1 Reposunu Klonla:

```bash
git clone https://github.com/openmind/OM1.git
cd OM1
```

---

## 4- UV, Git ve Sanal Ortam Kurulumu:

```bash
pip install uv
git submodule update --init
uv venv
```
```bash
source .venv/bin/activate
```

---

## 5- API Anahtarını Ekle (.env):

```bash
cp env.example .env
nano .env
```

- Dosyada "OM-API-KEY=" şu satırı bul:
- OpenMind üzerinden oluşturduğun kendi **API anahtarını** buraya ekle.
- Kaydedip çık:
> CTRL + X → Y → ENTER

---

## 6- Node’u Screen İçerisinde Başlat:

Arka planda kesintisiz çalışması için node’u `screen` içinde başlatıyoruz:

```bash
screen -S openmind
```

Screen oturumu açıldıktan sonra:

```bash
cd ~/OM1
source .venv/bin/activate
uv run src/run.py spot
```

Artık agent terminalde çalışmaya başlayacak.
Çalışırken [fabric.openmindnetwork.xyz → Teleops] sayfasına git.

Screen’den çıkmak için:
```bash
CTRL + A + D
```

Tekrar girmek için:
```bash
screen -r openmind
```

---

## 🔁 Yeniden Başlatma:

Sunucu yeniden başlarsa veya node kapanırsa:

```bash
screen -r openmind
cd ~/OM1
source .venv/bin/activate
uv run src/run.py spot
```

---

## ⚠️ Sık Görülen Hatalar ve Çözümler:

| Hata                           | Sebep                            | Çözüm                                                                                                |
| ------------------------------ | -------------------------------- | ---------------------------------------------------------------------------------------------------- |
| `uv: command not found`        | uv kurulu değil                  | `pip install uv` komutunu çalıştır.                                                                  |
| `.venv/bin/activate not found` | sanal ortam oluşturulmamış       | `uv venv` komutunu tekrar çalıştır.                                                                  |
| `401 Unauthorized`             | OpenMind bakiyesi yetersiz       | [https://portal.openmind.org](https://portal.openmind.org) adresine girip kredi ekle.                |
| `portaudio not found`          | ses modülü eksik                 | `sudo apt install portaudio19-dev -y`      komutunu çalıştır.                                        |
| `ERROR: No output from LLM`    | API key hatalı veya kredi bitmiş | `.env` dosyasındaki key’i kontrol et veya yenisini oluştur                                           |

---

### 💡 Ek İpuçları

* OpenMind hesabı yeni açıldıysa **$5 deneme kredisi** gelir. Bu kredi bittiğinde agent çalışmaz.
* “401 Insufficient Balance” hatası görürsen eğer, hesabına kredi ekle ve node’u yeniden başlat.
* Node’u her zaman `screen` içinde çalıştır, böylece terminali kapatsan bile işlem arka planda devam eder.
