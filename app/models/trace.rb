# Table name: traces
#
#  id                         :integer          not null, primary key
#  score                      :integer      not null
#  activity_id                :string(200)
#  student_id                 :int(200)

class Trace < ActiveRecord::Base

end