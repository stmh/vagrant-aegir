node 'aegir.local' {

#  include git
#  include grunt
#  include phpmyadmin
  include apt
#  THIS SHOULD ONLY BE RUN AFTER AEGIR IS INSTALLED AND NFS IS ENABLED
#  include drupal
  include vim

  package { 'git':
    ensure => present,
  }

#  package { 'jenkins':
#    ensure => present,
#  }

  class { 'drush::git::drush':
    require => Package['git'],
  }

  class { 'aegir::dev' :
    hostmaster_ref => '6.x-2.x',
    provision_ref  => '6.x-2.x',
    platform_path  => '/var/aegir/hostmaster-6.x-2.x',
    require        => Class['drush::git::drush'],
  }
}

  # This is in the defaults that is included in aegir::platform...
  # I'm not sure why it isn't inherited properly from there.
  Drush::Run {
    site_alias => '@hostmaster',
    drush_user => 'aegir',
    drush_home => '/var/aegir',
    log        => '/var/aegir/drush.log',
  }

  #aegir::platform {'Drupal7':
  #  makefile => '/vagrant/drupal_core.make',
  #}
