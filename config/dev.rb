##############################################################################################
# This configuration file overrides the configuration values based on the current environment
# this file is loaded when the environment variable PIPELINE_ENV is dev
##############################################################################################

##############################################################################################
# APPLICATION DEPLOYMENT
##############################################################################################

# What input variables should be passed to the :myapp sub-project?
#
#  - HCAP DevSecOps allows you to dynamically define the values of input variables,
#    based on any logic that you can define using Ruby.
set :capitacommon_vars do
#   ^^
#   By using a "do" "end" block, HCAP DevSecOps allows you to "lazily" declare the values of
#   input variables, so that they are not calculated until the exact time that they are needed.
  {
    # myvar: env!('MYVAR'),
    #                 ^^^
    #                 HCAP DevSecOps allows you to explicitly throw an error when a required
    #                 environment variable does not exist.
    environment: fetch(:pipeline_env),
    project: fetch(:application),
    prefix: "#{fetch(:pipeline_env)}-#{fetch(:application)}",
    expiration_date: (Time.now + 86_400 * 7).strftime('%Y-%m-%d'),
    "cosmos": {
  "evidential": {
    name: "docstore",
    offer_type: "Standard",
    kind: "GlobalDocumentDB",
    automatic_failover: true,
    failover_location: "ukwest",
    consistency_level: "ConsistentPrefix",
    "ip_range_filter": ""
  }
},
"configcosmos": {
   "evidential": {
     "name": "configstore",
     offer_type: "Standard",
     kind: "GlobalDocumentDB",
     automatic_failover: true,
     failover_location: "ukwest",
     consistency_level: "Strong",
     "ip_range_filter": ""
   }
 }

    #                ^^^
    #                You can write expressions in ruby to dynamically calculate layer inputs,
    #                such as:  how many days before my deployed infrastructure expires?
  }
end

set :capitaapi_vars do
#   ^^
#   By using a "do" "end" block, HCAP DevSecOps allows you to "lazily" declare the values of
#   input variables, so that they are not calculated until the exact time that they are needed.
  {
    # myvar: env!('MYVAR'),
    #                 ^^^
    #                 HCAP DevSecOps allows you to explicitly throw an error when a required
    #                 environment variable does not exist.
    environment: fetch(:pipeline_env),
    project: fetch(:application),
    prefix: "#{fetch(:pipeline_env)}-#{fetch(:application)}",
    expiration_date: (Time.now + 86_400 * 7).strftime('%Y-%m-%d'),
    "owner": "hcap.azure.service.user",
    "product": "hcap",
    "clientName": "capita",
    "adapp": "evidential",
    "key": "evidential",
    "app_environmentid": "",
    "container_name": "evidential2",
    "access_tier": "Standard",
    "replication": "GRS",
    "tier": "Standard",
    "size": "S1",
    "queuename": "evidentialqueue",
    "cosmoskey": "evidential1",
    "failover_location": "ukwest",
    "offertype": "Standard",
    "consistency_level": "Strong",
    "integer": "1200",
    "location": "uksouth"
    #                ^^^
    #                You can write expressions in ruby to dynamically calculate layer inputs,
    #                such as:  how many days before my deployed infrastructure expires?
  }
end

set :capitapurge_vars do
#   ^^
#   By using a "do" "end" block, HCAP DevSecOps allows you to "lazily" declare the values of
#   input variables, so that they are not calculated until the exact time that they are needed.
  {
    # myvar: env!('MYVAR'),
    #                 ^^^
    #                 HCAP DevSecOps allows you to explicitly throw an error when a required
    #                 environment variable does not exist.
    environment: fetch(:pipeline_env),
    project: fetch(:application),
    prefix: "#{fetch(:pipeline_env)}-#{fetch(:application)}",
    expiration_date: (Time.now + 86_400 * 7).strftime('%Y-%m-%d'),
    location: "uksouth",
    access_tier: "Standard"
    #                ^^^
    #                You can write expressions in ruby to dynamically calculate layer inputs,
    #                such as:  how many days before my deployed infrastructure expires?
  }
end

