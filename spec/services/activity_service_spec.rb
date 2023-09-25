require 'rails_helper'

describe ActivityService do

    let!(:student){create(:student, id: 1, language: "en")}
    let(:score){1}
    let(:level){1}
    let!(:activity){create(:activity, id: 1, language: "en", level: level , activity_type: "reading_some_type")}
    let!(:trace){create(:trace, updated_at: Time.now, score: score, student_id: student&.id, activity_id: 1)}
    let(:request_params){NextActivityRequestParams.new(student.language, activity.activity_type, !student.has_microphone)}

    let(:service){ActivityService.new(student)}

    describe 'next_activity' do
        let(:level_lower){0}
        let(:language){"en"}
        let!(:next_activity_found){create(:activity, id: 2, language: language, level: level_lower)}

        subject(:get_next_activity){service.get_next_activity}

        before(:each) do
            allow(trace).to receive(:activity_id).and_return(1)
            allow(student).to receive(:last_trace).and_return(trace)
            allow(student).to receive(:last_activity).and_return(activity)
        end

        context 'when ther is no trace' do
            before(:each) do
                allow(student).to receive(:last_trace).and_return(nil)
            end

            it 'retrurn first activity' do
                expect(get_next_activity).to eq(activity)
            end
        end

        it 'return activity with next id' do
            expect(get_next_activity).to eq(next_activity_found)
        end

        context 'when score is lower than 1' do
            let(:score){0.25}
            
            context 'when there is a lower activity' do 
                it 'return next activity' do
                    expect(get_next_activity).to eq(next_activity_found)
                end
            end

            context 'when there is no lower activity' do 
                let(:level_lower){2}
                it 'return next activity' do
                    expect(get_next_activity).to eq(activity)
                end
            end
        end
        
    end

    describe "get_default_criteria" do
        let(:activity_type){"reading_some_other_type"}
        let!(:activity1){create(:activity, id: 2, language: "en", activity_type: "reading_some_type")}
        let!(:another_activity){create(:activity, id: 3, language: "en", activity_type: activity_type)}
        let!(:another_activity2){create(:activity, id: 4, language: "en", activity_type: activity_type)}

        subject(:get_default_criteria){service.get_default_criteria}

        context 'there is activities with another type' do
            it 'return the two activities found' do
                expect(get_default_criteria.count).to eq(2)
            end
        end

        context 'there is no activities with another type' do
            let(:activity_type){"reading_some_type"}
            # fallback to algo level 1 (default_criteria)
            it 'return the all activities with sam laguage ' do
                expect(get_default_criteria.count).to eq(4)
            end
        end

        context 'when student has no microphone' do
            before(:each) do
                allow(student).to receive(:has_microphone).and_return(false)
            end

            it 'raise NoMicrophoneError' do
                expect { get_default_criteria }.to raise_error(Errors::NoMicrophoneError)
            end
        end

    end

end