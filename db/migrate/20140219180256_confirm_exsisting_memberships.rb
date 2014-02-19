class ConfirmExsistingMemberships < ActiveRecord::Migration
  def change
    Membership.all.each{ |m| m.update_attribute(:confirmed, true) }
  end
end
