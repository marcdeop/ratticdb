node 'jessie.example.org' {
  class { '::ratticdb':
    url => 'jessie.example.org'
  }
}

node 'trusty.example.org' {
  class { '::ratticdb':
    url => 'trusty.example.org'
  }
}

node 'xenial.example.org' {
  class { '::ratticdb':
    url => 'xenial.example.org'
  }
}

node 'centos6.example.org' {
  class { '::ratticdb':
    url => 'centos6.example.org'
  }
}

node 'centos7.example.org' {
  class { '::ratticdb':
    url => 'centos7.example.org'
  }
}

node 'default' {
  class { '::ratticdb':
    version => '1.3.1'
  }
}

