class ActivityService

    attr_reader :student, :request_params, :last_activity

    def self.get_next_activity(student)
        new(student).get_next_activity
    end

    def initialize(student)
        #debugger
        @student = student
        @last_activity = student.last_activity
        @request_params = init_request_params
    end

    def get_next_activity
        last_trace  = student.last_trace

        return first_activity unless last_trace.present?

        last_score = last_trace.score
        begin 
            activity_criteria = get_default_criteria
        rescue Errors::NoMicrophoneError
            raise
        end

        if 1 == last_score
            next_activity = activity_criteria.where("id > ? ", last_activity.id).first
        else
            next_activity = activity_criteria.where("level < ?", last_activity.level).first
        end

        next_activity || last_activity

    end

    def init_request_params
        NextActivityRequestParams.new(student.language, last_activity.activity_type, !student.has_microphone)
    end

    def get_default_criteria
        criteria = Activity.where(language: @request_params.language)

        #debugger
        if @request_params.reading_not_allowed
            criteria = criteria.where("activity_type NOT LIKE ?", "%reading%")
            raise Errors::NoMicrophoneError.new("no activity without reading", 500) unless criteria.present?
        end

        criteria_with_activity_type = criteria.where("activity_type <> ?", @request_params.activity_type)
        if  criteria_with_activity_type.present?
            criteria_with_activity_type
        else
            criteria
        end
    end

    def first_activity
        Activity.first
    end
end