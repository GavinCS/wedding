# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{glowtech}
role :web, %w{glowtech}
role :db,  %w{glowtech}

set :user, "deployer"

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server 'glowtech', user: "#{fetch(:user)}", roles: %w{web app db}
