# Install core packages
node['antivirus']['symantec']['packages'].each do |pkg,ver|
  package pkg do
    if ver == "latest"
      action :upgrade
    elsif ver == "install"
      action :install
    end
    ignore_failure true
  end
end


if node['platform_family'] == 'rhel'
  node['antivirus']['symantec']['pkg_groups'].each do |pkg,ver|
    yumgroup pkg do
      if ver == "latest"
        action :upgrade
      elsif ver == "install"
        action :install
      end
      ignore_failure true
    end
  end
end

# Install Symantec specific packages
node['antivirus']['symantec']['packages'].each do |pkg,ver|
  package pkg do
    if ver == "latest"
      action :upgrade
    elsif ver == "install"
      action :install
    end
    ignore_failure true
  end
end


execute "download_symantec" do
  user "root"
  cwd"#{node['antivirus']['symantec']['download_dir']}"
  command "wget #{node['antivirus']['symantec']['install_url']}/#{node['antivirus']['symantec']['install_pkg']}"
  not_if { ::File.exist?( "#{node['antivirus']['symantec']['download_dir']}/#{node['antivirus']['symantec']['install_pkg']}") }
  notifies :run, "execute[uninstall_old_symantec]", :immediately
  notifies :run, "execute[unzip_symantec_client]", :immediately
end

execute "uninstall_old_symantec" do
  command "yes | /opt/Symantec/symantec_antivirus/uninstall.sh"
  action :nothing
  only_if { ::File.exist?( "/opt/Symantec") }
  #notifies :run, "execute[unzip_symantec_client]", :immediately
end


execute "unzip_symantec_client" do
  cwd "#{node['antivirus']['symantec']['download_dir']}"
  command "unzip #{node['antivirus']['symantec']['install_pkg']} -d sepinstall"
  action :nothing
end

execute "chmod_symantec_client" do
  cwd "#{node['antivirus']['symantec']['download_dir']}"
  command "chmod u+x #{node['antivirus']['symantec']['download_dir']}/sepinstall/install.sh"
  only_if { ::File.exist?( "#{node['antivirus']['symantec']['download_dir']}/sepinstall") }
end

execute "install_symantec_client" do
  cwd "#{node['antivirus']['symantec']['download_dir']}"
  command "#{node['antivirus']['symantec']['download_dir']}/sepinstall/install.sh -i"
  only_if { ::File.exist?( "#{node['antivirus']['symantec']['download_dir']}/sepinstall") }
end


execute "cleanup_sepinstall_dir" do
  cwd "#{node['antivirus']['symantec']['download_dir']}"
  command "rm -fr #{node['antivirus']['symantec']['download_dir']}/sepinstall"
  only_if { ::File.exist?( "#{node['antivirus']['symantec']['download_dir']}/sepinstall") }
end