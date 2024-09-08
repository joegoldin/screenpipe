set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

screenpipe:
    sudo cargo run --release --bin screenpipe -- --ocr-engine windows-native --debug --audio-device "In 1-2 (MOTU M Series) (input)" --audio-device "Out 1-2 (MOTU M Series) (output)" --monitor-id 288362319 --use-pii-removal --audio-transcription-engine deepgram --disable-vision

build:
    cargo build --release

build-tauri: build
    cd examples/apps/screenpipe-app-tauri
    bun scripts/pre_build.js
    bun tauri build
