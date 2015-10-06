desc 'cleans build artifacts'
task :clean do
  run_command 'rm -rf target'
end

desc 'prepares project for build'
task :prepare do
  host_os = case RUBY_PLATFORM
              when /darwin/
                'darwin'
              else
                'linux'
            end
  filename = "packer_0.8.6_#{host_os}_amd64.zip"

  unless File.exists? 'target/packer'
    run_command <<EOF
mkdir target
curl -L -o target/#{filename} https://dl.bintray.com/mitchellh/packer/#{filename}
(cd target ; unzip -U #{filename})
EOF
  end
end

namespace :packer do
  desc 'validate the packer image'
  task :validate => :prepare do
    run_command 'target/packer validate resources/packer.conf'
  end

  desc 'build the packer image'
  task :build => :validate do
    run_command 'target/packer build resources/packer.conf'
  end
end

def run_command(command)
  puts command
  system(command) || raise("unable to execute command - #{command}")
end
