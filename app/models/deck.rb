module DeckApp
  class Deck
    include DataMapper::Resource

    belongs_to :user
    has n,     :slides

    property :id,   Serial
    property :name, String, :unique => true

    def create_slide(content)
      slide = Slide.create(:content => content, :number => next_number)
      slides << slide
      save
    end

    def next_number
      (slides.max(:number) || 0) + 1
    end

    def slides
      super.all(:order => [ :number.asc ])
    end

    def move_slide_left(slide)
      unless slide == slides.first
        swap_slides(slide, slides.first(:number => slide.number - 1))
      end
    end

    def move_slide_right(slide)
      unless slide == slides.last
        swap_slides(slide, slides.first(:number => slide.number + 1))
      end
    end

    def swap_slides(first_slide, second_slide)
      first_number  = first_slide.number
      second_number = second_slide.number

      first_slide.number  = second_number
      second_slide.number = first_number

      # should be a transaction
      first_slide.save
      second_slide.save
    end

    def delete_slide
      # move the numbers accordingly
    end
  end
end
