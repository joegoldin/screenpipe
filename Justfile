set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

build:
    cargo build --release

screenpipe:
    sudo .\target\release\screenpipe.exe --ocr-engine windows-native --debug --audio-device "In 1-2 (MOTU M Series) (input)" --audio-device "Out 1-2 (MOTU M Series) (output)" --monitor-id (.\target\release\screenpipe.exe --list-monitors | Select-String 'id: (\d+).*is_primary: true' | ForEach-Object { $_.Matches.Groups[1].Value }).Trim() --use-pii-removal --audio-transcription-engine deepgram

screenpipe-audio:
    sudo .\target\release\screenpipe.exe --ocr-engine windows-native --debug --audio-device "In 1-2 (MOTU M Series) (input)" --audio-device "Out 1-2 (MOTU M Series) (output)" --monitor-id (.\target\release\screenpipe.exe --list-monitors | Select-String 'id: (\d+).*is_primary: true' | ForEach-Object { $_.Matches.Groups[1].Value }).Trim() --use-pii-removal --audio-transcription-engine deepgram --disable-vision

screenpipe-video:
    sudo .\target\release\screenpipe.exe --ocr-engine windows-native --debug --audio-device "In 1-2 (MOTU M Series) (input)" --audio-device "Out 1-2 (MOTU M Series) (output)" --monitor-id (.\target\release\screenpipe.exe --list-monitors | Select-String 'id: (\d+).*is_primary: true' | ForEach-Object { $_.Matches.Groups[1].Value }).Trim() --use-pii-removal --audio-transcription-engine deepgram --disable-audio

build-tauri:
    cd examples/apps/screenpipe-app-tauri && bun scripts/pre_build.js && bun tauri build

dev-tauri: build
    cd examples/apps/screenpipe-app-tauri && bun scripts/pre_build.js && bun tauri dev
