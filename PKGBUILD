# Maintainer: Tu Fabio Fuentes Ramírez <fabiofuentes623@gmail.com>
pkgname=archclean
pkgver=1.0.0
pkgrel=1
pkgdesc="Arch Linux modular cache cleaner"
arch=('any')
url="https://github.com"
license=('MIT')
depends=('bash' 'pacman-contrib')
source=("archclean.sh")
sha256sums=('8bac5f85a1364921bffab2d526d7a116270e09b050a1fa635d46d2c13e06c78a')

package() {
    # Instala el script en /usr/bin/archclean con permisos de ejecución (755)
    install -Dm755 "$srcdir/archclean.sh" "$pkgdir/usr/bin/archclean"
}
