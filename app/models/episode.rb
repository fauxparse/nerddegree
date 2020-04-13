class Episode < ApplicationRecord
  validates_presence_of :title, allow_blank: false

  scope :latest_first, -> { order(date: :desc) }
  scope :with_audio, -> { where("url IS NOT NULL AND url != ''") }

  before_create :number_episode!, if: :url?

  def to_s
    title
  end

  private

  def number_episode!
    self.number = (Episode.maximum(:number) || 0) + 1
  end
end
