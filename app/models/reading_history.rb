class ReadingHistory < ApplicationRecord
  enum genre: {adventure: 0, sf: 1, art: 2, biography: 3, classics: 4, comedy: 5, crime_suspense: 6, easy_story: 7, history: 8, heart_warming: 9, philosophy: 10, politics: 11, rhyme: 12, sport: 13, short_stories: 14, true_story: 15, manga: 16, love: 17, other: 18}

  belongs_to :user
  belongs_to :book
end
