name 'antivirus'
maintainer 'Robert Parkhurst'
maintainer_email 'raparkhurst@digitalsynapse.io'
license 'All Rights Reserved'
description 'Installs/Configures antivirus'
long_description 'Installs/Configures antivirus'
version '0.1.1'
chef_version '>= 12.14' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/antivirus/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/antivirus'


%w{ ubuntu debian rhel centos amazon }.each do |os|
  supports os
end