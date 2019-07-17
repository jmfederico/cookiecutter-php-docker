"""Actions to be run after a successful Cookie bake."""
from urllib.request import urlopen, Request
from pathlib import Path


def run():
    """Actions to be run."""
    base_image = "{{ cookiecutter.php_image }}"

    if base_image == "alpine":
        Path("php-fpm/default.Dockerfile").unlink()
        Path("php-fpm/alpine.Dockerfile").rename(Path("php-fpm/Dockerfile"))

    if base_image == "default":
        Path("php-fpm/alpine.Dockerfile").unlink()
        Path("php-fpm/default.Dockerfile").rename(Path("php-fpm/Dockerfile"))

    req = Request(
        url="https://www.gitignore.io/api/composer", headers={"User-Agent": "Python"}
    )
    Path("../.gitignore").write_bytes(urlopen(req).read())

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
        index.write_text("<?php\nphpinfo();")


run()
