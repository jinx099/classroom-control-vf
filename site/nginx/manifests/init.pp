class nginx {

  $nginx_conf_dir = '/etc/nginx/nginx.d'
  $doc_root = '/var/www'

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
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }
  
  file { "${nginx_conf_dir}/default.conf":
    ensure  => file,
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx']
  }
  
    file { "${doc_root}/index.html":
    ensure  => file,
    source  => 'puppet:///modules/nginx/index.html',
  }
  
  file { [$nginx_conf_dir, $doc_root]:
    ensure  =>  directory,
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [ File['/etc/nginx/nginx.conf'], File["${nginx_conf_dir}/default.conf"], ],
  }
}
