module ActAsCountable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # define all the class methods here.
    # this method returns total records array in last 30 days. Something like: [10, 40, 70, 90....]
    def total_records_counts_array_in_past_n_days(range = 30.days)
      total_records = []
      counts = self.group('Date(created_at)').count
      (30.days.ago.to_date..Date.today).each do |day|
        total_records.push(total_records.sum (counts[day] || ))
      end
      total_records
    end
    # this method returns total daily news records array in last 30 days. Something like: [10, 2, 40, 15....]
    def daily_records_counts_array_in_past_n_days(range = 30.days)
      counts = self.group('Date(created_at)').count
      (range.ago.to_date..Date.today).map {|date| counts[date] || }
    end
  end
end