#!/bin/zsh

# デフォルト値の設定
import_dir=""
export_dir=""

while getopts i:o: flag; do
    case "${flag}" in
        i) import_dir=${OPTARG} ;;
        o) export_dir=${OPTARG} ;;
        *) echo "使用法: $0 -i 入力ディレクトリ -o 出力ディレクトリ"
           exit 1 ;;
    esac
done

mkdir -p "$export_dir"

for input_file in "$import_dir"/*.mp4; do
    # $import_dirに含まれるmp4ファイルからffmpegコマンドを再帰的に実行したいため。
    [ -e "$input_file" ] || continue

    # ファイル名のみを取得 (拡張子なし)
    filename=$(basename -- "$input_file" .mp4)

    output_file="$export_dir/$filename.m4a"

    ffmpeg -i "$input_file" -vn -acodec copy "$output_file"

    echo "変換完了: $input_file → $output_file"
done

echo "すべての変換が完了しました。"
