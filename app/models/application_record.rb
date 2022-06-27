class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  after_destroy_commit { broadcast_remove_to 'wallets' }
end
