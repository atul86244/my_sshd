# copyright: 2018, The Authors

title "my custom sshd profile"

# you add controls here
control "sshd-1" do
  impact 1.0
  title "Specify protocol version 2"
  desc "Only SSH protocol version 2 connections should be permitted. Version 1 of the protocol contains security vulnerabilities."
  describe sshd_config do
    its('Protocol') { should eq('2') }
  end
end

control "sshd-2" do
  impact 1.0
  title "Check sshd config file owner, group and permissions"
  desc "sshd config file should be owned by root, writable and readable by root but not executable"
  describe file('/etc/ssh/sshd_config') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root'}
    it { should_not be_executable }
    it { should be_readable.by('owner') }
    it { should be_writable.by('owner') }
  end
end

control "sshd-3" do
  impact 1.0
  title "Enable StrictModes"
  desc "Insecure home directories and key file permissions are not allowed"
  describe sshd_config do
    its('StrictModes') { should eq('yes') }
  end
end

control "sshd-4" do
  impact 1.0
  title "VERBOSE Loglevel"
  desc "Set the log level to VERBOSE for troubleshooting"
  describe sshd_config do
    its('LogLevel') { should eq('VERBOSE') }
  end
end

control "sshd-5" do
  impact 1.0
  title "Max Sessions"
  desc "Set the max number of open sessions per network to avoid DoS"
  describe sshd_config do
    its('MaxSessions') { should eq('10') }
  end
end

control "sshd-6" do
  impact 1.0
  title "Disable password based authentication"
  desc "Password based authentication should not be allowed"
  describe sshd_config do
    its('PasswordAuthentication') { should eq('no') }
  end
end

control "sshd-7" do
  impact 1.0
  title "Disable root login"
  desc "Do not allow login with the root user"
  describe sshd_config do
    its('PermitRootLogin') { should eq('no') }
  end
end
