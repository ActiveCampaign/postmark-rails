require 'spec_helper'

RSpec.describe PostmarkRails::TemplatedMailer do
  subject(:message) { mailer.test_message }

  shared_examples_for 'templated message' do |template_alias, model|
    it { is_expected.to be_templated }
    specify { expect(message.template_alias).to eq(template_alias) }
    specify { expect(message.template_model).to eq model }
    specify { expect(message.subject).to eq "Postmark Template: #{template_alias.inspect}" }
    specify { expect(message.body_text).to include(template_alias.inspect) }
    specify { expect(message.body_text).to include(JSON.pretty_generate(model || {})) }
  end

  context 'when template is not specified' do
    let(:mailer) do
      make_mailer(described_class) do
        def test_message
          mail :from => 'sender@postmarkapp.com', :to => 'recipient@postmarkapp.com'
        end
      end
    end

    it_behaves_like 'templated message', 'test_message'
  end

  context 'when template is specified' do
    let(:mailer) do
      make_mailer(described_class) do
        def test_message
          mail :from => 'sender@postmarkapp.com',
               :to => 'recipient@postmarkapp.com',
               :postmark_template_alias => 'custom_template'
        end
      end
    end

    it_behaves_like 'templated message', 'custom_template'
  end

  context 'when template model is specified' do
    let(:mailer) do
      make_mailer(described_class) do
        def test_message
          self.template_model = { :foo => 'bar' }
          mail :from => 'sender@postmarkapp.com',
               :to => 'recipient@postmarkapp.com'
        end
      end
    end

    it_behaves_like 'templated message', 'test_message', :foo => 'bar'
  end

  describe '.default' do
    it 'protects sensitive default headers from being overwritten' do
      %w(subject body content_type).each do |header|
        expect { described_class.default(header => 'foo') }.
          to raise_error(ArgumentError, "Overriding '#{header}' header in a templated mailer is not allowed.")
      end
    end
  end

  describe '#mail' do
    context "when overriding subject" do
      let(:mailer) do
        make_mailer(described_class) do
          def test_message
            mail :subject => 'Subject'
          end
        end
      end

      it 'protects it from being overwritten' do
        expect { mailer.test_message.subject }.
          to raise_error(ArgumentError, "Overriding 'subject' header in a templated mailer is not allowed.")
      end
    end

    context "when overriding body" do
      let(:mailer) do
        make_mailer(described_class) do
          def test_message
            mail :body => 'body'
          end
        end
      end

      it 'protects it from being overwritten' do
        expect { mailer.test_message.body }.
          to raise_error(ArgumentError, "Overriding 'body' header in a templated mailer is not allowed.")
      end
    end

    context "when overriding content_type" do
      let(:mailer) do
        make_mailer(described_class) do
          def test_message
            mail :content_type => 'content_type'
          end
        end
      end

      it 'protects it from being overwritten' do
        expect { mailer.test_message.content_type }.
          to raise_error(ArgumentError, "Overriding 'content_type' header in a templated mailer is not allowed.")
      end
    end
  end
end
