class Event < ActiveRecord::Base
  attr_accessible :date, :description, :location, :name

  # define membership many-to-many relation
  has_many :memberships, :dependent => :destroy
  has_many :members, :through => :memberships

	def joined?(member)
		return false if member.nil?
	  memberships.find_by_member_id(member.id)
	end

  def members_count
    members.size
  end

  def joined member
    membership = self.memberships.build(member_id: member.id)
    membership.save
    save
  end

  def remove_member member
    self.members.delete member
    save
  end

end
