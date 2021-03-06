class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    # self.try(:genre).try(:name)
    self.genre.name
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.try(:artist).try(:name)
    # self.artist.name
  end

  def note_contents=(content)
    no_blanks_array = content.reject(&:empty?)
    no_blanks_array.each do |message|
      self.notes << Note.find_or_create_by(content: message)
    end
  end

  def note_contents
    self.notes.map(&:content)
  end
end
