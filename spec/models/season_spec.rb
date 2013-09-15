require 'spec_helper'

describe Season do
  let(:season) { FactoryGirl.create(:season) }

  subject { season }

  it { should be_valid }

  describe "Basic Functionalities" do
    it { should respond_to(:year) }
    it { should respond_to(:athletes) }
    it { should respond_to(:team_rosters) }
  end

  describe "validations" do
    describe "year must be unique" do
      let!(:season) { FactoryGirl.create(:season, year: 2013) }
      let!(:season_copy) { FactoryGirl.build(:season, year: 2013) }

      it "should invalidate the non-unique year" do
        season.should be_valid
        season_copy.should_not be_valid
      end
    end
  end

  describe "athletes and team_rosters" do
    it "should have no athlets by default" do
      season.athletes.should be_empty
    end

    it "should have no team_rosters by default" do
      season.team_rosters.should be_empty
    end

    describe "after creating some athletes and team rosters" do
      let!(:athlete1) { FactoryGirl.create(:athlete) }
      let!(:athlete2) { FactoryGirl.create(:athlete) }
      let!(:athlete3) { FactoryGirl.create(:athlete) }
      let!(:athletes) { [athlete1, athlete2, athlete3] }
      let!(:team_roster1) { FactoryGirl.create(:team_roster, season: season, athlete: athlete1) }
      let!(:team_roster2) { FactoryGirl.create(:team_roster, season: season, athlete: athlete2) }
      let!(:team_roster3) { FactoryGirl.create(:team_roster, season: season, athlete: athlete3) }
      let!(:team_rosters) { [team_roster1, team_roster2, team_roster3] }

      specify "season#athletes should return a list of the season's athletes" do
        athletes.each do |athlete|
          season.athletes.should include(athlete)
        end
      end

      specify "season#team_rosters should return a list of the season's team_rosters" do
        team_rosters.each do |roster|
          season.team_rosters.should include(roster)
        end
      end
    end
  end
end