set :capitaad_vars do
#   ^^
#   By using a "do" "end" block, HCAP DevSecOps allows you to "lazily" declare the values of
#   input variables, so that they are not calculated until the exact time that they are needed.
  {
    # myvar: env!('MYVAR'),
    #                 ^^^
    #                 HCAP DevSecOps allows you to explicitly throw an error when a required
    #                 environment variable does not exist.
    environment: fetch(:pipeline_env),
    project: fetch(:application),
    prefix: "#{fetch(:pipeline_env)}-#{fetch(:application)}",
    expiration_date: (Time.now + 86_400 * 7).strftime('%Y-%m-%d'),
    location: "uksouth",
    access_tier: "Standard",

}
    #                ^^^
    #                You can write expressions in ruby to dynamically calculate layer inputs,
    #                such as:  how many days before my deployed infrastructure expires?

end
# Declare the HCAP Deploy deployment name for the application sub-project named :myapp
set :capitacommon_dep_name, 'development'
set :capitaapi_dep_name, 'development'
set :capitapurge_dep_name, 'development'
set :capitaad_dep_name, 'development'

# Declare HCAP Deploy deployment configuration for the application sub-project named :myapp
#
#  - HCAP DevSecOps allows you to dynamically define the values of deployment configuration,
#    based on any logic that you can define using Ruby.
#  - HCAP DevSecOps allows you to "lazily" declare the values of deployment configuration,
#    so that they are not calculated until the exact time that they are needed.
set :capitacommon_deploy_config do
  {
    deployment_name: fetch(:capitacommon_dep_name),
    deployment_description: 'capitacommon - development',
    input_json_file: fetch(:capitacommon_inputs_file),
  }
end

set :capitaapi_deploy_config do
  {
    deployment_name: fetch(:capitaapi_dep_name),
    deployment_description: 'capitaapi - development'
  }
end

set :capitapurge_deploy_config do
  {
    deployment_name: fetch(:capitapurge_dep_name),
    deployment_description: 'capitapurge - development'
  }
end


set :capitaad_deploy_config do
  {
    deployment_name: fetch(:capitaad_dep_name),
    deployment_description: 'capitaad - development'
  }
end

set :functional_tests, [
  {
    command_to_run_test: "mvn test -Dtest=\"APIRunner\" -Denv=\"dev\" -Dtoken=\"hcp N2FiZmM0MGQtMzZjMC00Y2YwLTg3NjQtMGVmOGNjODQyODA1:d183QmYlMjRrV3IlN2J0dDEpNVlqJTIzOFB6dVIlMjNUXy1fJTIzVG1T\" -Dcontainer=\"evidential\" -Dmethod=\"header\"",
    git_repository_url: "https://github.com/reancloud/capita-automation-Framework",
    git_branch: "CAPHCP-188-create_framework",
    pre_script: "cd capita-API_UI_tests",
    post_script: "mv target/surefire-reports/* target/cucumber-html-reports",
    report_file_name: "TESTAPI-tests.APIRunner.xml" ,
    output_directory_path: "capita-API_UI_tests/target/cucumber-html-reports" ,
    chrome: 72
  }
]

set :infra_test_tool, :none

##############################################################################################
# INFRASTRUCTURE VALIDATION
##############################################################################################

# OPTIONAL:  You can dynamically declare infratest expected value JSON for the myapp sub-project.
#
#  - By default, HCAP DevSecOps will automatically try to load your expected value JSON
#    from a file named testplan/dev/app/myapp/expected.json
#  - Instead, you can dynamically assign the expected value JSON by uncommenting the line below
#    and populating the ruby hash.
#  - Optionally, you can also explicitly supply a file name using the configuration setting below,
#    by replacing the ruby hash with a string.
# set :myapp_infratest_expected, {}

# OPTIONAL:  You can dynamically declare infratest resource ID JSON for the myapp sub-project.
#
#  - By default, if you use HCAP Deploy, HCAP DevSecOps will ask the HCAP Platform CLI to
#    automatically retrieve resource ID JSON from your HCAP Deploy layer.
#  - Otherwise, HCAP DevSecOps will automatically try to load your resource ID JSON
#    from a file named testplan/dev/app/myapp/resourde_ids.json
#  - Instead, you can dynamically assign the expected value JSON by uncommenting the line below
#    and populating the ruby hash.
#  - Optionally, you can also explicitly supply a file name using the configuration setting below,
#    by replacing the ruby hash with a string.
# set :myapp_infratest_resource_ids, {}

# OPTIONAL:  You can customize the HCAP Test job name for myapp sub-project.
#
#  - By default, HCAP DevSecOps will use a job name of "dev-[PROJECTNAME]-[LAYERNAME]"
# set :myapp_infratest_name, 'dev-joe-demo-myapp'
