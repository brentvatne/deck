module DeckApp
  class Deck
    include DataMapper::Resource

    belongs_to :user
    has n,     :slides

    property :id,   Serial
    property :name, String, :unique => true

    def create_slide(content)
      slide = slides.create(:content => content, :number => number_of_slides + 1)
      slides << slide
      save
    end

    def number_of_slides
      (slides.max(:number) || 0)
    end

    def slides
      super.all(:order => [ :number.asc ])
    end

    # Terribly inefficient but I don't care right now
    # Will need to do some kind of query like update all where
    # number > new_position so number = number + 1
    def update_slide_position(slide, new_position)
      return unless slides.include?(slide)

      until new_position == slide.number
        if slide.number > new_position
          move_slide_left(slide)
        else
          move_slide_right(slide)
        end
      end
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

    def delete_slide(slide)
      # move every slide to the right of this number to number - 1
      slide_number = slide.number
      number_of_slides_before_deleting = number_of_slides
      slide.destroy

      i = slide_number + 1

      while i <= number_of_slides_before_deleting
        slide = slides.first(:number => i)
        slide.number = slide.number - 1
        slide.save
        i = i + 1
      end
    end
  end
end
