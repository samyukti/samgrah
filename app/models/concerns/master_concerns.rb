module MasterConcerns
  extend ActiveSupport::Concern

  def lock
    self.active = false
    save
  end

  def lock!
    self.active = false
    save!
  end

  def unlock
    self.active = true
    save
  end

  def unlock!
    self.active = true
    save!
  end

  def archive
    self.archived = true
    save
  end

  def archive!
    self.archived = true
    save!
  end

  def unarchive
    self.archived = false
    save
  end

  def unarchive!
    self.archived = false
    save!
  end
end
