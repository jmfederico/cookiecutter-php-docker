import os
import urllib.request

# Set choosen base PHP image
baseImage = '{{ cookiecutter.php_image }}'

if baseImage == 'alpine':
    os.remove('php-fpm/default.Dockerfile')
    os.rename('php-fpm/alpine.Dockerfile', 'php-fpm/Dockerfile')

if baseImage == 'default':
    os.remove('php-fpm/alpine.Dockerfile')
    os.rename('php-fpm/default.Dockerfile', 'php-fpm/Dockerfile')

urllib.request.urlretrieve("https://www.gitignore.io/api/composer", "../.gitignore")

for file_name in os.listdir("_root"):
    os.rename(f"_root/{file_name}", f"../{file_name}")
os.rmdir("_root")
