#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Github PR Markdown URL
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName GitHub
# @raycast.icon images/github-logo.png
# @raycast.iconDark images/github-logo-iconDark.png


# Function to convert GitHub PR URL to markdown format
github_url_to_markdown() {
    local url="$1"
    
    # Check if URL matches GitHub PR pattern and extract PR number
    if [[ $url =~ ^https://github\.com/[^/]+/(.*)/pull/([0-9]+)$ ]]; then
        pr_number="${BASH_REMATCH[2]}"
        repo="${BASH_REMATCH[1]}"
        echo "[$repo/$pr_number]($url)"
    else
        echo "invalid url"
    fi
}

# Main script
main() {
    # Detect operating system and read from clipboard
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        clipboard_content=$(pbpaste)
    elif [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "linux"* ]]; then
        # Linux (requires xclip)
        if command -v xclip &> /dev/null; then
            clipboard_content=$(xclip -selection clipboard -o)
        else
            echo "Error: xclip is required on Linux. Install with: sudo apt install xclip"
            exit 1
        fi
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
        # Windows (Git Bash/Cygwin/WSL)
        clipboard_content=$(powershell.exe -command "Get-Clipboard" | tr -d '\r')
    else
        echo "Unsupported operating system: $OSTYPE"
        exit 1
    fi
    
    # Convert to markdown
    result=$(github_url_to_markdown "$clipboard_content")
    # echo "$result"
    
    # Copy result back to clipboard if valid
    if [[ "$result" != "invalid url" ]]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "$result" | pbcopy
        elif [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "linux"* ]]; then
            echo "$result" | xclip -selection clipboard
        elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
            echo "$result" | clip.exe
        fi
    fi
}

# Run main function
main

# Test examples (uncomment to see manual testing)
# echo
# echo "Manual testing examples:"
# echo "Input: https://github.com/deliveryhero/pd-pablo-payment-gateway/pull/7599"
# echo "Output: $(github_url_to_markdown "https://github.com/deliveryhero/pd-pablo-payment-gateway/pull/7599")"
# echo
# echo "Testing invalid URLs:"
# echo "Input: https://google.com"
# echo "Output: $(github_url_to_markdown "https://google.com")"
# echo "Input: https://github.com/user/repo"
# echo "Output: $(github_url_to_markdown "https://github.com/user/repo")"
