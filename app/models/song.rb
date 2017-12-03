class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes


  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    if self.artist
      self.artist.name
    end
  end

  def genre_name
    self.genre.name
  end

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def note_contents
    self.notes.map do |note|

      note.content
    end
  end

  def note_contents=(contents)
    # contents.reject! { |e| e.to_s.empty? }
    contents.each do |content|
      if content.strip != ""
        self.notes.build(content: content)
      end
    end

  end
end
