ThinkingSphinx::Index.define :user, :with => :active_record do
  indexes subject, :sortable => true
  indexes content
  indexes user(:name), :as => :user, :sortable => true

  has user_id, created_at, updated_at
end