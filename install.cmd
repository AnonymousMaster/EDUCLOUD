REM script para instalar free_globoschool en windows
@Echo off

copy libmySQL.dll \ruby187\bin /y

REM Instalar Rails 2.3.5
echo Instalando Rails 2.3.5. Por favor espere.

cd %USERPROFILE%
call gem install rake -v=0.9.2.2

call gem install rails -v=2.3.5 --remote
cd \free_globoschool
REM Instalar las otras gemas necesarias
echo Instalando el resto de las gemas requeridas. Tenga paciencia

call gem install mysql -v=2.8.1

call gem install declarative_authorization -v0.5.1
call gem install searchlogic -v2.4.27 --ignore-dependencies
call gem install i18n -v0.4.2
call gem install win32-open3
call gem install rush -v=0.6.7
call gem install fastercsv
rem call gem uninstall rake -Iqx

REM crear la base de datos. Los datos de username y password en config/database.yml deben
REM corresponder con los que de MySql.
echo Creando la base de datos

call rake db:create RAILS_ENV=production

REM crear tablas de base de datos e instalar plugins
echo Creando tablas de la base de datos e instalando plugins

call rake fedena:plugins:install_all RAILS_ENV=production

REM configurar el paquete PDF
echo Configurando el paquete de PDF

copy pdf\wicked_pdf.rb config\initializers -y

echo Se ha completado la instalacion!

echo Para iniciar la aplicacion. Ejecute: ruby script/server -e production


