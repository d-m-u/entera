class CollegesController < ApplicationController
  def index
  end

  def search
    colleges = find_college(params[:college])
    if colleges['results'].empty?
      flash[:alert] = 'College not found'
      return render action: :index
    end
    @colleges = colleges['results']
  end

  private

  def request_api(url)
    response = Excon.get(url)

    return nil if response.status != 200
    JSON.parse(response.body)
  end

  def find_college(name)
    request_api(
      "https://api.data.gov/ed/collegescorecard/v1/schools.json?school.name=#{ERB::Util.url_encode(name)}&fields=id,school.name,location.lat,location.lon&api_key=#{COLLEGE_SCORECARD_API_KEY}"
    )
  end
end
