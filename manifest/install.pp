class ciemat_utils::install {

    package {['rsync','vim-enhanced']:
        ensure => present,
        before => Package['ciemat-utils'],
    }

    file {'/root/packages':
        ensure => directory,
        owner => 'root',
        group => 'root',
        mode => '0644',
        before => File['/root/packages/ciemat-utils.rpm']
    }

#    rsync::get {'/root/packages/ciemat-utils.rpm':
#        source => 'rsync://lcg01/glite/utils/DISTRIB/prod/',
#        include => "ciemat-utils*noarch.rpm",
#        require => File['/root/packages/'],
#        notify => Package['ciemat-utils'],
#   }

    file {'/root/packages/ciemat-utils.rpm':
        ensure => present,
        links => follow,
        replace => true,
        source => 'puppet:///modules/ciemat_utils/ciemat-utils-latest',
        source_permissions => use,
        notify => Package['ciemat-utils'],
    }

    package {'ciemat-utils':
        ensure => present,
        provider => rpm,
        source => '/root/packages/ciemat-utils.rpm',
        reinstall_on_refresh => true,
    }
}
