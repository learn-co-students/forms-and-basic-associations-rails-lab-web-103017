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

  def note_contents=(notes)
    notes.each do |content|
      note = Note.create(content: content)
      self.notes << note
    end
  end

  def note_contents
    self.notes.select do |note|
      !note.content.empty?
    end.map {|note| note.content}
  end

  def note_contents
    self.notes.inject(Array.new) do |array, note|
      # tracker = first note; note = second note
      array << note.content if !note.content.empty?
      array
    end
  end

  def genre_name=(genre)
    self.genre = Genre.create(name: genre)
  end

  def genre_name
    self.genre.name
  end

end
