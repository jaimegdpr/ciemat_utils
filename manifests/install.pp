class ciemat_utils::install {

    require ciemat_tweaks::folders

    package {['rsync','vim-enhanced']:
        ensure => present,
        before => Package['ciemat-utils'],
    }

    # We use a symlink that points to the last version of the rpm.
    # When the rpm is updated, the file is redownloaded and package resource is notified.
    # to reintall it
    file {'/root/packages/ciemat-utils.rpm':
        ensure => present,
        links => follow,
        replace => true,
        source => 'puppet:///grid_files/ciemat_utils/ciemat-utils-latest',
        owner => 'root',
        group => 'root',
        notify => Package['ciemat-utils'],
    }

    package {'ciemat-utils':
        ensure => present,
        provider => rpm,
        source => '/root/packages/ciemat-utils.rpm',
        reinstall_on_refresh => true,
    }

}
