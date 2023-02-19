require "spec_helper"

# Test data
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