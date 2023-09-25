class Student < ActiveRecord::Base

    has_many :traces, -> { order(created_at: :desc) }

    # getting the last trace order_by updated_at to get the last one done
    def last_trace
        traces.first
    end

    def last_activity
        begin
            last_activity =  Activity.find(last_trace.activity_id)
        rescue => exception
            raise StandardError.new "error when getting last_activity"
        end
    end

end