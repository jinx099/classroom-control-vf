class nginx (
  $nginx_user = $nginx::params::nginx_user, 
  $nginx_pkg = $nginx::params::nginx_pkg,
  $nginx_svc = $nginx::params::nginx_svc,
  $nginx_conf = $nginx::params::nginx_conf,
  $nginx_confdir = $nginx::params::nginx_confdir,
  $nginx_docroot = $nginx::params::nginx_docroot,
  $nginx_server_block = $nginx::params::nginx_server_block,
  $nginx_logs = $nginx::params::nginx_logs,
) inherits nginx::params {

  $nginx_conf_dir = '/etc/nginx/conf.d'
  $doc_root = $nginx_docroot

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  package { 'nginx':
    ensure => present,
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    #source  => 'puppet:///modules/nginx/nginx.conf',
    content => template('nginx/nginx.conf.erb'),
    require => Package['nginx'],
  }
  
  file { "${nginx_conf_dir}/default.conf":
    ensure  => file,
    #source  => 'puppet:///modules/nginx/default.conf',
    content => template('nginx/default.conf.erb'),
    require => Package['nginx']
  }
  
  file { "${doc_root}/index.html":
    ensure  => file,
    #source  => 'puppet:///modules/nginx/index.html',
    content => template('nginx/index.html.erb'),
  }
  
#  file { [ "${nginx_conf_dir}", "${doc_root}" ]:
#    ensure  =>  directory,
#  }

#  file { [ '/etc/nginx/conf.d', '/var/www' ]:
#    ensure  =>  directory,
#  }

  file { $doc_root:
    ensure  =>  directory,
  }
  
  file { '/etc/nginx/conf.d':
    ensure  =>  directory,
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [ File['/etc/nginx/nginx.conf'], File["${nginx_conf_dir}/default.conf"], ],
  }
}
