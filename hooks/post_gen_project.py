import urllib.request
from pathlib import Path

# Set choosen base PHP image
baseImage = "{{ cookiecutter.php_image }}"

if baseImage == "alpine":
    Path("php-fpm/default.Dockerfile").unlink()
    Path("php-fpm/alpine.Dockerfile").rename(Path("php-fpm/Dockerfile"))

if baseImage == "default":
    Path("php-fpm/alpine.Dockerfile").unlink()
    Path("php-fpm/default.Dockerfile").rename(Path("php-fpm/Dockerfile"))

urllib.request.urlretrieve(
    "https://www.gitignore.io/api/composer", Path("../.gitignore")
)

# Move root files.
_root = Path("_root")
project_root = Path("..")
for child in _root.iterdir():
    child.rename(project_root / child.name)
_root.rmdir()

# Create example index.php file for tests.
Path("../public").mkdir(exist_ok=True)
index = Path("../public/index.php")
if not index.exists():
    index.write_text(
        """
<?php

phpinfo();
"""
    )
