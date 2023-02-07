class Guest <ApplicationRecord
  belongs_to :hotel

  def self.select_spanish_speakers
    Guest.where(spanish_speaker: true)
  end

  def self.search(params)
    @guests = []
    if find_by(name: params[:searchtext]) != nil
      @guests << find_by(name: params[:searchtext])
    else 
      @guests = where("name LIKE ?", "%#{params[:searchtext]}%")
    end
    return @guests
  end 

end