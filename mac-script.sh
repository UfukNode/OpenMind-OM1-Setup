#!/bin/bash

set -e

echo "🚀 OpenMind OM1 Node kurulumu başlatılıyor..."
sleep 1

if ! command -v brew &> /dev/null; then
    echo "Homebrew kurulumu yapılıyor..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Gerekli bağımlılıklar yükleniyor..."
brew install python uv portaudio ffmpeg git -q

cd ~
if [ ! -d "OM1" ]; then
    git clone https://github.com/openmind/OM1.git
fi

cd OM1
git submodule update --init

echo "Sanal ortam oluşturuluyor..."
uv venv
source .venv/bin/activate

echo ""
read -p "Lütfen OpenMind API key'inizi girin: " API_KEY

if [ ! -f ".env" ]; then
    cp env.example .env
fi

sed -i '' "s|^OM_API_KEY=.*|OM_API_KEY=$API_KEY|" .env

echo ""
echo "API key başarıyla eklendi!"
echo "--------------------------------"
cat .env | grep OM_API_KEY
echo "--------------------------------"

echo ""
echo "✅Node başlatılıyor..."
sleep 2
uv run src/run.py conversation
