class Guest <ApplicationRecord
  belongs_to :hotel

  def self.select_spanish_speakers
    Guest.where(spanish_speaker: true)
  end

  def boolean_print(params)
    if params[:Spanish] == nil 
      self.spanish_speaker = "false"
    else 
      self.spanish_speaker = "true"
    end
  end
end