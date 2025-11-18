<h1 align="center">🇪🇸 TrustLAMP – Instalador LAMP automático en Bash<br>🇬🇧 TrustLAMP – Automated LAMP Installer in Bash</h1>

---

**ES:** TrustLAMP es un script en Bash que instala y configura automáticamente un entorno **LAMP** (Linux, Apache, MariaDB, PHP y UFW) en sistemas basados en Debian/Ubuntu.  
**EN:** TrustLAMP is a Bash script that automatically installs and configures a **LAMP** stack (Linux, Apache, MariaDB, PHP and UFW) on Debian/Ubuntu-based systems.

**ES:** Diseñado como herramienta de aprendizaje y como instalador rápido para entornos de desarrollo.  
**EN:** Designed as a learning tool and a fast installer for development environments.

---

## 🇪🇸 Características  
## 🇬🇧 Features

### ES
- ✔ Comprobación de ejecución como `root` o `sudo`  
- ✔ Actualización del sistema (`apt-get update && upgrade`)  
- ✔ Instalación automática de Apache, MariaDB y PHP  
- ✔ Configuración automática de VirtualHost  
- ✔ Creación del directorio `/var/www/<dominio>`  
- ✔ Generación de `index.php` con `phpinfo()`  
- ✔ Creación del archivo `.conf` en Apache  
- ✔ Activación del sitio y recarga de Apache  
- ✔ Configuración de UFW (OpenSSH + Apache Full)  
- ✔ Logs con color (`[INFO]`, `[OK]`, `[ERROR]`)  

### EN
- ✔ Checks execution as `root` or `sudo`  
- ✔ System update (`apt-get update && upgrade`)  
- ✔ Automatic installation of Apache, MariaDB and PHP  
- ✔ Automatic VirtualHost configuration  
- ✔ Creates `/var/www/<domain>`  
- ✔ Generates an `index.php` with `phpinfo()`  
- ✔ Creates the Apache `.conf` file  
- ✔ Enables the site and reloads Apache  
- ✔ UFW configuration (OpenSSH + Apache Full)  
- ✔ Colored logs (`[INFO]`, `[OK]`, `[ERROR]`)  

---

## 🇪🇸 Requisitos  
## 🇬🇧 Requirements

### ES
- Sistema Debian/Ubuntu  
- `bash` instalado  
- Permisos `sudo`  

### EN
- Debian/Ubuntu-based system  
- `bash` installed  
- `sudo` privileges  

---

## 🇪🇸 Uso  
## 🇬🇧 Usage

### 1. Clonar el repositorio / Clone the repository

```bash
git clone https://github.com/tuusuario/trustlamp.git
cd trustlamp_
