require 'spec_helper'

describe(Jekyll::Converters::Opal) do
  let(:bogus_opal)  { "hi.there( oatmeal" }
  let(:simple_opal) { "puts 'ohai jekyll'" }
  let(:simple_js_output) do
    <<-JS
/* Generated by Opal 0.8.1 */
(function(Opal) {
  Opal.dynamic_require_severity = "error";
  var self = Opal.top, $scope = Opal, nil = Opal.nil, $breaker = Opal.breaker, $slice = Opal.slice;

  Opal.add_stubs(['$puts']);
  return self.$puts("ohai jekyll")
})(Opal);
JS
  end

  it "matches .opal files" do
    expect(subject.matches(".opal")).to be_truthy
  end

  it "outputs .js" do
    expect(subject.output_ext("ANYTHING AT ALL")).to eql(".js")
  end

  it "converts Ruby into Opal" do
    expect(subject.convert(simple_opal)).to eql(simple_js_output)
  end

  it "explodes on bad input" do
    expect(->{ subject.convert(bogus_opal) }).to raise_error(RuntimeError)
  end

end
