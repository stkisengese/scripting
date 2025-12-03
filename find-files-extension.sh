find . -type f -name "*.txt" | while read -r file; do
    basename "$file" .txt
done

# alternatively
# find . -type f -name "*.txt" -exec basename {} .txt \;