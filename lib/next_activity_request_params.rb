class NextActivityRequestParams 

    attr_accessor :language, :activity_type, :reading_not_allowed, :skill

    def initialize(language, activity_type, reading_not_allowed=nil, skill=nil)
        @language = language
        @activity_type = activity_type
        @reading_not_allowed = reading_not_allowed
        @skill = skill
    end

end