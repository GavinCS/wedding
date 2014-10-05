class MailTemplate < ActiveRecord::Base
  
  before_create :sanitize_name
  before_update :sanitize_name
  
  def sanitize_name
    self.template = self.name.parameterize('_')
  end
end
