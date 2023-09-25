require 'rails_helper'

RSpec.describe "Students", type: :request do
  describe "GET /index" do
    let(:fake_response){{status: :ok}}
    
    before do
      get '/api/students'
    end
    
    it 'returns fake_response' do
      expect(json.to_json).to eq(fake_response.to_json)
    end
    
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET /:id/next_activity" do
    let!(:student){create(:student, id: 1)}
    let(:level){1}
    let(:level_lower){0}
    let(:language){"en"}
    let(:score){1}
    let!(:activity){create(:activity, id: 1, language: "en", level: level)}
    let!(:next_activity_found){create(:activity, id: 2, language: language, level: level_lower)}
    let!(:trace){create(:trace, updated_at: Time.now, score: score, student_id: student&.id, activity_id: 1)}
    
    before do
      allow(trace).to receive(:activity_id).and_return(1)
      allow(student).to receive(:last_trace).and_return(trace)
      allow(student).to receive(:last_activity).and_return(activity)
      get "/api/students/1/next_activity"
    end
    
    context 'when score is 1' do
      it 'return next activity' do
        expect(json["id"]).to eq(next_activity_found.id)
        expect(json["activity_type"]).to eq(next_activity_found.activity_type)
      end
    end

    context 'when score is lower than 1' do
      let(:score){0.25}
      
      context 'when there is a lower activity' do 

        it 'return next activity' do
          expect(json["id"]).to eq(next_activity_found.id)
          expect(json["activity_type"]).to eq(next_activity_found.activity_type)
        end

      end

      context 'when there is no lower activity' do

        let(:level_lower){2}

        it 'return next activity' do
          expect(json["id"]).to eq(activity.id)
          expect(json["activity_type"]).to eq(activity.activity_type)
        end

      end
    end

    context 'when language is not the same' do
      let(:language){"fr"}
      
      it 'return next activity' do
        expect(json["id"]).to eq(activity.id)
        expect(json["activity_type"]).to eq(activity.activity_type)
      end
    end

    context 'when student is not found' do
      let(:student){create(:student, id: 2)}
      
      it 'return next activity' do
        expect(json.to_json).to eq({error: "student not found"}.to_json)
      end

      it 'return next activity' do
        expect(response).to have_http_status(404)
      end
    end
    
    
  end
  
end
