#!/bin/bash

# Define the lines to be added
lines_to_add=$(cat <<EOF
enable = "$UMAMI_ENABLED"\nwebsiteId = "$UMAMI_WEBSITE_ID"\njsLocation = "https://cloud.umami.is/script.js"
EOF
)

# Use awk to find [params.umami] and append the lines
awk -v field="[params.umami]" -v insert_lines="$lines_to_add" '
  $0 == field {
    print $0
    print insert_lines
    next
  }
  { print $0 }
' hugo.toml > hugo.tmp && mv hugo.tmp hugo.toml
