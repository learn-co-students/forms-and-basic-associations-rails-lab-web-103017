class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes


  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    if self.genre
      self.genre.name
    end
  end

  def artist_name=(name)
    new_a = Artist.find_or_create_by(name: name)
    self.artist = new_a
  end

  def artist_name
    if self.artist
      self.artist.name
    end
  end



  def note_contents=(notes)
    new_notes = notes.reject(&:empty?)

    new_notes.map do |content|
      new_n = Note.find_or_create_by(content: content)
      if !self.notes.include?(new_n)
        self.notes << new_n
      end
    end
  end

  def note_contents
    self.notes.map do |n|
      n.content
    end
  end


end
