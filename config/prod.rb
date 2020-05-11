##############################################################################################
# This configuration file overrides the configuration values based on the current environment
# this file is loaded when the environment variable PIPELINE_ENV is prod
##############################################################################################

##############################################################################################
# APPLICATION DEPLOYMENT
##############################################################################################

# What input variables should be passed to the :myapp sub-project?
#
#  - HCAP DevSecOps allows you to dynamically define the values of input variables,
#    based on any logic that you can define using Ruby.
set :myapp_vars do
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
    expiration_date: 'Never'
  }
end

# Declare the HCAP Deploy deployment name for the application sub-project named :myapp
set :myapp_dep_name, 'production'

# Declare HCAP Deploy deployment configuration for the application sub-project named :myapp
#
#  - HCAP DevSecOps allows you to dynamically define the values of deployment configuration,
#    based on any logic that you can define using Ruby.
#  - HCAP DevSecOps allows you to "lazily" declare the values of deployment configuration,
#    so that they are not calculated until the exact time that they are needed.
set :myapp_deploy_config do
  {
    deployment_name: fetch(:myapp_dep_name),
    deployment_description: 'myapp - Production'
  }
end

##############################################################################################
# INFRASTRUCTURE VALIDATION
##############################################################################################

# OPTIONAL:  You can dynamically declare infratest expected value JSON for the myapp sub-project.
#
#  - By default, HCAP DevSecOps will automatically try to load your expected value JSON
#    from a file named testplan/prod/app/myapp/expected.json
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
#    from a file named testplan/prod/app/myapp/resourde_ids.json
#  - Instead, you can dynamically assign the expected value JSON by uncommenting the line below
#    and populating the ruby hash.
#  - Optionally, you can also explicitly supply a file name using the configuration setting below,
#    by replacing the ruby hash with a string.
# set :myapp_infratest_resource_ids, {}

# OPTIONAL:  You can customize the HCAP Test job name for myapp sub-project.
#
#  - By default, HCAP DevSecOps will use a job name of "prod-[PROJECTNAME]-[LAYERNAME]"
# set :myapp_infratest_name, 'prod-joe-demo-myapp'

