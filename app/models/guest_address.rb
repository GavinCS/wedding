class GuestAddress < ActiveRecord::Base
  belongs_to :guest, :foreign_key => 'guest_id'
  belongs_to :country, :foreign_key => 'country_id'
end
