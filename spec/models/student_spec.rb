require 'rails_helper'

describe Student do

    let(:student){create(:student)}

    describe 'last_trace' do
        let(:trace1){build(:trace, updated_at: Time.now)}
        let(:trace2){build(:trace, updated_at: Time.now - 2.hours)}

        subject(:last_trace){ student.last_trace}

        before(:each) do
            allow(student).to receive(:traces).and_return([trace1, trace2])
        end

        it "return last trace" do
            expect(last_trace).to eq(trace1)
        end
    end

    describe "last_activity" do
        let(:trace){build(:trace)}
        let(:activity){build(:activity)}
        let(:activities){[activity]}

        subject(:last_activity){ student.last_activity}

        before(:each) do 
            allow(student).to receive(:last_trace).and_return(trace)
            #allow(Activity).to receive(:find).and_return(activity)
        end

        context 'when there is an activity' do 
            before(:each) do 
                allow(Activity).to receive(:find).and_return(activity)
            end
            
            it 'resturn activity' do
                expect(last_activity).to eq(activity)
            end
        end
        

        context 'whenther is no activity found' do
            let(:activities){[]}

            it 'raise standardError' do
                expect { last_activity }.to raise_error(StandardError)
            end
        end
    end
end