require "spec_helper"

describe 'Classes and Initializers' do
    describe 'Article' do
        it 'is defined' do
            expect(defined?(Article)).to be_truthy
            expect(Article).to be_a(Class)
        end
    
        describe '#initialize' do
            it "takes exactly three arguments" do
                expect(Article.instance_method(:initialize).arity).to eq(3)
            end
        end
    end

    describe 'Author' do
        it 'is defined' do
            expect(defined?(Author)).to be_truthy
            expect(Author).to be_a(Class)
        end
    
        describe '#initialize' do
            it "takes exactly one argument" do
                expect(Article.instance_method(:initialize).arity).to eq(3)
            end
        end
    end

    describe 'Magazine' do
        it 'is defined' do
            expect(defined?(Magazine)).to be_truthy
            expect(Magazine).to be_a(Class)
        end
    
        describe '#initialize' do
            it "takes exactly two arguments" do
                expect(Magazine.instance_method(:initialize).arity).to eq(2)
            end
        end
    end

    erick = david = linet = pulse = daily = standard = nil

    # Test data
    begin
        erick = Author.new("Erick")
        david = Author.new("David")
        linet = Author.new("Linet")

        pulse = Magazine.new("Pulse", "fashion")
        daily = Magazine.new("Daily", "daily")
        standard = Magazine.new("Standard", "standard")

        david.add_article(pulse, "Elections")
        david.add_article(daily, "Sports")
        david.add_article(pulse, "Baba The 6th")

        linet.add_article(pulse, "Sports")
        linet.add_article(pulse, "Sports")

        erick.add_article(pulse, "Elections")
        erick.add_article(pulse, "Sports")
        erick.add_article(pulse, "Baba The 6th")
        erick.add_article(daily, "Justice")
        erick.add_article(standard, "Justice")
    rescue ArgumentError => err
        p "Wrong number of arguments in the #initialize method"
    end
    

    describe 'Article' do
        describe "#all" do
            it "defines a class method Article.all" do
                expect(Article).to respond_to(:all)
            end
    
            it "returns an array of articles" do
    
                expect(Article.all).to be_a(Array)
                expect(Article.all).to all(be_a(Article))
                expect(Article.all.length == 10).to be_truthy
            end
        end
    end

    describe 'Magazine' do
        describe "Magazine.all" do
            it "method is defined" do
                expect(Magazine).to respond_to(:all)
            end
    
            it "returns an array of all Magazines" do
                expect(Magazine.all).to be_a(Array)
                expect(Magazine.all).to all(be_a(Magazine))
                expect(Magazine.all.size).to eq(3)
            end
        end
    
        describe "#contributors" do
            it "method is defined" do
                expect(pulse).to respond_to(:contributors)
            end
            it "returns a unique array of all contributors of this magazine" do
                expect(pulse.contributors).to be_a(Array)
                expect(pulse.contributors).to all(be_a(Author))
                expect(pulse.contributors.size).to eq(3)
                expect(pulse.contributors.map { |au| au.name }).to eq(["David","Linet","Erick"])
    
                expect(daily.contributors).to be_a(Array)
                expect(daily.contributors).to all(be_a(Author))
                expect(daily.contributors.size).to eq(2)
                expect(daily.contributors.map { |au| au.name }).to eq(["David","Erick"])
    
                expect(standard.contributors).to be_a(Array)
                expect(standard.contributors).to all(be_a(Author))
                expect(standard.contributors.size).to eq(1)
                expect(standard.contributors.map { |au| au.name }).to eq(["Erick"])
            end
        end

        describe 'Author' do
            describe "#articles" do
                it "method is defined" do
                    expect(erick).to respond_to(:articles)
                end
        
                it "returns an array of Article instances the author has written" do
                    expect(erick.articles).to be_a(Array)
                    expect(erick.articles).to all(be_a(Article))
                    expect(erick.articles.size).to eq(5)
                end
            end
        
            describe "#magazines" do
                it "method is defined" do
                    expect(erick).to respond_to(:magazines)
                end
                it "returns a unique array of Magazine instances for which the author has contributed to" do
                    expect(erick.magazines).to be_a(Array)
                    expect(erick.magazines).to all(be_a(Magazine))
                    expect(erick.magazines.size).to eq(3)
                end
            end
        
            describe "#add_article" do
                it "method is defined" do
                    expect(erick).to respond_to(:magazines)
                end
        
                it "takes exactly two arguments" do
                    expect(Author.instance_method(:add_article).arity).to eq(2)
                end
        
                it "returns a unique array of Magazine instances for which the author has contributed to" do
                    erick.add_article(pulse, "Fash")
                    expect(erick.articles.size).to eq(6)
                end
            end
        
            describe "#topic_areas" do
                it "method is defined" do
                    expect(erick).to respond_to(:topic_areas)
                end
        
                it "returns a unique array of strings with the categories of the magazines the author has contributed to" do
                    expect(erick.topic_areas).to eq(["fashion", "daily", "standard"])
                    expect(linet.topic_areas).to eq(["fashion"])
                    expect(david.topic_areas).to eq(["fashion", "daily"])
                end
            end
        end
    
        describe "Magazine.find_by_name" do
            it "method is defined" do
                expect(Magazine).to respond_to(:find_by_name)
            end
    
            it "takes one arguments" do
                expect(Magazine).to respond_to(:find_by_name).with(1).argument
            end
    
            it "given a string of magazine's name, returns the first magazine object that matches" do
                expect(Magazine.find_by_name("Pul")).to eq(nil)
                expect(Magazine.find_by_name("Pulse").name).to eq("Pulse")
                expect(Magazine.find_by_name("Daily").name).to eq("Daily")
            end
        end
    
        describe "#article_titles" do
            it "method is defined" do
                expect(pulse).to respond_to(:article_titles)
            end
    
            it "returns an array of strings of the titles of all articles written for that magazine" do
                expect(pulse.article_titles).to eq(["Elections", "Baba The 6th", "Sports", "Sports", "Elections", "Sports", "Baba The 6th", "Fash"])
                expect(daily.article_titles).to eq(["Sports", "Justice"])
                expect(standard.article_titles).to eq(["Justice"])
            end
        end
    
        describe "#contributing_authors" do
            it "method is defined" do
                expect(pulse).to respond_to(:contributing_authors)
            end
    
            it "returns an array of authors who have written more than 2 articles for the magazine" do
                expect(pulse.contributing_authors.map { |au| au.name }).to eq(["Erick"])
                expect(daily.contributing_authors.map { |au| au.name }).to eq([])
                expect(standard.contributing_authors.map { |au| au.name }).to eq([])
            end
        end
    end
end
