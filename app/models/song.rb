class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes


  def note_contents
    self.notes.map { |n| n.content  }
  end

  def note_contents=(note_array)
    note_array.each do |note|
      unless note.empty?
        self.notes << Note.find_or_create_by(content: note)
      end
    end
    self.save
  end

  def artist_name
    unless self.artist.nil?
      self.artist.name
    end
  end

  def artist_name=(input_name)

    self.artist = Artist.find_or_create_by(name: input_name)
    self.save

  end

  def genre_name
    self.genre.name
  end

  def genre_name=(input_name)
    my_genre = Genre.find_or_create_by(name: input_name)
    self.genre = my_genre
    self.save
  end

end
