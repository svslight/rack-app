class TimeService
    
  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(formats)
    @formats = formats['format'] ? formats['format'].split(',') : []
  end

  def success?
    unknown_formats.empty? && @formats.any?
  end

  def result
    if success?
      [Time.now.strftime(time_params)]
    else
      ["Unknown time format [#{@unknown_formats.join(", ")}]"]
    end
  end

  private

  def time_params
    FORMATS.values_at(*@formats).join('-')
  end

  def unknown_formats
    @unknown_formats ||= @formats - FORMATS.keys
  end
end
  