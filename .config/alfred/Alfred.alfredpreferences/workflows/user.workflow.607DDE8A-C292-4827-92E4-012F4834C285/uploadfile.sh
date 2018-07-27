#!/bin/bash

readonly progress_file='/tmp/uploadfile_progress'
readonly name_file='/tmp/uploadfile_name' # for `ufp` (in Alfred)

function notification {
  ./_licensed/terminal-notifier/terminal-notifier.app/Contents/MacOS/terminal-notifier -title "${alfred_workflow_name}" -message "${1}"
}

function ascii_basename {
  basename "${1}" | sed -e 's/[^a-zA-Z0-9._-]/-/g'
}

function transfer {
  local tmp_dir tmp_zip_dir given_file dir_name zip_file file_path file_name

  # If acting on multiple files, frist copy them to a directory
  if [[ "${#}" -gt 1 ]]; then
    readonly tmp_dir_multi="$(mktemp -d)"
    readonly tmp_zip_dir="${tmp_dir_multi}/archive"
    mkdir "${tmp_zip_dir}"
    cp -R "${@}" "${tmp_zip_dir}"
    readonly given_file="${tmp_zip_dir}"
  else
    readonly given_file="${1}"
  fi

  # Make zip if acting on a directory
  if [[ -d "${given_file}" ]]; then
    readonly tmp_dir="$(mktemp -d)"
    readonly dir_name="$(ascii_basename "${given_file}")"
    readonly zip_file="${tmp_dir}/${dir_name}.zip"
    ditto -ck "${given_file}" "${zip_file}"
    readonly file_path="${zip_file}"
  else
    readonly file_path="${given_file}"
  fi

  readonly file_name=$(ascii_basename "${file_path}")
  echo -n "${file_name}" > "${name_file}"
  notification "Uploading “${file_name}”"

  # Upload and copy url to clipboard
  curl --globoff --progress-bar --upload-file "${file_path}" "https://transfer.sh/${file_name}" 2> "${progress_file}" | tr -d '\n' | pbcopy

  # Play sound and show message
  afplay /System/Library/Sounds/Ping.aiff
  notification "Uploaded “${file_name}”"
}

function kill_transfer {
  local file_name parent_process oldest_child_process

  readonly file_name="$(cat "${name_file}")"

  # Kill parent to prevent notification showing success and child to stop upload
  readonly parent_process="$(pgrep -f 'bash uploadfile.sh upload')"
  readonly oldest_child_process="$(pgrep -oP "${parent_process}")"
  kill "${parent_process}" "${oldest_child_process}"

  # Play sound and show message
  afplay /System/Library/Sounds/Funk.aiff
  notification 'Upload canceled'
}

if [[ "${1}" == 'upload' ]]; then
  shift
  transfer "${@}"
elif [[ "${1}" == 'abort' ]]; then
  kill_transfer
else
  echo 'A wrong option was given.'
  exit 1
fi

# Delete temporary files
rm "${progress_file}" "${name_file}"
