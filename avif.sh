find . -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) -exec bash -c '
    input_file="$1"
    output_file="${input_file%.*}.avif"
    
    echo "Converting $input_file..."
    # Run the ImageMagick conversion
    magick "$input_file" -quality 80 -define avif:speed=6 "$output_file"
    
    # Check if the conversion was successful (output file exists and is not empty)
    if [ -s "$output_file" ]; then
        echo "Success. Deleting original: $input_file"
        rm "$input_file"
    else
        echo "Failure or empty file created for $input_file. Keeping original."
        # Optional: remove the potentially failed output file
        # rm "$output_file" 
    fi
' sh {} \;
