describe docker_container('vaultenterprise_consul-enterprise0_1') do
  it { should exist }
  it { should be_running }
end

describe docker_container('vaultenterprise_consul-enterprise1_1') do
  it { should exist }
  it { should be_running }
end

describe docker_container('vaultenterprise_consul-enterprise2_1') do
  it { should exist }
  it { should be_running }
end

describe docker_container('vaultenterprise_vault-enterprise0_1') do
  it { should exist }
  it { should be_running }
end

describe docker_container('vaultenterprise_vault-enterprise1_1') do
  it { should exist }
  it { should be_running }
end

describe docker_container('vaultenterprise_vault-enterprise2_1') do
  it { should exist }
  it { should be_running }
end
