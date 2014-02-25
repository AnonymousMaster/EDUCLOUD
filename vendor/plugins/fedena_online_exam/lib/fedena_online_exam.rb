# FedenaOnlineExam

Student.send  :has_many,:transport_fees, :as => 'receiver'



class FedenaOnlineExam
  def self.application_layout_header
    "layouts/online_exam"
  end

end

class Student
  def available_online_exams
    server_time = Time.now
    server_time_to_gmt = server_time.getgm
    local_tzone_time = server_time
    time_zone = Configuration.find_by_config_key("TimeZone")
    unless time_zone.nil?
      unless time_zone.config_value.nil?
        zone = TimeZone.find(time_zone.config_value)
        if zone.difference_type=="+"
          local_tzone_time = server_time_to_gmt + zone.time_difference
        else
          local_tzone_time = server_time_to_gmt - zone.time_difference
        end
      end
    end
    exams = OnlineExamGroup.find_all_by_batch_id(self.batch_id, :conditions=> "end_date >= '#{local_tzone_time.to_date}' and start_date <= '#{local_tzone_time.to_date}' and is_published = '1'")
    exams.reject {|e| OnlineExamAttendance.exists?( :student_id => self.id, :online_exam_group_id=>e.id)}
  end
end

ActionController::Base.send(:include, Tinymce::Hammer::ControllerMethods)
ActionView::Base.send(:include, Tinymce::Hammer::ViewHelpers)
ActionView::Helpers::FormBuilder.send(:include, Tinymce::Hammer::BuilderMethods)



#
