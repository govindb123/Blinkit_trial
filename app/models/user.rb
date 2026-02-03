class User < ApplicationRecord
	ROLES = %w[customer seller rider]

	validates :role, inclusion: { in: ROLES }
end
