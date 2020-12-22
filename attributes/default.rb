default['antivirus']['provider'] = "none"
default['antivirus']['symantec']['packages'] = case node['platform_family']
                                                          when 'debian', 'ubuntu'
                                                            {
                                                                "linux-headers" => "install",
                                                                "build-essential" => "install"
                                                            }
                                                          when 'rhel'
                                                            {
                                                                "kernel-devel" => "install",
                                                                "kernel-headers" => "install",
                                                                "glibc.i686" => "install"
                                                            }
                                                          else
                                                            {
                                                            }
                                                          end

# This should only ever be called on RPM based systems
default['antivirus']['symantec']['pkg_groups'] = case node['platform_family']
                                                            when 'rhel'
                                                              {
                                                                  "Development Tools" => "install"
                                                              }
                                                            else
                                                              {
                                                              }
                                                            end


default['antivirus']['drivers']['packages'] = case node['platform_family']
                                              when 'debian', 'ubuntu'
                                                {
                                                    "symantec-endpoint-drivers" => "install"
                                                }
                                              when 'rhel'
                                                {
                                                    "symantec-endpoint-drivers" => "install"

                                                }
                                              else
                                                {
                                                }
                                              end

default['antivirus']['drivers']['kern_module'] = "ap-kernelmodule-14.0.3876-1100"


default['antivirus']['symantec']['download_dir'] = "/root"
default['antivirus']['symantec']['install_url'] = "http://server.domain.com/symantec"
default['antivirus']['symantec']['install_pkg'] = "SymantecEndpointProtection.zip"
