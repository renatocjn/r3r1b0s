
sudo apt-get install libxrender-dev libfontconfig1-dev

/etc/apache2/envvars
```shell
# Recibos site variables
export RAILS_ENV="production"
export RACK_ENV=$RAILS_ENV
export SECRET_KEY_BASE=""
export RECIBOS_PASSWORD=""
```