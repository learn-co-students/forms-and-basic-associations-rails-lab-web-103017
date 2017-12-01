require 'pry'
class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name
    if self.genre
      self.genre.name
    end
  end

  def genre_name=(rename)
    genre = Genre.find_or_create_by(name: rename)
    self.genre = genre
  end

  def artist_name
    if self.artist
      self.artist.name
    end
  end

  def artist_name=(rename)
    artist = Artist.find_or_create_by(name: rename)
    self.artist = artist
  end

  def note_contents
    self.notes.collect { |note| note.content}

  end

  def note_contents=(newcontents)
    newcontents.each do |newcontent|
      if newcontent.length > 0
        newnote = Note.find_or_create_by(content: newcontent)
        self.notes << newnote
      end
    end
  end

end
