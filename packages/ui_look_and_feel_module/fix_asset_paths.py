import os

def fix_asset_paths(file_path, package_name):
  with open(file_path, 'r') as file:
    lines = file.readlines()

  with open(file_path, 'w') as file:
    for line in lines:
      if "AssetGenImage" in line and "const AssetGenImage" in line:
        parts = line.split("'")
        if len(parts) > 1 and parts[1].startswith('assets/'):
          parts[1] = f"packages/{package_name}/" + parts[1]
          line = "'".join(parts)
      file.write(line)

if __name__ == "__main__":
  package_name = "ui_look_and_feel_module"
  gen_file_path = "lib/gen/assets.gen.dart"

  if os.path.exists(gen_file_path):
    fix_asset_paths(gen_file_path, package_name)
  else:
    print(f"{gen_file_path} does not exist.")