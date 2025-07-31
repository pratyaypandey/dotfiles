# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Add Rust's Cargo to PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Add Ruby to PATH
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Add TeX (LaTeX distribution) to PATH
export PATH="/Library/TeX/texbin:$PATH"
export PATH="/Users/pratyay/.local/bin:$PATH"

eval $(thefuck --alias)

[ -f "/Users/pratyay/.ghcup/env" ] && . "/Users/pratyay/.ghcup/env" # ghcup-env

# Custom LaTeX compilation command
function ltxc() {
  local path="."
  local rename=""
  local watch=false
  while [[ $# -gt 0 ]]; do
    case $1 in
      -p)
        path="$2"
        shift 2
        ;;
      -r)
        rename="$2"
        shift 2
        ;;
      -w)
        watch=true
        shift
        ;;
      -*)
        echo "Unknown option: $1"
        return 1
        ;;
      *)
        texfile="$1"
        shift
        ;;
    esac
  done
  if [[ -z "$texfile" ]]; then
    echo "Usage: ltxc <file.tex> [-p output_path] [-r new_name] [-w (watch mode)]"
    return 1
  fi
  if [[ ! -f "$texfile" ]]; then
    echo "File $texfile does not exist."
    return 1
  fi
  local base="${texfile%.tex}"
  local output_pdf="${rename:-$base}.pdf"
  local full_output_path="$path/$output_pdf"
  
  /bin/mkdir -p "$path"
  
  if $watch; then
    echo "Watching and compiling $texfile..."
    /usr/bin/open -a Skim "$full_output_path" 2>/dev/null || true
    PATH="/Library/TeX/texbin:/usr/bin:/bin" /usr/bin/perl /Library/TeX/texbin/latexmk -pdf -pvc -interaction=nonstopmode -output-directory="$path" "$texfile"
  else
    echo "Compiling $texfile..."
    PATH="/Library/TeX/texbin:/usr/bin:/bin" /usr/bin/perl /Library/TeX/texbin/latexmk -pdf -interaction=nonstopmode -output-directory="$path" "$texfile"
    
    if [[ "$rename" != "" && "$rename" != "$base" ]]; then
      if [[ -f "$path/$base.pdf" ]]; then
        if [[ -f "$full_output_path" ]]; then
          echo "Removing existing $full_output_path..."
          /bin/rm -f "$full_output_path"
        fi
        /bin/mv "$path/$base.pdf" "$full_output_path"
      else
        echo "Error: $path/$base.pdf was not created by latexmk"
        return 1
      fi
    fi
    
    echo "Opening $full_output_path in Skim..."
    /usr/bin/open -a Skim "$full_output_path" 2>/dev/null || echo "Could not open Skim"
    
    echo "Cleaning up auxiliary files..."
    /bin/rm -f "$path/$base".{aux,log,fls,fdb_latexmk,synctex.gz,toc,out,bbl,blg}
    echo "Done!"
  fi
}


# Zoxide - smart directory jumper
eval "$(/opt/homebrew/bin/zoxide init zsh)"
