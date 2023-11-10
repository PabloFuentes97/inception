FROM debian:buster

RUN sudo apt install curl gnupg2 ca-certificates lsb-release debian-archive-keyring //pre-requisitos

RUN	curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null // importar signing key para que apt pueda verificar la autenticidad de los paquetes

RUN gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg  // verificar que el archivo descargado contiene la key correcta
//fingerprint tiene que ser 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62; hacer un if para ver que es la misma, si no que borre el fichero

RUN echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/debian `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list // establecer repositorio apt para paquetes estables de nginx

RUN echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | sudo tee /etc/apt/preferences.d/99nginx // establecer que el repositorio prefiera paquetes de nginx antes que los de distribuciones

RUN	apt update -y && apt upgrade -y // actualizar apt

RUN	apt install -y nginx && apt install openssl -y // instalar nginx y openssl

COPY config /etc/nginx/
CMD["script"] // comando a ejecutar, hacer un script para no sobrecargar la imagen

ENTRYPOINT


