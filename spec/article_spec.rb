require "spec_helper"

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
            erick = Author.new("Erick")
            standard = Magazine.new("Standard", "standard")
            articleOne = Article.new(erick, standard, "Newsletter")

            expect(Article.all).to be_a(Array)
            expect(Article.all).to all(be_a(Article))
            expect(Article.all == [articleOne]).to be_truthy
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
            expect(erick.articles.size).to eq(3)
            expect(erick.articles == [a1, a2, a3]).to be_truthy
        end

        # it "returns an array of articles" do
        #     erick = Author.new("Erick")
        #     standard = Magazine.new("Standard", "standard")
        #     articleOne = Article.new(erick, standard, "Newsletter")

        #     expect(Article.all).to be_a(Array)
        #     expect(Article.all).to all(be_a(Article))
        #     expect(Article.all == [articleOne]).to be_truthy
        # end
    end
end