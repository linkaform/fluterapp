#!/bin/sh

# Bootstrap packages in the project directory
melos exec -c 1  melos bs

# Generate text (asumiendo que tienes un comando para esto, reemplázalo con el comando real)
melos exec -c 1 --scope="translations_module" -- dart run intl_utils:generate

# Generate assets for ui_look_and_feel_module
melos exec -c 1 --scope="ui_look_and_feel_module" -- fluttergen

# Fix asset paths
melos exec -c 1 --scope="ui_look_and_feel_module" -- python3 fix_asset_paths.py