#!/bin/bash

set -e

GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

echo -e "${CYAN}OpenMind OM1 Node kurulumu başlatılıyor...${RESET}"
sleep 1

if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Homebrew kurulumu yapılıyor...${RESET}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo -e "${YELLOW}Gerekli bağımlılıklar yükleniyor...${RESET}"
brew install python uv portaudio ffmpeg git -q

cd ~
if [ ! -d "OM1" ]; then
    git clone https://github.com/openmind/OM1.git
fi

cd OM1
git submodule update --init

echo -e "${YELLOW}Sanal ortam oluşturuluyor...${RESET}"
uv venv
source .venv/bin/activate

echo ""
read -p "$(echo -e ${CYAN}Lütfen OpenMind API key'inizi girin:${RESET} ) " API_KEY

# .env dosyasını oluştur ve anahtarı yerleştir
if [ ! -f ".env" ]; then
    cp env.example .env
fi

sed -i '' "s|^OM_API_KEY=.*|OM_API_KEY=$API_KEY|" .env

# Node başlat
echo ""
echo -e "${GREEN}Node başlatılıyor...${RESET}"
sleep 2
uv run src/run.py conversation
