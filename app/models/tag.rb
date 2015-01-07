class Tag < ActiveRecord::Base
  has_and_belongs_to_many :articles, -> { where enable: true }

  class << self
    def add_mul_increment(tags=[])
      result_tags=[]
      tags[0...5].each do |tag|
        _tag= Tag.find_by(title: tag)
        _tag= Tag.create! title: tag unless _tag
        result_tags.push _tag
      end
      result_tags
    end
  end
end