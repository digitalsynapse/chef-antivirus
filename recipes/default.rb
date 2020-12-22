#
# Cookbook:: chef-antivirus
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

if node['antivirus']['provider'] == "symantec"
  include_recipe "antivirus::symantec"
  include_recipe "antivirus::symantec_drivers"
end