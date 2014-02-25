# desc "Explaining what the task does"
# task :fedena_inventory do
#   # Task goes here
# end




namespace :fedena_inventory do
  desc "Install Fedena Inventory Module"
  task :install do
    system "rsync --exclude=.svn -ruv vendor/plugins/fedena_inventory/public ."
  end
end
