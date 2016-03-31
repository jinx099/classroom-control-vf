class nginx::params {
  case $::osfamily {
    'RedHat': {
       $nginx_user    = 'nginx'
       $nginx_pkg     = 'nginx'
       $nginx_svc     = 'nginx'
       $nginx_conf    = 'nginx.conf'
       $nginx_confdir = '/etc/nginx'
       #$nginx_docroot = '/var/www/html'
       $nginx_server_block = '/etc/nginx/conf.d'
       $nginx_logs  = '/var/log/nginx'
    }
    'Debian': {
       $nginx_user    = 'www-data'
       $nginx_pkg     = 'nginx'
       $nginx_svc     = 'nginx'
       $nginx_conf    = 'nginx.conf'
       $nginx_confdir = '/etc/nginxf'
       #$nginx_docroot = '/var/www'
       $nginx_server_block = '/etc/nginx/conf.d'
       $nginx_logs  = '/var/log/nginx'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::osfamily}")
    }
  }
}
