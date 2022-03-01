class { 'keystone::db':
  database_connection => 'mysql://keystone:keystone@127.0.0.1/keystone',
}

class { 'keystone':
  debug               => true,
  enabled             => true,
  # helper for using domains
  using_domain_config => true
}

# Ensure this matches what is in LDAP or keystone will try to recreate
# the admin user
class { 'keystone::bootstrap':
  password => 'ChangeMe',
}

keystone_domain { 'domain_2': ensure => present }

keystone::ldap_backend { 'Default':
  url                          => 'ldap://ldap.example.com:389',
  user                         => 'uid=bind,cn=users,cn=accounts,dc=example,dc=com',
  password                     => 'SecretPass',
  suffix                       => 'dc=example,dc=com',
  query_scope                  => 'sub',
  user_tree_dn                 => 'cn=users,cn=accounts,dc=example,dc=com',
  user_id_attribute            => 'uid',
  user_name_attribute          => 'uid',
  user_mail_attribute          => 'mail',
  user_enabled_emulation       => 'True',
  user_enabled_emulation_dn    => 'cn=openstack-enabled,cn=groups,cn=accounts,dc=example,dc=com',
  group_tree_dn                => 'ou=groups,ou=openstack,dc=example,dc=com',
  group_objectclass            => 'organizationalRole',
  group_id_attribute           => 'cn',
  group_name_attribute         => 'cn',
  group_member_attribute       => 'RoleOccupant',
  group_desc_attribute         => 'description',
  project_tree_dn              => 'ou=projects,ou=openstack,dc=example,dc=com',
  project_objectclass          => 'organizationalUnit',
  project_id_attribute         => 'ou',
  project_member_attribute     => 'member',
  project_name_attribute       => 'ou',
  project_desc_attribute       => 'description',
  project_allow_create         => 'True',
  project_allow_update         => 'True',
  project_allow_delete         => 'True',
  project_enabled_emulation    => 'True',
  project_enabled_emulation_dn => 'cn=enabled,ou=openstack,dc=example,dc=com',
  role_tree_dn                 => 'ou=roles,ou=openstack,dc=example,dc=com',
  role_objectclass             => 'organizationalRole',
  role_id_attribute            => 'cn',
  role_name_attribute          => 'cn',
  role_member_attribute        => 'roleOccupant',
  role_allow_create            => 'True',
  role_allow_update            => 'True',
  role_allow_delete            => 'True',
  identity_driver              => 'ldap',
  chase_referrals              => 'False',
  use_tls                      => 'True',
  tls_cacertfile               => '/etc/ssl/certs/ca-certificates.crt',
  tls_req_cert                 => 'demand',
  use_pool                     => 'True',
  use_auth_pool                => 'True',
  pool_size                    => 5,
  auth_pool_size               => 5,
  pool_retry_max               => 3,
  pool_connection_timeout      => 120,
}

keystone::ldap_backend { 'domain_2':
  url                          => 'ldap://ldap.example_2.com:389',
  user                         => 'uid=bind,cn=users,cn=accounts,dc=example_2,dc=com',
  password                     => 'SecretPass',
  suffix                       => 'dc=example_2,dc=com',
  query_scope                  => 'sub',
  user_tree_dn                 => 'cn=users,cn=accounts,dc=example_2,dc=com',
  user_id_attribute            => 'uid',
  user_name_attribute          => 'uid',
  user_mail_attribute          => 'mail',
  user_enabled_emulation       => 'True',
  user_enabled_emulation_dn    => 'cn=openstack-enabled,cn=groups,cn=accounts,dc=example_2,dc=com',
  group_tree_dn                => 'ou=groups,ou=openstack,dc=example_2,dc=com',
  group_objectclass            => 'organizationalRole',
  group_id_attribute           => 'cn',
  group_name_attribute         => 'cn',
  group_member_attribute       => 'RoleOccupant',
  group_desc_attribute         => 'description',
  project_tree_dn              => 'ou=projects,ou=openstack,dc=example_2,dc=com',
  project_objectclass          => 'organizationalUnit',
  project_id_attribute         => 'ou',
  project_member_attribute     => 'member',
  project_name_attribute       => 'ou',
  project_desc_attribute       => 'description',
  project_allow_create         => 'True',
  project_allow_update         => 'True',
  project_allow_delete         => 'True',
  project_enabled_emulation    => 'True',
  project_enabled_emulation_dn => 'cn=enabled,ou=openstack,dc=example_2,dc=com',
  role_tree_dn                 => 'ou=roles,ou=openstack,dc=example_2,dc=com',
  role_objectclass             => 'organizationalRole',
  role_id_attribute            => 'cn',
  role_name_attribute          => 'cn',
  role_member_attribute        => 'roleOccupant',
  role_allow_create            => 'True',
  role_allow_update            => 'True',
  role_allow_delete            => 'True',
  identity_driver              => 'ldap',
  chase_referrals              => 'False',
  use_tls                      => 'True',
  tls_cacertfile               => '/etc/ssl/certs/ca-certificates.crt',
  tls_req_cert                 => 'demand',
  use_pool                     => 'True',
  use_auth_pool                => 'True',
  pool_size                    => 5,
  auth_pool_size               => 5,
  pool_retry_max               => 3,
  pool_connection_timeout      => 120,
}
