# install our source drivers package for Symantec
node['antivirus']['drivers']['packages'].each do |pkg,ver|
  package pkg do
    if ver == "latest"
      action :upgrade
    elsif ver == "install"
      action :install
    else
      action ver
    end
    ignore_failure true
  end
end



# Check to see if we recently updated the kernel and if so rebuild the kernel drivers


bash "check-if-symantec-malfunctioning" do
  code <<-EOH
SYMANTEC_STATUS=`/opt/Symantec/symantec_antivirus/sav info -a`

if [[ "$SYMANTEC_STATUS" = "Malfunctioning" ]]; then
  cd /opt/Symantec/driver/#{node['antivirus']['drivers']['kern_module']}
  ./build.sh
fi
  EOH
   action :run
 end