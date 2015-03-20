object @member
attributes :id, :board_id, :member_id, :admin

child :member do
  attributes :id, :username, :email, :full_name, :bio, :gravatar_url
end
